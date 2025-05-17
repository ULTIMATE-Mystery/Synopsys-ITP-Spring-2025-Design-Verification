`timescale 1ns/1ns

module booth4
  #(parameter WIDTH = 24)
  (
   output logic [WIDTH*2-1:0] product,
   input logic [WIDTH-1:0]    multiplier,
   input logic [WIDTH-1:0]    multiplicand
   );

   localparam PARTIAL_PRODUCT_COUNT = 1 + WIDTH/2;
   localparam PRODUCT_SIZE = WIDTH *2;
   localparam LOOP_UPPER_BOUND = PARTIAL_PRODUCT_COUNT * 2;
   
   logic [PARTIAL_PRODUCT_COUNT*2:0] augmented_multiplier;
   logic [WIDTH*2-1:0]               partial_products[0:PARTIAL_PRODUCT_COUNT-1];
   logic [WIDTH*2-1:0]               booth_codes[0:7];

   always_comb begin
      booth_codes[0] = 0;
      booth_codes[1] = multiplicand;
      booth_codes[2] = multiplicand;
      booth_codes[3] = multiplicand << 1;
      booth_codes[4] = ~booth_codes[3];
      booth_codes[5] = ~booth_codes[2];
      booth_codes[6] = ~booth_codes[2];
      booth_codes[7] = 0;

      augmented_multiplier = multiplier << 1;
      product = 0;

      for(int i = 0; i < LOOP_UPPER_BOUND; i = i + 2)begin
         partial_products[i>>1] = booth_codes[augmented_multiplier[i+:3]];
         partial_products[i>>1] = (partial_products[i>>1] + partial_products[i>>1][WIDTH*2-1]) << i;
      end

      for(int i = 0; i < PARTIAL_PRODUCT_COUNT; i = i +1)begin
         product = product + partial_products[i];
      end
   end
endmodule
