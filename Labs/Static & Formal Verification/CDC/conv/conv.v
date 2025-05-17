module nff (clk, in, out);

input in, clk;
output out;
reg out;

always @(negedge clk)
out <= in;

endmodule

module pff (clk, in, out);

input in, clk;
output out;
reg out;

always @(posedge clk)
out <= in;

endmodule

module sync (out, in, clk);

output out;
input in, clk;

pff p1(clk, in, temp1);
pff p2(clk, temp1, out);

endmodule

module mux (din2, cin3, din1, s_out);
output din2;
input cin3, din1, s_out;

assign din2 = cin3 ? s_out : din1;

endmodule

module test ( din1,din2, clk1, clk2, s_out);

input din1,din2, clk1, clk2;
output s_out;

wire  din1reg,  din2reg, s1temp, s1out, s2temp, s2out;

pff f1(clk1, din1, din1reg);
pff f4(clk1, din2, din2reg);

pff f2(clk2, din1reg, s1temp);
pff f3(clk2, s1temp, s1out);

pff f5(clk2, din2reg, s2temp);
pff f6(clk2, s2temp, s2out);

assign sout = s1out ^ s2out; 

endmodule

