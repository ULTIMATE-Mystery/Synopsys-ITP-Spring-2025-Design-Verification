module top(input [2:0]in2, in1,output [3:0]out1);

assign out1 = in1 + in2; // VC Lint flags here

endmodule
