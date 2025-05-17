`timescale 1ns/1ns

module clzmadd
  #(parameter WIDTH=32, OFFSET=5)
   (
    input logic [WIDTH-1:0] bits,
    output logic [7:0]      lz_count
    );

   logic [WIDTH:0]          local_bits;
   logic                    found_a_1;
                   
   always_comb begin
      local_bits = {1'b0,bits};
      lz_count = 0;
      found_a_1 = 0;
      for(int i = 0; i < WIDTH; i = i + 1)begin
         if(!found_a_1)begin
            local_bits = local_bits << 1;
            if(local_bits[WIDTH])
              found_a_1 = 1;
            else
              lz_count = lz_count + 1;
         end
      end
      lz_count = lz_count - OFFSET;
   end
endmodule
   
    