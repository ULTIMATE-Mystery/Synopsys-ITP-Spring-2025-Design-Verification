`timescale 1ns/1ns
  
// This is the main module for the demonstration implementation of IEEE-754 floating point multiplication. It can be
// instantiated to perform multiplication on FP16, FP32 or FP64 floating point numbers by specifying the value of the
// SIZE parameter as 16, 32 or 64.
//
typedef struct packed{
   int MANT_WIDTH;
   int SIGN;
   int EXP_H;
   int EXP_L;
   int MANT_H;
   int SNAN_LOC;
   int QNAN_LOC;
   int BIAS;
   int GUARD;
   int ROUND;
   int STICKY;
   } const_t;

function const_t convert(int value);
   const_t rtn;
   if(value == 16)begin
      rtn.MANT_WIDTH = 11;
      rtn.SIGN = 15;
      rtn.EXP_H = 14;
      rtn.EXP_L = 10;
      rtn.MANT_H = 9;
      rtn.SNAN_LOC = 9;
      rtn.QNAN_LOC = 8;
      rtn.BIAS = 15;
      rtn.GUARD = 9;
      rtn.ROUND = 8;
      rtn.STICKY = 7;
   end
   else if(value == 32)begin
      rtn.MANT_WIDTH = 24;
      rtn.SIGN = 31;
      rtn.EXP_H = 30;
      rtn.EXP_L = 23;
      rtn.MANT_H = 22;
      rtn.SNAN_LOC = 22;
      rtn.QNAN_LOC = 21;
      rtn.BIAS = 127;
      rtn.GUARD = 22;
      rtn.ROUND = 21;
      rtn.STICKY = 20;
   end
   else if(value == 64) begin
      rtn.MANT_WIDTH = 53;
      rtn.SIGN = 63;
      rtn.EXP_H = 62;
      rtn.EXP_L = 52;
      rtn.MANT_H = 51;
      rtn.SNAN_LOC = 51;
      rtn.QNAN_LOC = 50;
      rtn.BIAS = 1023;
      rtn.GUARD = 51;
      rtn.ROUND = 50;
      rtn.STICKY = 49;
   end
   else begin
      rtn.SIGN = 0;
      rtn.EXP_H = 0;
      rtn.EXP_L = 0;
      rtn.MANT_H = 0;
      rtn.SNAN_LOC = 0;
      rtn.QNAN_LOC = 0;
      rtn.BIAS = 0;
      rtn.GUARD = 0;
      rtn.ROUND = 0;
      rtn.STICKY = 0;
   end
   return rtn;
endfunction

module fmul
  #(parameter SIZE = 32)
   (
    output logic [SIZE-1:0] product,
    output logic [4:0]      exceptions,
    output logic            valid,
    input logic             go,
    input logic [SIZE-1:0]  multiplier,
    input logic [SIZE-1:0]  multiplicand,
    input logic [1:0]       rounding_mode,
    input logic             clock,
    input logic             resetN
    );

   // Define the encodings for rounding mode - these match the values specified in the SoftFloat documentation.
   //
   localparam ROUND_NEAREST_EVEN = 0;
   localparam ROUND_TO_ZERO = 1;
   localparam ROUND_MINUS_INF = 2;
   localparam ROUND_PLUS_INF = 3;
                                   
   // The following parameters are used to select a bit in the output signal "exceptions" to indicate IEEE-754 exceptions.
   //
   localparam INEXACT = 0;
   localparam UNDERFLOW = 1;
   localparam OVERFLOW = 2;
   localparam INFINITY = 3;
   localparam INVALID = 4;

   // Below, we define a set of constants which allow us to process FP16, FP32 and FP64 numbers in a general way by using
   // these constants to access different parts of the floating point number.
   //
   localparam const_t constants = convert(SIZE);
   localparam MANT_WIDTH = constants.MANT_WIDTH;
   localparam SIGN = constants.SIGN;
   localparam EXP_H = constants.EXP_H;
   localparam EXP_L = constants.EXP_L;
   localparam MANT_H = constants.MANT_H;
   localparam SNAN_LOC = constants.SNAN_LOC;
   localparam QNAN_LOC = constants.QNAN_LOC;
   localparam BIAS = constants.BIAS;
   localparam GUARD = constants.GUARD;
   localparam ROUND = constants.ROUND;
   localparam STICKY = constants.STICKY;
   
   localparam GRS_G = 2;
   localparam GRS_R = 1;
   localparam GRS_T = 0;
   
   //--> Bit positions for bits in mpier/mpcand flags
   //
   localparam ZERO = 0;
   localparam DNORM = 1;
   localparam INF = 2;
   localparam NAN = 3;
   localparam SNAN = 4;
   localparam QNAN = 5;
   
   //--> First pipeline stage
   //
   logic [SIZE-1:0] mpier_0, mpcand_0;
   logic            go_0;
   logic [1:0]      rmode_0;
   
   logic [MANT_WIDTH*2-1:0] product_mantissa_0;
   logic [EXP_H-EXP_L+1:0]    product_exponent_0;
   
   logic [EXP_H-EXP_L+1:0]    mpier_exponent_0;
   logic [MANT_WIDTH-1:0]   mpier_mantissa_0;
   logic [EXP_H-EXP_L+1:0]    mpcand_exponent_0;
   logic [MANT_WIDTH-1:0]   mpcand_mantissa_0;
   logic                    product_sign_0;

   logic [5:0]              mpier_flags_0;
   logic [5:0]              mpcand_flags_0;

   booth4 #(.WIDTH(MANT_WIDTH)) mant_mult
     (
      .product(product_mantissa_0),
      .multiplier(mpier_mantissa_0),
      .multiplicand(mpcand_mantissa_0)
      );

   always_comb begin
      product_sign_0 = mpier_0[SIZE-1] ^ mpcand_0[SIZE-1];

      mpier_exponent_0 = mpier_0[EXP_H:EXP_L];
      if(mpier_exponent_0 == 0)begin
         mpier_mantissa_0 = {1'b0,mpier_0[MANT_H:0]};
         mpier_exponent_0 = 1;
      end
      else begin
         mpier_mantissa_0 = {1'b1,mpier_0[MANT_H:0]};
      end
      
      mpcand_exponent_0 = mpcand_0[EXP_H:EXP_L];
      if(mpcand_exponent_0 == 0)begin
         mpcand_mantissa_0 = {1'b0,mpcand_0[MANT_H:0]};
         mpcand_exponent_0 = 1;
      end
      else begin
         mpcand_mantissa_0 = {1'b1,mpcand_0[MANT_H:0]};
      end
      
      product_exponent_0 = mpier_exponent_0 + mpcand_exponent_0;
      
      mpier_flags_0[SNAN] = &mpier_exponent_0[EXP_H-EXP_L:0] & !mpier_0[SNAN_LOC] & |mpier_0[QNAN_LOC:0];
      mpier_flags_0[QNAN] = &mpier_exponent_0[EXP_H-EXP_L:0] & mpier_0[SNAN_LOC];
      mpier_flags_0[NAN] = mpier_flags_0[SNAN] | mpier_flags_0[QNAN];
      mpier_flags_0[DNORM] = !(|mpier_exponent_0[EXP_H-EXP_L:0]) & |mpier_0[MANT_H:0];
      mpier_flags_0[ZERO] = !(|mpier_0[SIGN-1:0]);
      mpier_flags_0[INF] = &mpier_exponent_0[EXP_H-EXP_L:0] & !(|mpier_0[MANT_H:0]);
      
      mpcand_flags_0[SNAN] = &mpcand_exponent_0[EXP_H-EXP_L:0] & !mpcand_0[SNAN_LOC] & |mpcand_0[QNAN_LOC:0];
      mpcand_flags_0[QNAN] = &mpcand_exponent_0[EXP_H-EXP_L:0] & mpcand_0[SNAN_LOC];
      mpcand_flags_0[NAN] = mpcand_flags_0[SNAN] | mpcand_flags_0[QNAN];
      mpcand_flags_0[DNORM] = !(|mpcand_exponent_0[EXP_H-EXP_L:0]) & |mpcand_0[MANT_H:0];
      mpcand_flags_0[ZERO] = !(|mpcand_0[SIGN-1:0]);
      mpcand_flags_0[INF] = &mpcand_exponent_0[EXP_H-EXP_L:0] & !(|mpcand_0[MANT_H:0]);
   end

   //--> Pipe stage 1
   //   
   logic [MANT_WIDTH*2-1:0] product_mantissa_1, product_mantissa_1a, product_mantissa_1b;
   logic [MANT_WIDTH*2-1:0] rounded_product_mantissa;
   logic [EXP_H-EXP_L+1:0]  product_exponent_1, product_exponent_1a, product_exponent_1b;
   logic [EXP_H-EXP_L:0]    rounded_product_exponent;
   logic                    final_product_sign, product_sign_1;
   logic [5:0]              mpier_flags_1;
   logic [5:0]              mpcand_flags_1;
   logic                    go_1;
   logic [MANT_WIDTH-1:0]   mpier_mantissa_1, mpcand_mantissa_1;
   logic [1:0]              rmode_1;
   logic                    mpier_sign_1, mpcand_sign_1;

   logic [SIZE-1:0]         mpier_1, mpcand_1;         
                   
   logic [SIZE-1:0]         product_1;
   logic [4:0]              exceptions_1;
   logic [2:0]              GRS_bits;
   logic                    bottom_bit, sticky_bit;
   
   logic [7:0]              lz_count_1;

   logic [MANT_WIDTH*2-1:0] mantissa_rounding_adjustment;  // *** TEMPORARY, FOR DEBUG ***
   logic [11:0]             shift_count;
   logic [2*MANT_WIDTH-1:0] mask1, mask2, mask3;
   
   clz #(.WIDTH(MANT_WIDTH*2)) count_product_mantissa_leading_zeros
     (
      .bits(product_mantissa_1a),
      .lz_count(lz_count_1)
      );
   
   always_comb begin
      exceptions_1 = 0;
      GRS_bits = 3'h0;
      sticky_bit = 1'b0;
      bottom_bit = 1'b0;
      
      final_product_sign = product_sign_1;
      product_mantissa_1a = 0;
      
      if(mpier_flags_1[NAN] | mpcand_flags_1[NAN])begin
         if(mpier_flags_1[SNAN])begin
            product_1 = mpier_1;
            exceptions_1[INVALID] = 1'b1;
            product_1[SNAN_LOC] = 1'b1;
         end
         else if(mpcand_flags_1[SNAN])begin
            product_1 = mpcand_1;
            exceptions_1[INVALID] = 1'b1;
            product_1[SNAN_LOC] = 1'b1;
         end
         else if(mpier_flags_1[QNAN])begin
            product_1 = mpier_1;
         end
         else begin
            product_1 = mpcand_1;
         end
      end

      else if((mpier_flags_1[ZERO] & mpcand_flags_1[INF]) | (mpier_flags_1[INF] & mpcand_flags_1[ZERO]))begin
         //
         // 0*Inf, Inf*0 is NaN
         //
         //product_1 = {product_sign_1, {(EXP_H-EXP_L+1){1'b1}},1'b1, {(MANT_WIDTH-2){1'b0}}};
         product_1 = {1'b1, {(EXP_H-EXP_L+1){1'b1}},1'b1, {(MANT_WIDTH-2){1'b0}}};
         exceptions_1[INVALID] = 1'b1;
      end
      
      else if(mpier_flags_1[INF] | mpcand_flags_1[INF])begin
         //
         // Anything non-NaN times infinity = infinity
         //
         product_1 = {product_sign_1, {(EXP_H-EXP_L+1){1'b1}}, {(MANT_WIDTH-1){1'b0}}};
      end
      
      else if(mpier_flags_1[ZERO] | mpcand_flags_1[ZERO])begin
         product_1 = 0;
         product_1[SIZE-1] = product_sign_1;
      end

      else begin
         if(product_mantissa_1[2*MANT_WIDTH-1])begin
            bottom_bit = product_mantissa_1[0];
            product_mantissa_1a = product_mantissa_1 >> 1;
            product_exponent_1a = product_exponent_1 + 1;
         end
         else begin
            bottom_bit = 1'b0;
            product_mantissa_1a = product_mantissa_1;
            product_exponent_1a = product_exponent_1;
         end

         if(product_exponent_1a > (3 * BIAS + lz_count_1))begin
            //
            // The exponent is too big, so force to the largest finite value (which MAY get rounded to infinity later).
            // Also, sticky_bit is unequivocally 1.
            //
            product_mantissa_1b = {(2*MANT_WIDTH){1'b1}};
            product_exponent_1b = {{(EXP_H-EXP_L){1'b1}}, 1'b0} + BIAS;
            sticky_bit = 1'b1;
            exceptions_1[OVERFLOW] = 1'b1;
         end
         else if(product_exponent_1a > (BIAS + lz_count_1))begin
            //
            // This is the right range for a normal number, so shift the mantissa left, and adjust the exponent down.
            //
            product_mantissa_1b = product_mantissa_1a << lz_count_1;
            product_exponent_1b = product_exponent_1a - lz_count_1;
            sticky_bit = |product_mantissa_1b[STICKY:0] | bottom_bit;
         end
         else begin
            product_exponent_1b = BIAS;
            if(product_exponent_1a > BIAS)begin
               product_mantissa_1b = product_mantissa_1a << (product_exponent_1a - BIAS - 1);
               sticky_bit = |product_mantissa_1b[STICKY:0] | bottom_bit;
            end
            else begin
               shift_count = BIAS - product_exponent_1a + 1;
               product_mantissa_1b = product_mantissa_1a >> shift_count;
               mask1 = (~0) << STICKY + 1;
               mask2 = ~(mask1 << shift_count);
               mask3 = mask1 & mask2;
               sticky_bit = (|(mask3 & product_mantissa_1a)) | (|product_mantissa_1a[STICKY:0]) | bottom_bit;
            end
            exceptions_1[UNDERFLOW] = |product_mantissa_1a;
         end

         GRS_bits[GRS_G] = product_mantissa_1b[GUARD];
         GRS_bits[GRS_R] = product_mantissa_1b[ROUND];
         GRS_bits[GRS_T] = sticky_bit;
         case(rmode_1)
           ROUND_NEAREST_EVEN: begin
              mantissa_rounding_adjustment = (GRS_bits[GRS_G] &
                                              (product_mantissa_1b[GUARD+1] | GRS_bits[GRS_R] | GRS_bits[GRS_T])) <<
                                             (MANT_H+1);
              rounded_product_mantissa = product_mantissa_1b + mantissa_rounding_adjustment;
           end
           
           ROUND_TO_ZERO: begin
              rounded_product_mantissa = product_mantissa_1b;
           end
           
           ROUND_PLUS_INF: begin
              mantissa_rounding_adjustment = ((~final_product_sign & |GRS_bits) << (MANT_H+1));
              rounded_product_mantissa = product_mantissa_1b + mantissa_rounding_adjustment;
           end

           ROUND_MINUS_INF: begin
              mantissa_rounding_adjustment = ((final_product_sign & |GRS_bits) << (MANT_H+1));
              rounded_product_mantissa = product_mantissa_1b + mantissa_rounding_adjustment;
           end
         endcase
         if(rounded_product_mantissa[MANT_WIDTH*2-2] ^ product_mantissa_1b[MANT_WIDTH*2-2])
           rounded_product_exponent = product_exponent_1b + 1 - BIAS;
         else
           rounded_product_exponent = product_exponent_1b - BIAS;

         if(&rounded_product_exponent)
           exceptions_1[OVERFLOW] = 1'b1;

         product_1 = {final_product_sign, rounded_product_exponent, rounded_product_mantissa[MANT_WIDTH*2-3:MANT_WIDTH-1]};
         exceptions_1[INEXACT] = GRS_bits[GRS_T] | (|product_mantissa_1b[MANT_WIDTH-2:0]);

         exceptions_1[UNDERFLOW] = exceptions_1[UNDERFLOW] & exceptions_1[INEXACT];
      end
   end
   
   //--> State Machine
   //
   always_ff @(posedge clock or negedge resetN)begin
      if(!resetN)begin
         rmode_0 <= 0;
         go_0 <= 0;
         mpcand_0 <= 0;
         mpier_0 <= 0;

         product_mantissa_1 <= 0;
         product_exponent_1 <= 0;
         product_sign_1 <= 0;
         mpier_flags_1 <= 0;
         mpcand_flags_1 <= 0;
         go_1 <= 0;
         rmode_1 <= 0;

         product <= 0;
         exceptions <= 0;
         valid <= 0;
      end
      else begin
         go_0 <= go;
         if(go)begin
            rmode_0 <= rounding_mode;
            mpcand_0 <= multiplicand;
            mpier_0 <= multiplier;
         end
         else begin
            rmode_0 <= rmode_0;
            mpcand_0 <= mpcand_0;
            mpier_0 <= mpier_0;
         end

         go_1 <= go_0;
         if(go_0)begin
            product_mantissa_1 <= product_mantissa_0;
            product_exponent_1 <= product_exponent_0;
            product_sign_1 <= product_sign_0;
            mpier_flags_1 <= mpier_flags_0;
            mpcand_flags_1 <= mpcand_flags_0;
            rmode_1 <= rmode_0;
            mpier_mantissa_1 <= mpier_mantissa_0;
            mpcand_mantissa_1 <= mpcand_mantissa_0;
            mpier_sign_1 <= mpier_0[SIZE-1];
            mpcand_sign_1 <= mpcand_0[SIZE-1];
            mpier_1 <= mpier_0;
            mpcand_1 <= mpcand_0;
         end
         else begin
            product_mantissa_1 <= product_mantissa_1;
            product_exponent_1 <= product_exponent_1;
            product_sign_1 <= product_sign_1;
            mpier_flags_1 <= mpier_flags_1;
            mpcand_flags_1 <= mpcand_flags_1;
            rmode_1 <= rmode_1;
            mpier_mantissa_1 <= mpier_mantissa_1;
            mpcand_mantissa_1 <= mpcand_mantissa_1;
            mpier_sign_1 <= mpier_sign_1;
            mpcand_sign_1 <= mpcand_sign_1;
            mpier_1 <= mpier_1;
            mpcand_1 <= mpcand_1;
         end

         valid <= go_1;
         if(go_1)begin
            product <= product_1;
            exceptions <= exceptions_1;
         end
         else begin
            product <= product;
            exceptions <= exceptions;
         end
      end
   end // always_ff @

endmodule // fma
