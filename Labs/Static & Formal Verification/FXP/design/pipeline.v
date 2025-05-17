module pipeline #(parameter WIDTH = 2
              )
              
   (input clk,
    input resetn,
    input [WIDTH-1:0] valid_in,
    input collapse_valids,
    output [WIDTH-1:0] valid_out,
    output pipe_full
    );
 
   reg [WIDTH-1:0]        valid_pipe_1;
   reg [WIDTH-1:0]        valid_pipe_2;
   reg [WIDTH-1:0]        valid_pipe_3;
   reg [WIDTH-1:0]        valid_pipe_4;
   reg [2:0] pipe_counter;
        
   wire valid;
   wire [WIDTH-1:0] output_valid;         
  
   always @(posedge clk or negedge resetn)
    if (!resetn)
      valid_pipe_1[0] <= 1'b0;
    else 
      valid_pipe_1 <= valid_in;

   always @(posedge clk or negedge resetn)
     if (!resetn)
     valid_pipe_2 <= '0;
     else valid_pipe_2 <= valid_pipe_1;
   
   always @(posedge clk or negedge resetn)
     if (!resetn)
     valid_pipe_3 <= '0;
     else valid_pipe_3 <= valid_pipe_2;
   
   always @(posedge clk or negedge resetn)
     if (!resetn)     
       valid_pipe_4 <= '0;
     else valid_pipe_4 <= valid_pipe_3;
   
   always @(posedge clk or negedge resetn)
     if (!resetn)     
       pipe_counter <= '0;
     else if (pipe_counter != 4)
       pipe_counter <= pipe_counter + 1'b1;

   assign         valid = |valid_pipe_4;

   assign         output_valid = collapse_valids ? {{WIDTH-1{1'b0}}, valid} : valid_pipe_4;
  
   assign         valid_out = output_valid;
  
   assign         pipe_full = (pipe_counter == 4);    

endmodule
