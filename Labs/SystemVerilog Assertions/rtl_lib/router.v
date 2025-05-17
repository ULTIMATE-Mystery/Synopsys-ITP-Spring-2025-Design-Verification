// control pins:
// input: reset_n	- active low reset
// input: clock		- master clock input

// input port pins:
// input: frame_n	- must be active during whole input packet
// input: valid_n	- valid data input
// input: din		- the data input

// output port pins:
// output: dout		- the data output
// output: valido_n	- tells output device that "dout" contain valid data
// output: frameo_n	- active during the whole output packet
// frame format:
//
// Frame start must look like this:
//
// frame_n:	|  1 |  0 |  0 |  0 |  0 |  0 |  0 |  0 |  0 |  0  | ...
// din:		|  X | A0 | A1 | A2 | A3 |  1 |  X |  X |  X | D0  | ...
// valid_n:	|  X |  X |  X |  X |  X |  X |  1 |  1 |  1 | 0/1 | ...
//
// note1: frame_n must deasserted at least one cycle between packets.
// note2: a din is taken by the chip if:  valid_n == 0
// note3 frame_n must be deasserted with the last data bit in the frame.

module router(reset_n, clock, frame_n, valid_n, din, busy_n, dout, valido_n, frameo_n);
input  reset_n, clock;
input  [15:0] din, frame_n, valid_n;
output [15:0] busy_n, dout, valido_n, frameo_n;

reg [15:0] din_reg, frame_reg, valid_reg;

wire[15:0] request0_n, request1_n, request2_n, request3_n, request4_n, request5_n, request6_n, request7_n, request8_n, request9_n, request10_n, request11_n, request12_n, request13_n, request14_n, request15_n;
wire[15:0] grant_n[16];

wire[15:0] grant0_n, grant1_n, grant2_n, grant3_n, grant4_n, grant5_n, grant6_n, grant7_n, grant8_n, grant9_n, grant10_n, grant11_n, grant12_n, grant13_n, grant14_n, grant15_n;

wire[15:0] grant_0, grant_1, grant_2, grant_3, grant_4, grant_5, grant_6, grant_7, grant_8, grant_9, grant_10, grant_11, grant_12, grant_13, grant_14, grant_15;

wire[15:0] request_n[16];

wire[15:0] request_0, request_1, request_2, request_3, request_4, request_5, request_6, request_7, request_8, request_9, request_10, request_11, request_12, request_13, request_14, request_15;

wire[3:0] op0_ip_src, op1_ip_src, op2_ip_src, op3_ip_src, op4_ip_src, op5_ip_src, op6_ip_src, op7_ip_src, op8_ip_src, op9_ip_src, op10_ip_src, op11_ip_src, op12_ip_src, op13_ip_src, op14_ip_src, op15_ip_src;

wire[15:0] deassert, frameo_int;

iport ip0(reset_n, clock, din[0], frame_n[0], grant_0, request0_n, busy_n[0]);
iport ip1(reset_n, clock, din[1], frame_n[1], grant_1, request1_n, busy_n[1]);
iport ip2(reset_n, clock, din[2], frame_n[2], grant_2, request2_n, busy_n[2]);
iport ip3(reset_n, clock, din[3], frame_n[3], grant_3, request3_n, busy_n[3]);
iport ip4(reset_n, clock, din[4], frame_n[4], grant_4, request4_n, busy_n[4]);
iport ip5(reset_n, clock, din[5], frame_n[5], grant_5, request5_n, busy_n[5]);
iport ip6(reset_n, clock, din[6], frame_n[6], grant_6, request6_n, busy_n[6]);
iport ip7(reset_n, clock, din[7], frame_n[7], grant_7, request7_n, busy_n[7]);
iport ip8(reset_n, clock, din[8], frame_n[8], grant_8, request8_n, busy_n[8]);
iport ip9(reset_n, clock, din[9], frame_n[9], grant_9, request9_n, busy_n[9]);
iport ip10(reset_n, clock, din[10], frame_n[10], grant_10, request10_n, busy_n[10]);
iport ip11(reset_n, clock, din[11], frame_n[11], grant_11, request11_n, busy_n[11]);
iport ip12(reset_n, clock, din[12], frame_n[12], grant_12, request12_n, busy_n[12]);
iport ip13(reset_n, clock, din[13], frame_n[13], grant_13, request13_n, busy_n[13]);
iport ip14(reset_n, clock, din[14], frame_n[14], grant_14, request14_n, busy_n[14]);
iport ip15(reset_n, clock, din[15], frame_n[15], grant_15, request15_n, busy_n[15]);

oport op0(reset_n, clock, request_n[0], frameo_int[0], grant_n[0], op0_ip_src, deassert[0]);
oport op1(reset_n, clock, request_n[1], frameo_int[1], grant_n[1], op1_ip_src, deassert[1]);
oport op2(reset_n, clock, request_n[2], frameo_int[2], grant_n[2], op2_ip_src, deassert[2]);
oport op3(reset_n, clock, request_n[3], frameo_int[3], grant_n[3], op3_ip_src, deassert[3]);
oport op4(reset_n, clock, request_n[4], frameo_int[4], grant_n[4], op4_ip_src, deassert[4]);
oport op5(reset_n, clock, request_n[5], frameo_int[5], grant_n[5], op5_ip_src, deassert[5]);
oport op6(reset_n, clock, request_n[6], frameo_int[6], grant_n[6], op6_ip_src, deassert[6]);
oport op7(reset_n, clock, request_n[7], frameo_int[7], grant_n[7], op7_ip_src, deassert[7]);
oport op8(reset_n, clock, request_n[8], frameo_int[8], grant_n[8], op8_ip_src, deassert[8]);
oport op9(reset_n, clock, request_n[9], frameo_int[9], grant_n[9], op9_ip_src, deassert[9]);
oport op10(reset_n, clock, request_n[10], frameo_int[10], grant_n[10], op10_ip_src, deassert[10]);
oport op11(reset_n, clock, request_n[11], frameo_int[11], grant_n[11], op11_ip_src, deassert[11]);
oport op12(reset_n, clock, request_n[12], frameo_int[12], grant_n[12], op12_ip_src, deassert[12]);
oport op13(reset_n, clock, request_n[13], frameo_int[13], grant_n[13], op13_ip_src, deassert[13]);
oport op14(reset_n, clock, request_n[14], frameo_int[14], grant_n[14], op14_ip_src, deassert[14]);
oport op15(reset_n, clock, request_n[15], frameo_int[15], grant_n[15], op15_ip_src, deassert[15]);

assign frameo_int[0] = frame_reg[op0_ip_src];
assign frameo_int[1] = frame_reg[op1_ip_src];
assign frameo_int[2] = frame_reg[op2_ip_src];
assign frameo_int[3] = frame_reg[op3_ip_src];
assign frameo_int[4] = frame_reg[op4_ip_src];
assign frameo_int[5] = frame_reg[op5_ip_src];
assign frameo_int[6] = frame_reg[op6_ip_src];
assign frameo_int[7] = frame_reg[op7_ip_src];
assign frameo_int[8] = frame_reg[op8_ip_src];
assign frameo_int[9] = frame_reg[op9_ip_src];
assign frameo_int[10] = frame_reg[op10_ip_src];
assign frameo_int[11] = frame_reg[op11_ip_src];
assign frameo_int[12] = frame_reg[op12_ip_src];
assign frameo_int[13] = frame_reg[op13_ip_src];
assign frameo_int[14] = frame_reg[op14_ip_src];
assign frameo_int[15] = frame_reg[op15_ip_src];

assign frameo_n = frameo_int | deassert;

assign valido_n[0] = valid_reg[op0_ip_src] | deassert[0];
assign valido_n[1] = valid_reg[op1_ip_src] | deassert[1];
assign valido_n[2] = valid_reg[op2_ip_src] | deassert[2];
assign valido_n[3] = valid_reg[op3_ip_src] | deassert[3];
assign valido_n[4] = valid_reg[op4_ip_src] | deassert[4];
assign valido_n[5] = valid_reg[op5_ip_src] | deassert[5];
assign valido_n[6] = valid_reg[op6_ip_src] | deassert[6];
assign valido_n[7] = valid_reg[op7_ip_src] | deassert[7];
assign valido_n[8] = valid_reg[op8_ip_src] | deassert[8];
assign valido_n[9] = valid_reg[op9_ip_src] | deassert[9];
assign valido_n[10] = valid_reg[op10_ip_src] | deassert[10];
assign valido_n[11] = valid_reg[op11_ip_src] | deassert[11];
assign valido_n[12] = valid_reg[op12_ip_src] | deassert[12];
assign valido_n[13] = valid_reg[op13_ip_src] | deassert[13];
assign valido_n[14] = valid_reg[op14_ip_src] | deassert[14];
assign valido_n[15] = valid_reg[op15_ip_src] | deassert[15];

assign dout[0] = din_reg[op0_ip_src];
assign dout[1] = din_reg[op1_ip_src];
assign dout[2] = din_reg[op2_ip_src];
assign dout[3] = din_reg[op3_ip_src];
assign dout[4] = din_reg[op4_ip_src];
assign dout[5] = din_reg[op5_ip_src];
assign dout[6] = din_reg[op6_ip_src];
assign dout[7] = din_reg[op7_ip_src];
assign dout[8] = din_reg[op8_ip_src];
assign dout[9] = din_reg[op9_ip_src];
assign dout[10] = din_reg[op10_ip_src];
assign dout[11] = din_reg[op11_ip_src];
assign dout[12] = din_reg[op12_ip_src];
assign dout[13] = din_reg[op13_ip_src];
assign dout[14] = din_reg[op14_ip_src];
assign dout[15] = din_reg[op15_ip_src];

assign grant_0 = {grant_n[15][0], grant_n[14][0], grant_n[13][0], grant_n[12][0], grant_n[11][0], grant_n[10][0], grant_n[9][0], grant_n[8][0], grant_n[7][0], grant_n[6][0], grant_n[5][0], grant_n[4][0], grant_n[3][0], grant_n[2][0], grant_n[1][0], grant_n[0][0]}; 
assign grant_1 = {grant_n[15][1], grant_n[14][1], grant_n[13][1], grant_n[12][1], grant_n[11][1], grant_n[10][1], grant_n[9][1], grant_n[8][1], grant_n[7][1], grant_n[6][1], grant_n[5][1], grant_n[4][1], grant_n[3][1], grant_n[2][1], grant_n[1][1], grant_n[0][1]}; 
assign grant_2 = {grant_n[15][2], grant_n[14][2], grant_n[13][2], grant_n[12][2], grant_n[11][2], grant_n[10][2], grant_n[9][2], grant_n[8][2], grant_n[7][2], grant_n[6][2], grant_n[5][2], grant_n[4][2], grant_n[3][2], grant_n[2][2], grant_n[1][2], grant_n[0][2]}; 
assign grant_3 = {grant_n[15][3], grant_n[14][3], grant_n[13][3], grant_n[12][3], grant_n[11][3], grant_n[10][3], grant_n[9][3], grant_n[8][3], grant_n[7][3], grant_n[6][3], grant_n[5][3], grant_n[4][3], grant_n[3][3], grant_n[2][3], grant_n[1][3], grant_n[0][3]}; 
assign grant_4 = {grant_n[15][4], grant_n[14][4], grant_n[13][4], grant_n[12][4], grant_n[11][4], grant_n[10][4], grant_n[9][4], grant_n[8][4], grant_n[7][4], grant_n[6][4], grant_n[5][4], grant_n[4][4], grant_n[3][4], grant_n[2][4], grant_n[1][4], grant_n[0][4]}; 
assign grant_5 = {grant_n[15][5], grant_n[14][5], grant_n[13][5], grant_n[12][5], grant_n[11][5], grant_n[10][5], grant_n[9][5], grant_n[8][5], grant_n[7][5], grant_n[6][5], grant_n[5][5], grant_n[4][5], grant_n[3][5], grant_n[2][5], grant_n[1][5], grant_n[0][5]}; 
assign grant_6 = {grant_n[15][6], grant_n[14][6], grant_n[13][6], grant_n[12][6], grant_n[11][6], grant_n[10][6], grant_n[9][6], grant_n[8][6], grant_n[7][6], grant_n[6][6], grant_n[5][6], grant_n[4][6], grant_n[3][6], grant_n[2][6], grant_n[1][6], grant_n[0][6]}; 
assign grant_7 = {grant_n[15][7], grant_n[14][7], grant_n[13][7], grant_n[12][7], grant_n[11][7], grant_n[10][7], grant_n[9][7], grant_n[8][7], grant_n[7][7], grant_n[6][7], grant_n[5][7], grant_n[4][7], grant_n[3][7], grant_n[2][7], grant_n[1][7], grant_n[0][7]}; 
assign grant_8 = {grant_n[15][8], grant_n[14][8], grant_n[13][8], grant_n[12][8], grant_n[11][8], grant_n[10][8], grant_n[9][8], grant_n[8][8], grant_n[7][8], grant_n[6][8], grant_n[5][8], grant_n[4][8], grant_n[3][8], grant_n[2][8], grant_n[1][8], grant_n[0][8]}; 
assign grant_9 = {grant_n[15][9], grant_n[14][9], grant_n[13][9], grant_n[12][9], grant_n[11][9], grant_n[10][9], grant_n[9][9], grant_n[8][9], grant_n[7][9], grant_n[6][9], grant_n[5][9], grant_n[4][9], grant_n[3][9], grant_n[2][9], grant_n[1][9], grant_n[0][9]}; 
assign grant_10 = {grant_n[15][10], grant_n[14][10], grant_n[13][10], grant_n[12][10], grant_n[11][10], grant_n[10][10], grant_n[9][10], grant_n[8][10], grant_n[7][10], grant_n[6][10], grant_n[5][10], grant_n[4][10], grant_n[3][10], grant_n[2][10], grant_n[1][10], grant_n[0][10]}; 
assign grant_11 = {grant_n[15][11], grant_n[14][11], grant_n[13][11], grant_n[12][11], grant_n[11][11], grant_n[10][11], grant_n[9][11], grant_n[8][11], grant_n[7][11], grant_n[6][11], grant_n[5][11], grant_n[4][11], grant_n[3][11], grant_n[2][11], grant_n[1][11], grant_n[0][11]}; 
assign grant_12 = {grant_n[15][12], grant_n[14][12], grant_n[13][12], grant_n[12][12], grant_n[11][12], grant_n[10][12], grant_n[9][12], grant_n[8][12], grant_n[7][12], grant_n[6][12], grant_n[5][12], grant_n[4][12], grant_n[3][12], grant_n[2][12], grant_n[1][12], grant_n[0][12]}; 
assign grant_13 = {grant_n[15][13], grant_n[14][13], grant_n[13][13], grant_n[12][13], grant_n[11][13], grant_n[10][13], grant_n[9][13], grant_n[8][13], grant_n[7][13], grant_n[6][13], grant_n[5][13], grant_n[4][13], grant_n[3][13], grant_n[2][13], grant_n[1][13], grant_n[0][13]}; 
assign grant_14 = {grant_n[15][14], grant_n[14][14], grant_n[13][14], grant_n[12][14], grant_n[11][14], grant_n[10][14], grant_n[9][14], grant_n[8][14], grant_n[7][14], grant_n[6][14], grant_n[5][14], grant_n[4][14], grant_n[3][14], grant_n[2][14], grant_n[1][14], grant_n[0][14]}; 
assign grant_15 = {grant_n[15][15], grant_n[14][15], grant_n[13][15], grant_n[12][15], grant_n[11][15], grant_n[10][15], grant_n[9][15], grant_n[8][15], grant_n[7][15], grant_n[6][15], grant_n[5][15], grant_n[4][15], grant_n[3][15], grant_n[2][15], grant_n[1][15], grant_n[0][15]}; 

assign request_n[0] = {request15_n[0], request14_n[0], request13_n[0], request12_n[0], request11_n[0], request10_n[0], request9_n[0], request8_n[0], request7_n[0], request6_n[0], request5_n[0], request4_n[0], request3_n[0], request2_n[0], request1_n[0], request0_n[0]}; 
assign request_n[1] = {request15_n[1], request14_n[1], request13_n[1], request12_n[1], request11_n[1], request10_n[1], request9_n[1], request8_n[1], request7_n[1], request6_n[1], request5_n[1], request4_n[1], request3_n[1], request2_n[1], request1_n[1], request0_n[1]}; 
assign request_n[2] = {request15_n[2], request14_n[2], request13_n[2], request12_n[2], request11_n[2], request10_n[2], request9_n[2], request8_n[2], request7_n[2], request6_n[2], request5_n[2], request4_n[2], request3_n[2], request2_n[2], request1_n[2], request0_n[2]}; 
assign request_n[3] = {request15_n[3], request14_n[3], request13_n[3], request12_n[3], request11_n[3], request10_n[3], request9_n[3], request8_n[3], request7_n[3], request6_n[3], request5_n[3], request4_n[3], request3_n[3], request2_n[3], request1_n[3], request0_n[3]}; 
assign request_n[4] = {request15_n[4], request14_n[4], request13_n[4], request12_n[4], request11_n[4], request10_n[4], request9_n[4], request8_n[4], request7_n[4], request6_n[4], request5_n[4], request4_n[4], request3_n[4], request2_n[4], request1_n[4], request0_n[4]}; 
assign request_n[5] = {request15_n[5], request14_n[5], request13_n[5], request12_n[5], request11_n[5], request10_n[5], request9_n[5], request8_n[5], request7_n[5], request6_n[5], request5_n[5], request4_n[5], request3_n[5], request2_n[5], request1_n[5], request0_n[5]}; 
assign request_n[6] = {request15_n[6], request14_n[6], request13_n[6], request12_n[6], request11_n[6], request10_n[6], request9_n[6], request8_n[6], request7_n[6], request6_n[6], request5_n[6], request4_n[6], request3_n[6], request2_n[6], request1_n[6], request0_n[6]}; 
assign request_n[7] = {request15_n[7], request14_n[7], request13_n[7], request12_n[7], request11_n[7], request10_n[7], request9_n[7], request8_n[7], request7_n[7], request6_n[7], request5_n[7], request4_n[7], request3_n[7], request2_n[7], request1_n[7], request0_n[7]}; 
assign request_n[8] = {request15_n[8], request14_n[8], request13_n[8], request12_n[8], request11_n[8], request10_n[8], request9_n[8], request8_n[8], request7_n[8], request6_n[8], request5_n[8], request4_n[8], request3_n[8], request2_n[8], request1_n[8], request0_n[8]}; 
assign request_n[9] = {request15_n[9], request14_n[9], request13_n[9], request12_n[9], request11_n[9], request10_n[9], request9_n[9], request8_n[9], request7_n[9], request6_n[9], request5_n[9], request4_n[9], request3_n[9], request2_n[9], request1_n[9], request0_n[9]}; 
assign request_n[10] = {request15_n[10], request14_n[10], request13_n[10], request12_n[10], request11_n[10], request10_n[10], request9_n[10], request8_n[10], request7_n[10], request6_n[10], request5_n[10], request4_n[10], request3_n[10], request2_n[10], request1_n[10], request0_n[10]}; 
assign request_n[11] = {request15_n[11], request14_n[11], request13_n[11], request12_n[11], request11_n[11], request10_n[11], request9_n[11], request8_n[11], request7_n[11], request6_n[11], request5_n[11], request4_n[11], request3_n[11], request2_n[11], request1_n[11], request0_n[11]}; 
assign request_n[12] = {request15_n[12], request14_n[12], request13_n[12], request12_n[12], request11_n[12], request10_n[12], request9_n[12], request8_n[12], request7_n[12], request6_n[12], request5_n[12], request4_n[12], request3_n[12], request2_n[12], request1_n[12], request0_n[12]}; 
assign request_n[13] = {request15_n[13], request14_n[13], request13_n[13], request12_n[13], request11_n[13], request10_n[13], request9_n[13], request8_n[13], request7_n[13], request6_n[13], request5_n[13], request4_n[13], request3_n[13], request2_n[13], request1_n[13], request0_n[13]}; 
assign request_n[14] = {request15_n[14], request14_n[14], request13_n[14], request12_n[14], request11_n[14], request10_n[14], request9_n[14], request8_n[14], request7_n[14], request6_n[14], request5_n[14], request4_n[14], request3_n[14], request2_n[14], request1_n[14], request0_n[14]}; 
assign request_n[15] = {request15_n[15], request14_n[15], request13_n[15], request12_n[15], request11_n[15], request10_n[15], request9_n[15], request8_n[15], request7_n[15], request6_n[15], request5_n[15], request4_n[15], request3_n[15], request2_n[15], request1_n[15], request0_n[15]}; 

always@(posedge clock)
begin
  din_reg <= din;
  frame_reg <= frame_n;
  valid_reg <= valid_n;
end

endmodule  //router
module iport(reset_n, clock, din, frame_n, grant_n, request_n, busy_n);
input  reset_n, clock, din, frame_n;
input  [15:0] grant_n;
output busy_n;
output [15:0] request_n;

reg [15:0] request_n;
reg[3:0] state, nxt_state, oport_no, nxt_oport_no;
reg busy_n, busy_int;

initial
  $vcdpluson;

always@(posedge clock or negedge reset_n)
begin
  if (!reset_n) begin
    state    <= 0;
    oport_no <= 0;
    busy_n   <= 1'b1;
  end
  else begin
    state    <= nxt_state;
    oport_no <= nxt_oport_no;
    busy_n   <= busy_int;
  end
end

always@(state or frame_n or grant_n or oport_no or din)
begin
  //request_n = ~('b0);
  nxt_state = state;
  busy_int = 1'b1;
  nxt_oport_no = oport_no;
  case(state)
    0:  begin if (!frame_n) begin
          nxt_state = 1;
          nxt_oport_no[0] = din;
        end
  		request_n = ~('b0);
		end
    1:  begin
          nxt_state = 2;
          nxt_oport_no[1] = din;
        end
    2:  begin
          nxt_state = 3;
          nxt_oport_no[2] = din;
        end
    3:  begin
          nxt_state = 4;
          nxt_oport_no[3] = din;
        end
    4:  if (din == 1'b1) begin
          nxt_state = 5;
        end
        else nxt_state = 0;
    5:  nxt_state = 6;
    6:  begin
          nxt_state = 7;
          request_n[oport_no] = 1'b0;
        end
    7:  if (!grant_n[oport_no])
          nxt_state = 8;
        else begin
          request_n[oport_no] = 1'b0;
          busy_int = 1'b0;
        end
    8:  begin 
		  request_n[oport_no] = 1'b1;
		  if (frame_n) nxt_state = 0;
  		end
  endcase
end

endmodule  //iport
module oport(reset_n, clock, request_n, frame_n, grant_n, op_ip_src, deassert);
input  reset_n, clock, frame_n;
input  [15:0] request_n;
output [15:0] grant_n;
output [3:0] op_ip_src;
output deassert;

//ova bind ova_one_hot #(1, 3) chk1 (1'b1, clock, state);

reg[3:0] port_last, nxt_port, port_no, op_ip_src, nxt_op_ip_src;
reg[2:0] state, nxt_state;
reg[15:0] grant_n;
reg hit, deassert;

wire[15:0] request_int;

assign request_int = (request_n >> (port_last+1)) | (request_n << (16-(port_last+1)));

always@(request_int)
begin
  hit = 1'b1;
  port_no = 0;
  case(1'b0)
    request_int[0]:  port_no = 0;
    request_int[1]:  port_no = 1;
    request_int[2]:  port_no = 2;
    request_int[3]:  port_no = 3;
    request_int[4]:  port_no = 4;
    request_int[5]:  port_no = 5;
    request_int[6]:  port_no = 6;
    request_int[7]:  port_no = 7;
    request_int[8]:  port_no = 8;
    request_int[9]:  port_no = 9;
    request_int[10]:  port_no = 10;
    request_int[11]:  port_no = 11;
    request_int[12]:  port_no = 12;
    request_int[13]:  port_no = 13;
    request_int[14]:  port_no = 14;
    request_int[15]:  port_no = 15;
    default: hit = 1'b0;
  endcase
end

initial
  $vcdpluson;

always@(posedge clock or negedge reset_n)
begin
  if (!reset_n) begin
    state     <= 1;
    port_last <= ~('b0);
    op_ip_src <= 0;
  end
  else begin
    state     <= nxt_state;
    port_last <= nxt_port;
    op_ip_src <= nxt_op_ip_src;
  end
end

always@(state or port_last or port_no or hit or frame_n)
begin
  nxt_state     = 0;
  nxt_port      = port_last;
  nxt_op_ip_src = op_ip_src;
  deassert      = 0;
  grant_n = ~('b0);
  case(1'b1)
    state[0]: if (hit) begin
                nxt_port        = port_no + port_last + 1;
                nxt_state[1]    = 1;
                nxt_op_ip_src   = nxt_port;
                deassert = 1;
              end
              else begin
                nxt_state[0]    = 1;
                deassert = 1;
              end
    state[1]: begin
                grant_n[port_last] = 1'b0;
                nxt_state[2] = 1;
              end
    state[2]: if (frame_n) nxt_state[0] = 1;
              else nxt_state[2] = 1;
  endcase
end

endmodule  //oport