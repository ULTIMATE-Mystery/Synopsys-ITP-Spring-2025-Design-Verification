module pff (clk, in, out);

input in, clk;
output out;
reg out;

always @(posedge clk)
out <= in;

endmodule

module test ( f_in,f_in2,  clk1, clk2, clk3, s_out);
parameter EN = 0 ;

input f_in,f_in2, clk1, clk2 , clk3;
output s_out;

wire  r0, r1, r2, r3;

pff p1(clk1, f_in, r0);
pff p2 (clk2, r0, r1);
pff p3 (clk2, r1, r2);


pff p4(clk2, f_in, r3);
assign and1 = r3 & f_in2;
pff p5(clk3, and1, r4);
pff p6(clk3, r4, r5);


pff p7(clk2, r5, r6);
assign and2 = r6 & f_in2;
pff p8(clk2, and2, r7);



assign s_out =  r2 & r7 ;



endmodule

