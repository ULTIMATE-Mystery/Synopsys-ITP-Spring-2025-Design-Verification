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

module muladd
  #(parameter SIZE = 32)
   (
    output logic [SIZE-1:0] result,
    output logic [4:0]      exceptions,
    output logic            valid,
    input logic             go,
    input logic [SIZE-1:0]  multiplier,
    input logic [SIZE-1:0]  multiplicand,
    input logic [SIZE-1:0]  addend,
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
   localparam INF = 1;
   localparam DNORM = 2;
   localparam NAN = 3;
   localparam SNAN = 4;
   localparam QNAN = 5;
   
   //--> First pipeline stage
   //
   logic [SIZE-1:0] mpier_0, mpcand_0, addend_0;
   logic            go_0;
   logic [1:0]      rmode_0;
   
   integer                  product_exponent_0;

   logic [MANT_WIDTH*2-1:0] product_mantissa_0;
   logic                    product_sign_0;
   
   integer                  mpier_exponent_0, mpier_exponent_0a;
   integer                  mpcand_exponent_0, mpcand_exponent_0a;
   integer                  addend_exponent_0;

   logic [MANT_WIDTH-1:0]   mpier_mantissa_0, mpier_mantissa_0a;
   logic [MANT_WIDTH-1:0]   mpcand_mantissa_0, mpcand_mantissa_0a;
   logic [MANT_WIDTH-1:0]   addend_mantissa_0;
   logic                    addend_sign_0;
   
   logic [5:0]              mpier_flags_0;
   logic [5:0]              mpcand_flags_0;
   logic [5:0]              addend_flags_0;

   logic [7:0]              mpier_lzc_0, mpcand_lzc_0;
   
   booth4 #(.WIDTH(MANT_WIDTH)) mant_mult
     (
      .product(product_mantissa_0),
      .multiplier(mpier_mantissa_0a),
      .multiplicand(mpcand_mantissa_0a)
      );

   clzmadd #(.WIDTH(MANT_WIDTH), .OFFSET(0)) ct_mpier_lz
     (
      .bits(mpier_mantissa_0),
      .lz_count(mpier_lzc_0)
      );

   clzmadd #(.WIDTH(MANT_WIDTH), .OFFSET(0)) ct_mpcand_lz
     (
      .bits(mpcand_mantissa_0),
      .lz_count(mpcand_lzc_0)
      );
   
   always_comb begin
      mpier_flags_0[SNAN] = &mpier_0[EXP_H:EXP_L] & !mpier_0[SNAN_LOC] & |mpier_0[QNAN_LOC:0];
      mpier_flags_0[QNAN] = &mpier_0[EXP_H:EXP_L] & mpier_0[SNAN_LOC];
      mpier_flags_0[NAN] = mpier_flags_0[SNAN] | mpier_flags_0[QNAN];
      mpier_flags_0[DNORM] = !(|mpier_0[EXP_H:EXP_L]) & |mpier_0[MANT_H:0];
      mpier_flags_0[ZERO] = !(|mpier_0[SIGN-1:0]);
      mpier_flags_0[INF] = &mpier_0[EXP_H:EXP_L] & !(|mpier_0[MANT_H:0]);

      mpcand_flags_0[SNAN] = &mpcand_0[EXP_H:EXP_L] & !mpcand_0[SNAN_LOC] & |mpcand_0[QNAN_LOC:0];
      mpcand_flags_0[QNAN] = &mpcand_0[EXP_H:EXP_L] & mpcand_0[SNAN_LOC];
      mpcand_flags_0[NAN] = mpcand_flags_0[SNAN] | mpcand_flags_0[QNAN];
      mpcand_flags_0[DNORM] = !(|mpcand_0[EXP_H:EXP_L]) & |mpcand_0[MANT_H:0];
      mpcand_flags_0[ZERO] = !(|mpcand_0[SIGN-1:0]);
      mpcand_flags_0[INF] = &mpcand_0[EXP_H:EXP_L] & !(|mpcand_0[MANT_H:0]);

      addend_flags_0[SNAN] = &addend_0[EXP_H:EXP_L] & !addend_0[SNAN_LOC] & |addend_0[QNAN_LOC:0];
      addend_flags_0[QNAN] = &addend_0[EXP_H:EXP_L] & addend_0[SNAN_LOC];
      addend_flags_0[NAN] = addend_flags_0[SNAN] | addend_flags_0[QNAN];
      addend_flags_0[DNORM] = !(|addend_0[EXP_H:EXP_L]) & |addend_0[MANT_H:0];
      addend_flags_0[ZERO] = !(|addend_0[SIGN-1:0]);
      addend_flags_0[INF] = &addend_0[EXP_H:EXP_L] & !(|addend_0[MANT_H:0]);

      product_sign_0 = mpier_0[SIZE-1] ^ mpcand_0[SIZE-1];
      addend_sign_0 = addend_0[SIZE-1];
      
      if(!(|mpier_0[EXP_H:EXP_L]))begin
         mpier_mantissa_0 = {1'b0,mpier_0[MANT_H:0]};
         mpier_exponent_0 = mpier_0[EXP_H:EXP_L] - BIAS + 1;
      end
      else begin
         mpier_mantissa_0 = {1'b1,mpier_0[MANT_H:0]};
         mpier_exponent_0 = mpier_0[EXP_H:EXP_L] - BIAS;
      end
      mpier_mantissa_0a = mpier_mantissa_0 << mpier_lzc_0;
      mpier_exponent_0a = mpier_exponent_0 - mpier_lzc_0;
            
      if(!(|mpcand_0[EXP_H:EXP_L]))begin
         mpcand_mantissa_0 = {1'b0,mpcand_0[MANT_H:0]};
         mpcand_exponent_0 = mpcand_0[EXP_H:EXP_L] - BIAS + 1;
      end
      else begin
         mpcand_mantissa_0 = {1'b1,mpcand_0[MANT_H:0]};
         mpcand_exponent_0 = mpcand_0[EXP_H:EXP_L] - BIAS;
      end
      mpcand_mantissa_0a = mpcand_mantissa_0 << mpcand_lzc_0;
      mpcand_exponent_0a = mpcand_exponent_0 - mpcand_lzc_0;
            
      product_exponent_0 = mpier_exponent_0a + mpcand_exponent_0a;
      
      if(!(|addend_0[EXP_H:EXP_L]))begin
         addend_mantissa_0 = {1'b0,addend_0[MANT_H:0]};
         addend_exponent_0 = addend_0[EXP_H:EXP_L] - BIAS + 1;
      end
      else begin
         addend_mantissa_0 = {1'b1,addend_0[MANT_H:0]};
         addend_exponent_0 = addend_0[EXP_H:EXP_L] - BIAS;
      end
   end

   //--> Pipe stage 1
   //
   // This set of signals comes from the previous clock cycle. The only "trick" is that addend_mantissa_1 is right-
   // shifted to align its radix point with the radix point of the product mantissa.
   //
   logic [SIZE-1:0]         mpier_1, mpcand_1, addend_1;
   logic [5:0]              mpier_flags_1;
   logic [5:0]              mpcand_flags_1;
   logic [5:0]              addend_flags_1;   
   logic                    go_1;
   logic [1:0]              rmode_1;
   
   integer                  product_exponent_1;
   integer                  addend_exponent_1;

   logic [MANT_WIDTH*2-1:0] product_mantissa_1;
   logic                    product_sign_1;

   logic [MANT_WIDTH*2-1:0] addend_mantissa_1;
   logic                    addend_sign_1;

   // These "ulp" signals have been assigned 8 extra bits just for debug convenience. We need 3 bits on the left to
   // accommodate 101.xxxx for the sum and a sign bit, but we use 4 bits so things stay on nibble boundaries. Similarly,
   // we need one extra bit on the right as a sticky bit during addition but isolating that bit in its own nibble makes
   // signals easier to decipher in debug.
   //
   logic [MANT_WIDTH*2+7:0] ulp_product_mantissa_1, ulp_addend_mantissa_1;
   logic [MANT_WIDTH*2+7:0] ulp_sum_mantissa_1, ulp_absum_mantissa_1;

   // These are interim masks used to collect or'ed bits for inclusion into a sticky bit.
   //
   logic [MANT_WIDTH*2-1:0] ulp_mask;
   logic [MANT_WIDTH*2+3:0] norm_mask;
   logic [11:0]             shift_count;
   
   logic [MANT_WIDTH*2+7:0] sum_mantissa_1;
   logic [EXP_H-EXP_L+1:0]  exp_delta_1;

   integer                  sum_exponent_1, norm1_exponent_1;

   logic [MANT_WIDTH*2-1:0] norm1_mantissa_1;

   logic                    result_sign_1;
                   
   logic [SIZE-1:0]         result_1;
   logic [4:0]              exceptions_1;
   logic [2:0]              GRS_bits_1;
   logic                    bottom_bit_1, sticky_bit_1;
   
   logic [7:0]              lz_count_1;

   logic [MANT_WIDTH*2-1:0] mantissa_rounding_adjustment_1;
   logic [MANT_WIDTH*2-1:0] rounded_result_mantissa;
   logic [EXP_H-EXP_L:0]    rounded_result_exponent;
   
   logic [11:0]             shift_count_1;

   clzmadd #(.WIDTH(MANT_WIDTH*2+8), .OFFSET(5)) count_sum_mant_lz
     (
      .bits(ulp_absum_mantissa_1),
      .lz_count(lz_count_1)
      );
   
   always_comb begin
      exceptions_1 = 0;
      ulp_absum_mantissa_1 = 0;

      if(mpier_flags_1[INF] & mpcand_flags_1[INF] & addend_flags_1[INF])begin
         case({mpier_1[SIGN], mpcand_1[SIGN], addend_1[SIGN]})
           3'b000, 3'b110:begin
              result_1 = {1'b0, {(EXP_H-EXP_L+1){1'b1}}, {(MANT_H+1){1'b0}}};
           end
           3'b011, 3'b101: begin
              result_1 = {1'b1, {(EXP_H-EXP_L+1){1'b1}}, {(MANT_H+1){1'b0}}};
           end
           default: begin
              result_1 = {1'b1, {(EXP_H-EXP_L+1){1'b1}}, 1'b1, {(MANT_H){1'b0}}};
              exceptions_1[INVALID] = 1'b1;
           end
         endcase
      end

      else if(mpier_flags_1[ZERO] & mpcand_flags_1[ZERO] & addend_flags_1[INF])begin
         if(addend_sign_1)
           result_1 = {1'b1, {(EXP_H-EXP_L+1){1'b1}}, {(MANT_H+1){1'b0}}};
         else
           result_1 = {1'b0, {(EXP_H-EXP_L+1){1'b1}}, {(MANT_H+1){1'b0}}};
      end

      else if(mpier_flags_1[INF] & mpcand_flags_1[INF] & addend_flags_1[ZERO])begin
         if(mpier_1[SIGN] ^ mpcand_1[SIGN])
           result_1 = {1'b1, {(EXP_H-EXP_L+1){1'b1}}, {(MANT_H+1){1'b0}}};
         else
           result_1 = {1'b0, {(EXP_H-EXP_L+1){1'b1}}, {(MANT_H+1){1'b0}}};
      end

      else if((addend_flags_1[INF] | addend_flags_1[ZERO]) &
              ((mpier_flags_1[ZERO] & mpcand_flags_1[INF]) | (mpier_flags_1[INF] & mpcand_flags_1[ZERO])))begin
         result_1 = {1'b1, {(EXP_H-EXP_L+1){1'b1}}, 1'b1, {(MANT_H){1'b0}}};
         exceptions_1[INVALID] = 1'b1;
      end

      else if(addend_flags_1[INF] &
              ((mpier_flags_1[ZERO] & (!mpcand_flags_1[NAN])) |
               (mpcand_flags_1[ZERO] & (!mpier_flags_1[NAN]))))begin
         // (ZN | NZ) + I => ZERO + INF
         result_1 = addend_1;
      end

      else if(addend_flags_1[ZERO] & ((mpier_flags_1[INF] & (!mpcand_flags_1[NAN])) |
                                      (mpcand_flags_1[INF] & (!mpier_flags_1[NAN]))))begin
         // (IN | NI) + Z => INF + ZERO
         result_1 = {product_sign_1, {(EXP_H-EXP_L+1){1'b1}}, {(MANT_H+1){1'b0}}};
      end

      else if(addend_flags_1[SNAN])begin
         result_1 = addend_1;
         result_1[SNAN_LOC] = 1'b1;
         exceptions_1[INVALID] = 1'b1;
      end

      else if(mpier_flags_1[SNAN])begin
         result_1 = mpier_1;
         result_1[SNAN_LOC] = 1'b1;
         exceptions_1[INVALID] = 1'b1;
      end
         
      else if(mpcand_flags_1[SNAN])begin
         result_1 = mpcand_1;
         result_1[SNAN_LOC] = 1'b1;
         exceptions_1[INVALID] = 1'b1;
      end

      else if((mpier_flags_1[ZERO] & mpcand_flags_1[INF]) | (mpier_flags_1[INF] & mpcand_flags_1[ZERO]))begin
         // (ZI | IZ} + N
         result_1 = {1'b1, {(EXP_H-EXP_L+1){1'b1}}, 1'b1, {MANT_H{1'b0}}};
         exceptions_1[INVALID] = 1'b1;
      end

      else if(mpier_flags_1[INF] & mpcand_flags_1[INF] & (!addend_flags_1[NAN]))begin
        result_1 = {product_sign_1, {(EXP_H-EXP_L+1){1'b1}}, {(MANT_H+1){1'b0}}};
      end

      else if((!mpier_flags_1[NAN] & mpcand_flags_1[INF] & addend_flags_1[INF]) |
              (!mpcand_flags_1[NAN] & mpier_flags_1[INF] & addend_flags_1[INF]))begin
         if(product_sign_1 ^ addend_sign_1)begin
            result_1 = {1'b1, {(EXP_H-EXP_L+1){1'b1}}, 1'b1, {MANT_H{1'b0}}};
            exceptions_1[INVALID] = 1'b1;
         end
         else begin
            result_1 = {addend_sign_1, {(EXP_H-EXP_L+1){1'b1}}, {(MANT_H+1){1'b0}}};
         end
      end

      else if(mpier_flags_1[QNAN])begin
         result_1 = mpier_1;
      end

      else if(mpcand_flags_1[QNAN])begin
         result_1 = mpcand_1;
      end

      else if(addend_flags_1[QNAN])begin
         result_1 = addend_1;
      end

      else if(mpier_flags_1[INF])begin
         // INN
         result_1 = {product_sign_1, {(EXP_H-EXP_L+1){1'b1}}, {(MANT_H+1){1'b0}}};
      end

      else if(mpcand_flags_1[INF])begin
         // NIN
         result_1 = {product_sign_1, {(EXP_H-EXP_L+1){1'b1}}, {(MANT_H+1){1'b0}}};
      end

      else if(addend_flags_1[INF])begin
         // NNI
         result_1 = addend_1;
      end
      
      else if(addend_flags_1[ZERO] & (mpier_flags_1[ZERO] | mpcand_flags_1[ZERO]))begin
         if(rmode_1 == ROUND_MINUS_INF)
           if(product_sign_1 | addend_sign_1)
             result_1 = {1'b1, {(SIZE-1){1'b0}}};
           else
             result_1 = 0;
         else
           if(product_sign_1 & addend_sign_1)
             result_1 = {1'b1, {(SIZE-1){1'b0}}};
           else
             result_1 = 0;
      end
      
      else if(mpier_flags_1[ZERO] | mpcand_flags_1[ZERO])begin
         result_1 = addend_1;
      end
         
      else if(!mpier_flags_1[NAN] & !mpier_flags_1[INF] & !mpcand_flags_1[NAN] & !mpcand_flags_1[INF] &
         !addend_flags_1[NAN] & !addend_flags_1[INF])begin
         //
         // Everything is Z or N -- the "normal" case!!
         //
         ulp_product_mantissa_1 = {4'b0, product_mantissa_1, 4'b0};
         ulp_addend_mantissa_1 = {4'b0, addend_mantissa_1, 4'b0};
         ulp_mask = ~0;
         if(product_exponent_1 > addend_exponent_1)begin
            exp_delta_1 = product_exponent_1 - addend_exponent_1;
            if(exp_delta_1 < (2*MANT_WIDTH+3))begin
               ulp_mask = ulp_mask >> (2*MANT_WIDTH+3 - exp_delta_1);
            end
            ulp_addend_mantissa_1 = ulp_addend_mantissa_1 >> exp_delta_1;
            ulp_addend_mantissa_1[0] = |(addend_mantissa_1 & ulp_mask);
            sum_exponent_1 = product_exponent_1;
         end
         else if(addend_exponent_1 > product_exponent_1)begin
            exp_delta_1 = addend_exponent_1 - product_exponent_1;
            if(exp_delta_1 < (2*MANT_WIDTH+3))begin
               ulp_mask = ulp_mask >> (2*MANT_WIDTH+3 - exp_delta_1);
            end
            ulp_product_mantissa_1 = ulp_product_mantissa_1 >> exp_delta_1;
            ulp_product_mantissa_1[0] = |(product_mantissa_1 & ulp_mask);
            sum_exponent_1 = addend_exponent_1;
         end
         else begin
            sum_exponent_1 = addend_exponent_1; // Either exponent is OK in this case (since they are equal)
         end
            
         case({product_sign_1, addend_sign_1})
           2'b00: ulp_sum_mantissa_1 = ulp_product_mantissa_1 + ulp_addend_mantissa_1;
           2'b01: ulp_sum_mantissa_1 = ulp_product_mantissa_1 + ~ulp_addend_mantissa_1 + 1;
           2'b10: ulp_sum_mantissa_1 = ~ulp_product_mantissa_1 + 1 + ulp_addend_mantissa_1;
           2'b11: ulp_sum_mantissa_1 = ~ulp_product_mantissa_1 + 1 + ~ulp_addend_mantissa_1 + 1;
         endcase

         if(ulp_sum_mantissa_1[2*MANT_WIDTH+7])begin
            ulp_absum_mantissa_1 = ~ulp_sum_mantissa_1 + 1;
            result_sign_1 = 1'b1;
         end
         else begin
            ulp_absum_mantissa_1 = ulp_sum_mantissa_1;
            result_sign_1 = 1'b0;
         end

         if(!(|ulp_absum_mantissa_1))begin
            sum_exponent_1 = $signed(0 - BIAS);
            if((rmode_1 == ROUND_MINUS_INF) && (product_sign_1 ^ addend_sign_1))
              result_sign_1 = 1'b1;
            else
              result_sign_1 = 1'b0;
         end
         
         if(ulp_absum_mantissa_1[2*MANT_WIDTH+4])begin
            bottom_bit_1 = |ulp_absum_mantissa_1[1:0];            
            ulp_absum_mantissa_1 = ulp_absum_mantissa_1 >> 2;
            ulp_absum_mantissa_1[0] = ulp_absum_mantissa_1[0] | bottom_bit_1;
            sum_exponent_1 = sum_exponent_1 + 2;
         end
         else if(ulp_absum_mantissa_1[2*MANT_WIDTH+3])begin
            bottom_bit_1 = ulp_absum_mantissa_1[0];            
            ulp_absum_mantissa_1 = ulp_absum_mantissa_1 >> 1;
            ulp_absum_mantissa_1[0] = ulp_absum_mantissa_1[0] | bottom_bit_1;
            sum_exponent_1 = sum_exponent_1 + 1;
         end

         if(sum_exponent_1 > $signed(BIAS + lz_count_1))begin
            //
            // The exponent is too big, so force to the largest finite value (which MAY get rounded to infinity later).
            // Also, sticky_bit is unequivocally 1.
            //
            norm1_mantissa_1 = {(2*MANT_WIDTH){1'b1}};
            norm1_exponent_1 = BIAS;
            sticky_bit_1 = 1'b1;
            exceptions_1[OVERFLOW] = 1'b1;
         end
         else if(sum_exponent_1 > $signed(lz_count_1 - BIAS))begin
            //
            // This is the right range for a normal number, so shift the mantissa left, and adjust the exponent down.
            //
            sum_mantissa_1 = ulp_absum_mantissa_1 << lz_count_1;
            norm1_mantissa_1 = sum_mantissa_1[MANT_WIDTH*2+3:4];
            norm1_exponent_1 = sum_exponent_1 - lz_count_1;
            sticky_bit_1 = |norm1_mantissa_1[STICKY:0] | (|sum_mantissa_1[3:0]);
         end
         else begin
            norm1_exponent_1 = $signed(0 - BIAS);
            if(sum_exponent_1 > $signed(0 - BIAS))begin
               shift_count = $signed(sum_exponent_1 + BIAS - 1);
               sum_mantissa_1 = ulp_absum_mantissa_1 << shift_count;
               norm1_mantissa_1 = sum_mantissa_1[MANT_WIDTH*2+3:4];
               sticky_bit_1 = |norm1_mantissa_1[STICKY:0] | (|sum_mantissa_1[3:0]);
            end
            else begin
               shift_count = $signed((sum_exponent_1 + BIAS) * -1);
               sum_mantissa_1 = ulp_absum_mantissa_1 >> shift_count;
               norm1_mantissa_1 = sum_mantissa_1[MANT_WIDTH*2+3:4];
               if(shift_count >= MANT_WIDTH*2)
                 norm_mask = ~0;
               else
                 norm_mask = ~0 >> (2*MANT_WIDTH - shift_count);
               sticky_bit_1 = |(ulp_absum_mantissa_1[2*MANT_WIDTH+3:4] & norm_mask) |
                              norm1_mantissa_1[STICKY:0] | (|sum_mantissa_1[3:0]);
            end
            exceptions_1[UNDERFLOW] = |norm1_mantissa_1 | sticky_bit_1;
         end

         GRS_bits_1[GRS_G] = norm1_mantissa_1[GUARD];
         GRS_bits_1[GRS_R] = norm1_mantissa_1[ROUND];
         GRS_bits_1[GRS_T] = sticky_bit_1;

         case(rmode_1)
           ROUND_NEAREST_EVEN: begin
              mantissa_rounding_adjustment_1 = (GRS_bits_1[GRS_G] &
                                              (norm1_mantissa_1[GUARD+1] | GRS_bits_1[GRS_R] | GRS_bits_1[GRS_T])) <<
                                             (MANT_H+1);
              rounded_result_mantissa = norm1_mantissa_1 + mantissa_rounding_adjustment_1;
           end
           
           ROUND_TO_ZERO: begin
              rounded_result_mantissa = norm1_mantissa_1;
           end
           
           ROUND_PLUS_INF: begin
              mantissa_rounding_adjustment_1 = ((~result_sign_1 & |GRS_bits_1) << (MANT_H+1));
              rounded_result_mantissa = norm1_mantissa_1 + mantissa_rounding_adjustment_1;
           end

           ROUND_MINUS_INF: begin
              mantissa_rounding_adjustment_1 = ((result_sign_1 & |GRS_bits_1) << (MANT_H+1));
              rounded_result_mantissa = norm1_mantissa_1 + mantissa_rounding_adjustment_1;
           end
         endcase

         if(rounded_result_mantissa[MANT_WIDTH*2-2] ^ norm1_mantissa_1[MANT_WIDTH*2-2])
           rounded_result_exponent = norm1_exponent_1 + 1 + BIAS;
         else
           rounded_result_exponent = norm1_exponent_1 + BIAS;

         if(&rounded_result_exponent)
           exceptions_1[OVERFLOW] = 1'b1;

         result_1 = {result_sign_1, rounded_result_exponent, rounded_result_mantissa[(MANT_WIDTH*2-3):(MANT_WIDTH-1)]};
         exceptions_1[INEXACT] = GRS_bits_1[GRS_T] | (|norm1_mantissa_1[MANT_WIDTH-2:0]);

         exceptions_1[UNDERFLOW] = exceptions_1[UNDERFLOW] & exceptions_1[INEXACT];
      end

      else if(mpier_flags_1[INF] | mpcand_flags_1[INF] | addend_flags_1[INF])begin
         //
         // Anything non-NaN times infinity [ + infinity] = infinity
         //
         result_1 = {product_sign_1, {(EXP_H-EXP_L+1){1'b1}}, {(MANT_WIDTH-1){1'b0}}};
      end

      else begin
        result_1 = 32'hdeeddead; // Trap the leakers
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
         addend_0 <= 0;
         
         product_mantissa_1 <= 0;
         product_exponent_1 <= 0;
         product_sign_1 <= 0;
         mpier_flags_1 <= 0;
         mpcand_flags_1 <= 0;
         go_1 <= 0;
         rmode_1 <= 0;

         result <= 0;
         exceptions <= 0;
         valid <= 0;
      end
      else begin
         go_0 <= go;
         if(go)begin
            rmode_0 <= rounding_mode;
            mpcand_0 <= multiplicand;
            mpier_0 <= multiplier;
            addend_0 <= addend;
         end
         else begin
            rmode_0 <= rmode_0;
            mpcand_0 <= mpcand_0;
            mpier_0 <= mpier_0;
            addend_0 <= addend_0;
         end

         go_1 <= go_0;
         if(go_0)begin
            product_mantissa_1 <= {2'b0,product_mantissa_0};
            product_exponent_1 <= product_exponent_0;
            product_sign_1 <= product_sign_0;
            mpier_flags_1 <= mpier_flags_0;
            mpcand_flags_1 <= mpcand_flags_0;
            addend_flags_1 <= addend_flags_0;
            rmode_1 <= rmode_0;
            mpier_1 <= mpier_0;
            mpcand_1 <= mpcand_0;
            addend_1 <= addend_0;
            addend_mantissa_1 <= {3'b0,addend_mantissa_0,{(MANT_WIDTH-1){1'b0}}};
            addend_exponent_1 <= addend_exponent_0;
            addend_sign_1 <= addend_sign_0;            
         end
         else begin
            product_mantissa_1 <= product_mantissa_1;
            product_exponent_1 <= product_exponent_1;
            product_sign_1 <= product_sign_1;
            mpier_flags_1 <= mpier_flags_1;
            mpcand_flags_1 <= mpcand_flags_1;
            rmode_1 <= rmode_1;
            mpier_1 <= mpier_1;
            mpcand_1 <= mpcand_1;
            addend_1 <= addend_1;
            addend_mantissa_1 <= addend_mantissa_1;
            addend_exponent_1 <= addend_exponent_1;
            addend_sign_1 <= addend_sign_1;            
         end

         valid <= go_1;
         if(go_1)begin
            result <= result_1;
            exceptions <= exceptions_1;
         end
         else begin
            result <= result;
            exceptions <= exceptions;
         end
      end
   end
endmodule
