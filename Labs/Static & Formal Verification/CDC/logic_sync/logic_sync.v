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

module test ( din,cin,  clk1, clk2, s_out);
parameter EN = 0 ;

input din,cin, clk1, clk2;
output s_out;

wire  din1, cin1, cin2, cin3, r4,r2_flop;

pff d1(clk1, din, din1);
pff c1(clk1, cin, cin1);

pff c2(clk2, cin1, cin2);
pff c3(clk2, cin2, cin3);

and a1 (din2, cin3, din1);
pff d2(clk2, din2, s_out);


endmodule

