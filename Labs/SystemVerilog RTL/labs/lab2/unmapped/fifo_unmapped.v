/////////////////////////////////////////////////////////////
// Created by: Synopsys Design Compiler(R)
// Version   : W-2024.09-SP2
// Date      : Sun Jun  1 14:55:06 2025
/////////////////////////////////////////////////////////////


module fifo_WIDTH16_BUF_SIZE16_I_fifo_if_fifo_io__16 ( clk, reset_n, 
        \fifo_if.rd_n , \fifo_if.wr_n , \fifo_if.empty , \fifo_if.full , 
        \fifo_if.din , \fifo_if.dout  );
  input [15:0] \fifo_if.din ;
  output [15:0] \fifo_if.dout ;
  input clk, reset_n, \fifo_if.rd_n , \fifo_if.wr_n ;
  output \fifo_if.empty , \fifo_if.full ;
  wire   N0, N1, N2, N3, N4, N5, N6, N7, N8, N9, N10, N11, N12, N13, N14, N15,
         N16, N17, N18, N19, N20, N21, N22, N23, \reg_buffer[0][15] ,
         \reg_buffer[0][14] , \reg_buffer[0][13] , \reg_buffer[0][12] ,
         \reg_buffer[0][11] , \reg_buffer[0][10] , \reg_buffer[0][9] ,
         \reg_buffer[0][8] , \reg_buffer[0][7] , \reg_buffer[0][6] ,
         \reg_buffer[0][5] , \reg_buffer[0][4] , \reg_buffer[0][3] ,
         \reg_buffer[0][2] , \reg_buffer[0][1] , \reg_buffer[0][0] ,
         \reg_buffer[1][15] , \reg_buffer[1][14] , \reg_buffer[1][13] ,
         \reg_buffer[1][12] , \reg_buffer[1][11] , \reg_buffer[1][10] ,
         \reg_buffer[1][9] , \reg_buffer[1][8] , \reg_buffer[1][7] ,
         \reg_buffer[1][6] , \reg_buffer[1][5] , \reg_buffer[1][4] ,
         \reg_buffer[1][3] , \reg_buffer[1][2] , \reg_buffer[1][1] ,
         \reg_buffer[1][0] , \reg_buffer[2][15] , \reg_buffer[2][14] ,
         \reg_buffer[2][13] , \reg_buffer[2][12] , \reg_buffer[2][11] ,
         \reg_buffer[2][10] , \reg_buffer[2][9] , \reg_buffer[2][8] ,
         \reg_buffer[2][7] , \reg_buffer[2][6] , \reg_buffer[2][5] ,
         \reg_buffer[2][4] , \reg_buffer[2][3] , \reg_buffer[2][2] ,
         \reg_buffer[2][1] , \reg_buffer[2][0] , \reg_buffer[3][15] ,
         \reg_buffer[3][14] , \reg_buffer[3][13] , \reg_buffer[3][12] ,
         \reg_buffer[3][11] , \reg_buffer[3][10] , \reg_buffer[3][9] ,
         \reg_buffer[3][8] , \reg_buffer[3][7] , \reg_buffer[3][6] ,
         \reg_buffer[3][5] , \reg_buffer[3][4] , \reg_buffer[3][3] ,
         \reg_buffer[3][2] , \reg_buffer[3][1] , \reg_buffer[3][0] ,
         \reg_buffer[4][15] , \reg_buffer[4][14] , \reg_buffer[4][13] ,
         \reg_buffer[4][12] , \reg_buffer[4][11] , \reg_buffer[4][10] ,
         \reg_buffer[4][9] , \reg_buffer[4][8] , \reg_buffer[4][7] ,
         \reg_buffer[4][6] , \reg_buffer[4][5] , \reg_buffer[4][4] ,
         \reg_buffer[4][3] , \reg_buffer[4][2] , \reg_buffer[4][1] ,
         \reg_buffer[4][0] , \reg_buffer[5][15] , \reg_buffer[5][14] ,
         \reg_buffer[5][13] , \reg_buffer[5][12] , \reg_buffer[5][11] ,
         \reg_buffer[5][10] , \reg_buffer[5][9] , \reg_buffer[5][8] ,
         \reg_buffer[5][7] , \reg_buffer[5][6] , \reg_buffer[5][5] ,
         \reg_buffer[5][4] , \reg_buffer[5][3] , \reg_buffer[5][2] ,
         \reg_buffer[5][1] , \reg_buffer[5][0] , \reg_buffer[6][15] ,
         \reg_buffer[6][14] , \reg_buffer[6][13] , \reg_buffer[6][12] ,
         \reg_buffer[6][11] , \reg_buffer[6][10] , \reg_buffer[6][9] ,
         \reg_buffer[6][8] , \reg_buffer[6][7] , \reg_buffer[6][6] ,
         \reg_buffer[6][5] , \reg_buffer[6][4] , \reg_buffer[6][3] ,
         \reg_buffer[6][2] , \reg_buffer[6][1] , \reg_buffer[6][0] ,
         \reg_buffer[7][15] , \reg_buffer[7][14] , \reg_buffer[7][13] ,
         \reg_buffer[7][12] , \reg_buffer[7][11] , \reg_buffer[7][10] ,
         \reg_buffer[7][9] , \reg_buffer[7][8] , \reg_buffer[7][7] ,
         \reg_buffer[7][6] , \reg_buffer[7][5] , \reg_buffer[7][4] ,
         \reg_buffer[7][3] , \reg_buffer[7][2] , \reg_buffer[7][1] ,
         \reg_buffer[7][0] , \reg_buffer[8][15] , \reg_buffer[8][14] ,
         \reg_buffer[8][13] , \reg_buffer[8][12] , \reg_buffer[8][11] ,
         \reg_buffer[8][10] , \reg_buffer[8][9] , \reg_buffer[8][8] ,
         \reg_buffer[8][7] , \reg_buffer[8][6] , \reg_buffer[8][5] ,
         \reg_buffer[8][4] , \reg_buffer[8][3] , \reg_buffer[8][2] ,
         \reg_buffer[8][1] , \reg_buffer[8][0] , \reg_buffer[9][15] ,
         \reg_buffer[9][14] , \reg_buffer[9][13] , \reg_buffer[9][12] ,
         \reg_buffer[9][11] , \reg_buffer[9][10] , \reg_buffer[9][9] ,
         \reg_buffer[9][8] , \reg_buffer[9][7] , \reg_buffer[9][6] ,
         \reg_buffer[9][5] , \reg_buffer[9][4] , \reg_buffer[9][3] ,
         \reg_buffer[9][2] , \reg_buffer[9][1] , \reg_buffer[9][0] ,
         \reg_buffer[10][15] , \reg_buffer[10][14] , \reg_buffer[10][13] ,
         \reg_buffer[10][12] , \reg_buffer[10][11] , \reg_buffer[10][10] ,
         \reg_buffer[10][9] , \reg_buffer[10][8] , \reg_buffer[10][7] ,
         \reg_buffer[10][6] , \reg_buffer[10][5] , \reg_buffer[10][4] ,
         \reg_buffer[10][3] , \reg_buffer[10][2] , \reg_buffer[10][1] ,
         \reg_buffer[10][0] , \reg_buffer[11][15] , \reg_buffer[11][14] ,
         \reg_buffer[11][13] , \reg_buffer[11][12] , \reg_buffer[11][11] ,
         \reg_buffer[11][10] , \reg_buffer[11][9] , \reg_buffer[11][8] ,
         \reg_buffer[11][7] , \reg_buffer[11][6] , \reg_buffer[11][5] ,
         \reg_buffer[11][4] , \reg_buffer[11][3] , \reg_buffer[11][2] ,
         \reg_buffer[11][1] , \reg_buffer[11][0] , \reg_buffer[12][15] ,
         \reg_buffer[12][14] , \reg_buffer[12][13] , \reg_buffer[12][12] ,
         \reg_buffer[12][11] , \reg_buffer[12][10] , \reg_buffer[12][9] ,
         \reg_buffer[12][8] , \reg_buffer[12][7] , \reg_buffer[12][6] ,
         \reg_buffer[12][5] , \reg_buffer[12][4] , \reg_buffer[12][3] ,
         \reg_buffer[12][2] , \reg_buffer[12][1] , \reg_buffer[12][0] ,
         \reg_buffer[13][15] , \reg_buffer[13][14] , \reg_buffer[13][13] ,
         \reg_buffer[13][12] , \reg_buffer[13][11] , \reg_buffer[13][10] ,
         \reg_buffer[13][9] , \reg_buffer[13][8] , \reg_buffer[13][7] ,
         \reg_buffer[13][6] , \reg_buffer[13][5] , \reg_buffer[13][4] ,
         \reg_buffer[13][3] , \reg_buffer[13][2] , \reg_buffer[13][1] ,
         \reg_buffer[13][0] , \reg_buffer[14][15] , \reg_buffer[14][14] ,
         \reg_buffer[14][13] , \reg_buffer[14][12] , \reg_buffer[14][11] ,
         \reg_buffer[14][10] , \reg_buffer[14][9] , \reg_buffer[14][8] ,
         \reg_buffer[14][7] , \reg_buffer[14][6] , \reg_buffer[14][5] ,
         \reg_buffer[14][4] , \reg_buffer[14][3] , \reg_buffer[14][2] ,
         \reg_buffer[14][1] , \reg_buffer[14][0] , \reg_buffer[15][15] ,
         \reg_buffer[15][14] , \reg_buffer[15][13] , \reg_buffer[15][12] ,
         \reg_buffer[15][11] , \reg_buffer[15][10] , \reg_buffer[15][9] ,
         \reg_buffer[15][8] , \reg_buffer[15][7] , \reg_buffer[15][6] ,
         \reg_buffer[15][5] , \reg_buffer[15][4] , \reg_buffer[15][3] ,
         \reg_buffer[15][2] , \reg_buffer[15][1] , \reg_buffer[15][0] , N24,
         N25, N26, N27, N28, N29, N30, N31, N32, N33, N34, N35, N36, N37, N38,
         N39, N40, N41, N42, N43, N44, N45, N46, N47, N48, N49, N50, N51, N52,
         N53, N54, N55, N56, N57, N58, N59, N60, N61, N62, N63, N64, N65, N66,
         N67, N68, N69, N70, N71, N72, N73, N74, N75, N76, N77, N78, N79, N80,
         N81, N82, N83, N84, N85, N86, N87, N88, N89, N90, N91, N92, N93, N94,
         N95, N96, N97, N98, N99, N100, N101, N102, N103, N104, N105, N106,
         N107, N108, N109, N110, N111, N112, N113, N114, N115, N116, N117,
         N118, N119, N120, N121, N122, N123, N124, N125, N126, N127, N128,
         N129, N130, N131, N132, N133, N134, N135, N136, N137, N138, N139,
         N140, N141, N142, N143, N144, N145, N146, N147, N148, N149, N150,
         N151, N152, N153, N154, N155, N156, N157, N158, N159, N160, N161,
         N162, N163, N164, N165, N166, N167, N168, N169, N170, N171, N172,
         N173, N174, N175, N176, N177, N178, N179, N180, N181, N182, N183,
         N184, N185, N186, N187, N188, N189, N190;
  wire   [3:0] rd_address;
  wire   [4:0] count;
  wire   [3:0] wr_address;

  GTECH_AND2 C14 ( .A(N188), .B(N185), .Z(N26) );
  GTECH_OR2 C16 ( .A(\fifo_if.wr_n ), .B(N185), .Z(N27) );
  GTECH_OR2 C19 ( .A(N188), .B(\fifo_if.rd_n ), .Z(N29) );
  GTECH_AND2 C21 ( .A(\fifo_if.wr_n ), .B(\fifo_if.rd_n ), .Z(N31) );
  \**SEQGEN**  \reg_buffer_reg[0][15]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [15]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[0][15] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N141) );
  \**SEQGEN**  \reg_buffer_reg[0][14]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [14]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[0][14] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N141) );
  \**SEQGEN**  \reg_buffer_reg[0][13]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [13]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[0][13] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N141) );
  \**SEQGEN**  \reg_buffer_reg[0][12]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [12]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[0][12] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N141) );
  \**SEQGEN**  \reg_buffer_reg[0][11]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [11]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[0][11] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N141) );
  \**SEQGEN**  \reg_buffer_reg[0][10]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [10]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[0][10] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N141) );
  \**SEQGEN**  \reg_buffer_reg[0][9]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [9]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[0][9] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N141) );
  \**SEQGEN**  \reg_buffer_reg[0][8]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [8]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[0][8] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N141) );
  \**SEQGEN**  \reg_buffer_reg[0][7]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [7]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[0][7] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N141) );
  \**SEQGEN**  \reg_buffer_reg[0][6]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [6]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[0][6] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N141) );
  \**SEQGEN**  \reg_buffer_reg[0][5]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [5]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[0][5] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N141) );
  \**SEQGEN**  \reg_buffer_reg[0][4]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [4]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[0][4] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N141) );
  \**SEQGEN**  \reg_buffer_reg[0][3]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [3]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[0][3] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N141) );
  \**SEQGEN**  \reg_buffer_reg[0][2]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [2]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[0][2] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N141) );
  \**SEQGEN**  \reg_buffer_reg[0][1]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [1]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[0][1] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N141) );
  \**SEQGEN**  \reg_buffer_reg[0][0]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [0]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[0][0] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N141) );
  \**SEQGEN**  \reg_buffer_reg[1][15]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [15]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[1][15] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N140) );
  \**SEQGEN**  \reg_buffer_reg[1][14]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [14]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[1][14] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N140) );
  \**SEQGEN**  \reg_buffer_reg[1][13]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [13]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[1][13] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N140) );
  \**SEQGEN**  \reg_buffer_reg[1][12]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [12]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[1][12] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N140) );
  \**SEQGEN**  \reg_buffer_reg[1][11]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [11]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[1][11] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N140) );
  \**SEQGEN**  \reg_buffer_reg[1][10]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [10]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[1][10] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N140) );
  \**SEQGEN**  \reg_buffer_reg[1][9]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [9]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[1][9] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N140) );
  \**SEQGEN**  \reg_buffer_reg[1][8]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [8]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[1][8] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N140) );
  \**SEQGEN**  \reg_buffer_reg[1][7]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [7]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[1][7] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N140) );
  \**SEQGEN**  \reg_buffer_reg[1][6]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [6]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[1][6] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N140) );
  \**SEQGEN**  \reg_buffer_reg[1][5]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [5]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[1][5] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N140) );
  \**SEQGEN**  \reg_buffer_reg[1][4]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [4]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[1][4] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N140) );
  \**SEQGEN**  \reg_buffer_reg[1][3]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [3]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[1][3] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N140) );
  \**SEQGEN**  \reg_buffer_reg[1][2]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [2]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[1][2] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N140) );
  \**SEQGEN**  \reg_buffer_reg[1][1]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [1]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[1][1] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N140) );
  \**SEQGEN**  \reg_buffer_reg[1][0]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [0]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[1][0] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N140) );
  \**SEQGEN**  \reg_buffer_reg[2][15]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [15]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[2][15] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N139) );
  \**SEQGEN**  \reg_buffer_reg[2][14]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [14]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[2][14] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N139) );
  \**SEQGEN**  \reg_buffer_reg[2][13]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [13]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[2][13] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N139) );
  \**SEQGEN**  \reg_buffer_reg[2][12]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [12]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[2][12] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N139) );
  \**SEQGEN**  \reg_buffer_reg[2][11]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [11]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[2][11] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N139) );
  \**SEQGEN**  \reg_buffer_reg[2][10]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [10]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[2][10] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N139) );
  \**SEQGEN**  \reg_buffer_reg[2][9]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [9]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[2][9] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N139) );
  \**SEQGEN**  \reg_buffer_reg[2][8]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [8]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[2][8] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N139) );
  \**SEQGEN**  \reg_buffer_reg[2][7]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [7]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[2][7] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N139) );
  \**SEQGEN**  \reg_buffer_reg[2][6]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [6]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[2][6] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N139) );
  \**SEQGEN**  \reg_buffer_reg[2][5]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [5]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[2][5] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N139) );
  \**SEQGEN**  \reg_buffer_reg[2][4]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [4]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[2][4] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N139) );
  \**SEQGEN**  \reg_buffer_reg[2][3]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [3]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[2][3] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N139) );
  \**SEQGEN**  \reg_buffer_reg[2][2]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [2]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[2][2] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N139) );
  \**SEQGEN**  \reg_buffer_reg[2][1]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [1]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[2][1] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N139) );
  \**SEQGEN**  \reg_buffer_reg[2][0]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [0]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[2][0] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N139) );
  \**SEQGEN**  \reg_buffer_reg[3][15]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [15]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[3][15] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N138) );
  \**SEQGEN**  \reg_buffer_reg[3][14]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [14]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[3][14] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N138) );
  \**SEQGEN**  \reg_buffer_reg[3][13]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [13]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[3][13] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N138) );
  \**SEQGEN**  \reg_buffer_reg[3][12]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [12]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[3][12] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N138) );
  \**SEQGEN**  \reg_buffer_reg[3][11]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [11]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[3][11] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N138) );
  \**SEQGEN**  \reg_buffer_reg[3][10]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [10]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[3][10] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N138) );
  \**SEQGEN**  \reg_buffer_reg[3][9]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [9]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[3][9] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N138) );
  \**SEQGEN**  \reg_buffer_reg[3][8]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [8]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[3][8] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N138) );
  \**SEQGEN**  \reg_buffer_reg[3][7]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [7]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[3][7] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N138) );
  \**SEQGEN**  \reg_buffer_reg[3][6]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [6]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[3][6] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N138) );
  \**SEQGEN**  \reg_buffer_reg[3][5]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [5]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[3][5] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N138) );
  \**SEQGEN**  \reg_buffer_reg[3][4]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [4]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[3][4] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N138) );
  \**SEQGEN**  \reg_buffer_reg[3][3]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [3]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[3][3] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N138) );
  \**SEQGEN**  \reg_buffer_reg[3][2]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [2]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[3][2] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N138) );
  \**SEQGEN**  \reg_buffer_reg[3][1]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [1]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[3][1] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N138) );
  \**SEQGEN**  \reg_buffer_reg[3][0]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [0]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[3][0] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N138) );
  \**SEQGEN**  \reg_buffer_reg[4][15]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [15]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[4][15] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N137) );
  \**SEQGEN**  \reg_buffer_reg[4][14]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [14]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[4][14] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N137) );
  \**SEQGEN**  \reg_buffer_reg[4][13]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [13]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[4][13] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N137) );
  \**SEQGEN**  \reg_buffer_reg[4][12]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [12]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[4][12] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N137) );
  \**SEQGEN**  \reg_buffer_reg[4][11]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [11]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[4][11] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N137) );
  \**SEQGEN**  \reg_buffer_reg[4][10]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [10]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[4][10] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N137) );
  \**SEQGEN**  \reg_buffer_reg[4][9]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [9]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[4][9] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N137) );
  \**SEQGEN**  \reg_buffer_reg[4][8]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [8]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[4][8] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N137) );
  \**SEQGEN**  \reg_buffer_reg[4][7]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [7]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[4][7] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N137) );
  \**SEQGEN**  \reg_buffer_reg[4][6]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [6]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[4][6] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N137) );
  \**SEQGEN**  \reg_buffer_reg[4][5]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [5]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[4][5] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N137) );
  \**SEQGEN**  \reg_buffer_reg[4][4]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [4]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[4][4] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N137) );
  \**SEQGEN**  \reg_buffer_reg[4][3]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [3]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[4][3] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N137) );
  \**SEQGEN**  \reg_buffer_reg[4][2]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [2]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[4][2] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N137) );
  \**SEQGEN**  \reg_buffer_reg[4][1]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [1]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[4][1] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N137) );
  \**SEQGEN**  \reg_buffer_reg[4][0]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [0]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[4][0] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N137) );
  \**SEQGEN**  \reg_buffer_reg[5][15]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [15]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[5][15] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N136) );
  \**SEQGEN**  \reg_buffer_reg[5][14]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [14]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[5][14] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N136) );
  \**SEQGEN**  \reg_buffer_reg[5][13]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [13]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[5][13] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N136) );
  \**SEQGEN**  \reg_buffer_reg[5][12]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [12]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[5][12] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N136) );
  \**SEQGEN**  \reg_buffer_reg[5][11]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [11]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[5][11] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N136) );
  \**SEQGEN**  \reg_buffer_reg[5][10]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [10]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[5][10] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N136) );
  \**SEQGEN**  \reg_buffer_reg[5][9]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [9]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[5][9] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N136) );
  \**SEQGEN**  \reg_buffer_reg[5][8]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [8]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[5][8] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N136) );
  \**SEQGEN**  \reg_buffer_reg[5][7]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [7]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[5][7] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N136) );
  \**SEQGEN**  \reg_buffer_reg[5][6]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [6]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[5][6] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N136) );
  \**SEQGEN**  \reg_buffer_reg[5][5]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [5]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[5][5] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N136) );
  \**SEQGEN**  \reg_buffer_reg[5][4]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [4]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[5][4] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N136) );
  \**SEQGEN**  \reg_buffer_reg[5][3]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [3]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[5][3] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N136) );
  \**SEQGEN**  \reg_buffer_reg[5][2]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [2]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[5][2] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N136) );
  \**SEQGEN**  \reg_buffer_reg[5][1]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [1]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[5][1] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N136) );
  \**SEQGEN**  \reg_buffer_reg[5][0]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [0]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[5][0] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N136) );
  \**SEQGEN**  \reg_buffer_reg[6][15]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [15]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[6][15] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N135) );
  \**SEQGEN**  \reg_buffer_reg[6][14]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [14]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[6][14] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N135) );
  \**SEQGEN**  \reg_buffer_reg[6][13]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [13]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[6][13] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N135) );
  \**SEQGEN**  \reg_buffer_reg[6][12]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [12]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[6][12] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N134) );
  \**SEQGEN**  \reg_buffer_reg[6][11]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [11]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[6][11] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N134) );
  \**SEQGEN**  \reg_buffer_reg[6][10]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [10]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[6][10] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N134) );
  \**SEQGEN**  \reg_buffer_reg[6][9]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [9]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[6][9] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N134) );
  \**SEQGEN**  \reg_buffer_reg[6][8]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [8]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[6][8] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N134) );
  \**SEQGEN**  \reg_buffer_reg[6][7]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [7]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[6][7] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N134) );
  \**SEQGEN**  \reg_buffer_reg[6][6]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [6]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[6][6] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N134) );
  \**SEQGEN**  \reg_buffer_reg[6][5]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [5]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[6][5] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N134) );
  \**SEQGEN**  \reg_buffer_reg[6][4]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [4]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[6][4] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N134) );
  \**SEQGEN**  \reg_buffer_reg[6][3]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [3]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[6][3] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N134) );
  \**SEQGEN**  \reg_buffer_reg[6][2]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [2]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[6][2] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N134) );
  \**SEQGEN**  \reg_buffer_reg[6][1]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [1]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[6][1] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N134) );
  \**SEQGEN**  \reg_buffer_reg[6][0]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [0]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[6][0] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N134) );
  \**SEQGEN**  \reg_buffer_reg[7][15]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [15]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[7][15] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N133) );
  \**SEQGEN**  \reg_buffer_reg[7][14]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [14]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[7][14] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N133) );
  \**SEQGEN**  \reg_buffer_reg[7][13]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [13]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[7][13] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N133) );
  \**SEQGEN**  \reg_buffer_reg[7][12]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [12]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[7][12] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N133) );
  \**SEQGEN**  \reg_buffer_reg[7][11]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [11]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[7][11] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N133) );
  \**SEQGEN**  \reg_buffer_reg[7][10]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [10]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[7][10] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N133) );
  \**SEQGEN**  \reg_buffer_reg[7][9]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [9]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[7][9] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N133) );
  \**SEQGEN**  \reg_buffer_reg[7][8]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [8]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[7][8] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N133) );
  \**SEQGEN**  \reg_buffer_reg[7][7]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [7]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[7][7] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N133) );
  \**SEQGEN**  \reg_buffer_reg[7][6]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [6]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[7][6] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N133) );
  \**SEQGEN**  \reg_buffer_reg[7][5]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [5]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[7][5] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N133) );
  \**SEQGEN**  \reg_buffer_reg[7][4]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [4]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[7][4] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N133) );
  \**SEQGEN**  \reg_buffer_reg[7][3]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [3]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[7][3] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N133) );
  \**SEQGEN**  \reg_buffer_reg[7][2]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [2]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[7][2] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N133) );
  \**SEQGEN**  \reg_buffer_reg[7][1]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [1]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[7][1] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N133) );
  \**SEQGEN**  \reg_buffer_reg[7][0]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [0]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[7][0] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N133) );
  \**SEQGEN**  \reg_buffer_reg[8][15]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [15]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[8][15] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N132) );
  \**SEQGEN**  \reg_buffer_reg[8][14]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [14]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[8][14] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N132) );
  \**SEQGEN**  \reg_buffer_reg[8][13]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [13]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[8][13] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N132) );
  \**SEQGEN**  \reg_buffer_reg[8][12]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [12]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[8][12] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N132) );
  \**SEQGEN**  \reg_buffer_reg[8][11]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [11]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[8][11] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N132) );
  \**SEQGEN**  \reg_buffer_reg[8][10]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [10]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[8][10] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N132) );
  \**SEQGEN**  \reg_buffer_reg[8][9]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [9]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[8][9] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N132) );
  \**SEQGEN**  \reg_buffer_reg[8][8]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [8]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[8][8] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N132) );
  \**SEQGEN**  \reg_buffer_reg[8][7]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [7]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[8][7] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N132) );
  \**SEQGEN**  \reg_buffer_reg[8][6]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [6]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[8][6] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N132) );
  \**SEQGEN**  \reg_buffer_reg[8][5]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [5]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[8][5] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N132) );
  \**SEQGEN**  \reg_buffer_reg[8][4]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [4]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[8][4] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N132) );
  \**SEQGEN**  \reg_buffer_reg[8][3]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [3]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[8][3] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N132) );
  \**SEQGEN**  \reg_buffer_reg[8][2]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [2]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[8][2] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N132) );
  \**SEQGEN**  \reg_buffer_reg[8][1]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [1]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[8][1] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N132) );
  \**SEQGEN**  \reg_buffer_reg[8][0]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [0]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[8][0] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N132) );
  \**SEQGEN**  \reg_buffer_reg[9][15]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [15]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[9][15] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N131) );
  \**SEQGEN**  \reg_buffer_reg[9][14]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [14]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[9][14] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N131) );
  \**SEQGEN**  \reg_buffer_reg[9][13]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [13]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[9][13] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N131) );
  \**SEQGEN**  \reg_buffer_reg[9][12]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [12]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[9][12] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N131) );
  \**SEQGEN**  \reg_buffer_reg[9][11]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [11]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[9][11] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N131) );
  \**SEQGEN**  \reg_buffer_reg[9][10]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [10]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[9][10] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N131) );
  \**SEQGEN**  \reg_buffer_reg[9][9]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [9]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[9][9] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N131) );
  \**SEQGEN**  \reg_buffer_reg[9][8]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [8]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[9][8] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N131) );
  \**SEQGEN**  \reg_buffer_reg[9][7]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [7]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[9][7] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N131) );
  \**SEQGEN**  \reg_buffer_reg[9][6]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [6]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[9][6] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N131) );
  \**SEQGEN**  \reg_buffer_reg[9][5]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [5]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[9][5] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N131) );
  \**SEQGEN**  \reg_buffer_reg[9][4]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [4]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[9][4] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N131) );
  \**SEQGEN**  \reg_buffer_reg[9][3]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [3]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[9][3] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N131) );
  \**SEQGEN**  \reg_buffer_reg[9][2]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [2]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[9][2] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N131) );
  \**SEQGEN**  \reg_buffer_reg[9][1]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [1]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[9][1] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N131) );
  \**SEQGEN**  \reg_buffer_reg[9][0]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [0]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[9][0] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N131) );
  \**SEQGEN**  \reg_buffer_reg[10][15]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [15]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[10][15] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N130) );
  \**SEQGEN**  \reg_buffer_reg[10][14]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [14]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[10][14] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N130) );
  \**SEQGEN**  \reg_buffer_reg[10][13]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [13]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[10][13] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N130) );
  \**SEQGEN**  \reg_buffer_reg[10][12]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [12]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[10][12] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N130) );
  \**SEQGEN**  \reg_buffer_reg[10][11]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [11]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[10][11] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N130) );
  \**SEQGEN**  \reg_buffer_reg[10][10]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [10]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[10][10] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N130) );
  \**SEQGEN**  \reg_buffer_reg[10][9]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [9]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[10][9] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N130) );
  \**SEQGEN**  \reg_buffer_reg[10][8]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [8]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[10][8] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N130) );
  \**SEQGEN**  \reg_buffer_reg[10][7]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [7]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[10][7] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N130) );
  \**SEQGEN**  \reg_buffer_reg[10][6]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [6]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[10][6] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N130) );
  \**SEQGEN**  \reg_buffer_reg[10][5]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [5]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[10][5] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N130) );
  \**SEQGEN**  \reg_buffer_reg[10][4]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [4]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[10][4] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N130) );
  \**SEQGEN**  \reg_buffer_reg[10][3]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [3]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[10][3] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N130) );
  \**SEQGEN**  \reg_buffer_reg[10][2]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [2]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[10][2] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N130) );
  \**SEQGEN**  \reg_buffer_reg[10][1]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [1]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[10][1] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N130) );
  \**SEQGEN**  \reg_buffer_reg[10][0]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [0]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[10][0] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N130) );
  \**SEQGEN**  \reg_buffer_reg[11][15]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [15]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[11][15] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N129) );
  \**SEQGEN**  \reg_buffer_reg[11][14]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [14]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[11][14] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N129) );
  \**SEQGEN**  \reg_buffer_reg[11][13]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [13]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[11][13] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N129) );
  \**SEQGEN**  \reg_buffer_reg[11][12]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [12]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[11][12] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N129) );
  \**SEQGEN**  \reg_buffer_reg[11][11]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [11]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[11][11] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N129) );
  \**SEQGEN**  \reg_buffer_reg[11][10]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [10]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[11][10] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N129) );
  \**SEQGEN**  \reg_buffer_reg[11][9]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [9]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[11][9] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N129) );
  \**SEQGEN**  \reg_buffer_reg[11][8]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [8]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[11][8] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N129) );
  \**SEQGEN**  \reg_buffer_reg[11][7]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [7]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[11][7] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N129) );
  \**SEQGEN**  \reg_buffer_reg[11][6]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [6]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[11][6] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N129) );
  \**SEQGEN**  \reg_buffer_reg[11][5]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [5]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[11][5] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N129) );
  \**SEQGEN**  \reg_buffer_reg[11][4]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [4]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[11][4] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N129) );
  \**SEQGEN**  \reg_buffer_reg[11][3]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [3]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[11][3] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N129) );
  \**SEQGEN**  \reg_buffer_reg[11][2]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [2]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[11][2] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N129) );
  \**SEQGEN**  \reg_buffer_reg[11][1]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [1]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[11][1] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N129) );
  \**SEQGEN**  \reg_buffer_reg[11][0]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [0]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[11][0] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N129) );
  \**SEQGEN**  \reg_buffer_reg[12][15]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [15]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[12][15] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N128) );
  \**SEQGEN**  \reg_buffer_reg[12][14]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [14]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[12][14] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N128) );
  \**SEQGEN**  \reg_buffer_reg[12][13]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [13]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[12][13] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N128) );
  \**SEQGEN**  \reg_buffer_reg[12][12]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [12]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[12][12] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N128) );
  \**SEQGEN**  \reg_buffer_reg[12][11]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [11]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[12][11] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N128) );
  \**SEQGEN**  \reg_buffer_reg[12][10]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [10]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[12][10] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N128) );
  \**SEQGEN**  \reg_buffer_reg[12][9]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [9]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[12][9] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N127) );
  \**SEQGEN**  \reg_buffer_reg[12][8]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [8]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[12][8] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N127) );
  \**SEQGEN**  \reg_buffer_reg[12][7]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [7]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[12][7] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N127) );
  \**SEQGEN**  \reg_buffer_reg[12][6]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [6]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[12][6] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N127) );
  \**SEQGEN**  \reg_buffer_reg[12][5]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [5]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[12][5] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N127) );
  \**SEQGEN**  \reg_buffer_reg[12][4]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [4]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[12][4] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N127) );
  \**SEQGEN**  \reg_buffer_reg[12][3]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [3]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[12][3] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N127) );
  \**SEQGEN**  \reg_buffer_reg[12][2]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [2]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[12][2] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N127) );
  \**SEQGEN**  \reg_buffer_reg[12][1]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [1]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[12][1] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N127) );
  \**SEQGEN**  \reg_buffer_reg[12][0]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [0]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[12][0] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N127) );
  \**SEQGEN**  \reg_buffer_reg[13][15]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [15]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[13][15] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N126) );
  \**SEQGEN**  \reg_buffer_reg[13][14]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [14]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[13][14] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N126) );
  \**SEQGEN**  \reg_buffer_reg[13][13]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [13]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[13][13] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N126) );
  \**SEQGEN**  \reg_buffer_reg[13][12]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [12]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[13][12] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N126) );
  \**SEQGEN**  \reg_buffer_reg[13][11]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [11]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[13][11] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N126) );
  \**SEQGEN**  \reg_buffer_reg[13][10]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [10]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[13][10] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N126) );
  \**SEQGEN**  \reg_buffer_reg[13][9]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [9]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[13][9] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N126) );
  \**SEQGEN**  \reg_buffer_reg[13][8]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [8]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[13][8] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N126) );
  \**SEQGEN**  \reg_buffer_reg[13][7]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [7]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[13][7] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N126) );
  \**SEQGEN**  \reg_buffer_reg[13][6]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [6]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[13][6] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N126) );
  \**SEQGEN**  \reg_buffer_reg[13][5]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [5]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[13][5] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N126) );
  \**SEQGEN**  \reg_buffer_reg[13][4]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [4]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[13][4] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N126) );
  \**SEQGEN**  \reg_buffer_reg[13][3]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [3]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[13][3] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N126) );
  \**SEQGEN**  \reg_buffer_reg[13][2]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [2]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[13][2] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N126) );
  \**SEQGEN**  \reg_buffer_reg[13][1]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [1]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[13][1] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N126) );
  \**SEQGEN**  \reg_buffer_reg[13][0]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [0]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[13][0] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N126) );
  \**SEQGEN**  \reg_buffer_reg[14][15]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [15]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[14][15] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N125) );
  \**SEQGEN**  \reg_buffer_reg[14][14]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [14]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[14][14] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N125) );
  \**SEQGEN**  \reg_buffer_reg[14][13]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [13]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[14][13] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N125) );
  \**SEQGEN**  \reg_buffer_reg[14][12]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [12]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[14][12] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N125) );
  \**SEQGEN**  \reg_buffer_reg[14][11]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [11]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[14][11] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N125) );
  \**SEQGEN**  \reg_buffer_reg[14][10]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [10]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[14][10] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N125) );
  \**SEQGEN**  \reg_buffer_reg[14][9]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [9]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[14][9] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N125) );
  \**SEQGEN**  \reg_buffer_reg[14][8]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [8]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[14][8] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N125) );
  \**SEQGEN**  \reg_buffer_reg[14][7]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [7]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[14][7] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N125) );
  \**SEQGEN**  \reg_buffer_reg[14][6]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [6]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[14][6] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N125) );
  \**SEQGEN**  \reg_buffer_reg[14][5]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [5]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[14][5] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N125) );
  \**SEQGEN**  \reg_buffer_reg[14][4]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [4]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[14][4] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N125) );
  \**SEQGEN**  \reg_buffer_reg[14][3]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [3]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[14][3] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N125) );
  \**SEQGEN**  \reg_buffer_reg[14][2]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [2]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[14][2] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N125) );
  \**SEQGEN**  \reg_buffer_reg[14][1]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [1]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[14][1] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N125) );
  \**SEQGEN**  \reg_buffer_reg[14][0]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [0]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[14][0] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N125) );
  \**SEQGEN**  \reg_buffer_reg[15][15]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [15]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[15][15] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N124) );
  \**SEQGEN**  \reg_buffer_reg[15][14]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [14]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[15][14] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N124) );
  \**SEQGEN**  \reg_buffer_reg[15][13]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [13]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[15][13] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N124) );
  \**SEQGEN**  \reg_buffer_reg[15][12]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [12]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[15][12] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N124) );
  \**SEQGEN**  \reg_buffer_reg[15][11]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [11]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[15][11] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N124) );
  \**SEQGEN**  \reg_buffer_reg[15][10]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [10]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[15][10] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N124) );
  \**SEQGEN**  \reg_buffer_reg[15][9]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [9]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[15][9] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N124) );
  \**SEQGEN**  \reg_buffer_reg[15][8]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [8]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[15][8] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N124) );
  \**SEQGEN**  \reg_buffer_reg[15][7]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [7]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[15][7] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N124) );
  \**SEQGEN**  \reg_buffer_reg[15][6]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [6]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[15][6] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N124) );
  \**SEQGEN**  \reg_buffer_reg[15][5]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [5]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[15][5] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N124) );
  \**SEQGEN**  \reg_buffer_reg[15][4]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [4]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[15][4] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N124) );
  \**SEQGEN**  \reg_buffer_reg[15][3]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [3]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[15][3] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N124) );
  \**SEQGEN**  \reg_buffer_reg[15][2]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [2]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[15][2] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N124) );
  \**SEQGEN**  \reg_buffer_reg[15][1]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [1]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[15][1] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N123) );
  \**SEQGEN**  \reg_buffer_reg[15][0]  ( .clear(1'b0), .preset(1'b0), 
        .next_state(\fifo_if.din [0]), .clocked_on(clk), .data_in(1'b0), 
        .enable(1'b0), .Q(\reg_buffer[15][0] ), .synch_clear(1'b0), 
        .synch_preset(1'b0), .synch_toggle(1'b0), .synch_enable(N122) );
  \**SEQGEN**  \wr_address_reg[3]  ( .clear(N24), .preset(1'b0), .next_state(
        N110), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        wr_address[3]), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(N106) );
  \**SEQGEN**  \wr_address_reg[2]  ( .clear(N24), .preset(1'b0), .next_state(
        N109), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        wr_address[2]), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(N106) );
  \**SEQGEN**  \wr_address_reg[1]  ( .clear(N24), .preset(1'b0), .next_state(
        N108), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        wr_address[1]), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(N106) );
  \**SEQGEN**  \wr_address_reg[0]  ( .clear(N24), .preset(1'b0), .next_state(
        N107), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        wr_address[0]), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(N106) );
  \**SEQGEN**  \rd_address_reg[3]  ( .clear(N24), .preset(1'b0), .next_state(
        N115), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        rd_address[3]), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(N111) );
  \**SEQGEN**  \rd_address_reg[2]  ( .clear(N24), .preset(1'b0), .next_state(
        N114), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        rd_address[2]), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(N111) );
  \**SEQGEN**  \rd_address_reg[1]  ( .clear(N24), .preset(1'b0), .next_state(
        N113), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        rd_address[1]), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(N111) );
  \**SEQGEN**  \rd_address_reg[0]  ( .clear(N24), .preset(1'b0), .next_state(
        N112), .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(
        rd_address[0]), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(N111) );
  \**SEQGEN**  \count_reg[4]  ( .clear(N24), .preset(1'b0), .next_state(N121), 
        .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(count[4]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(N116) );
  \**SEQGEN**  \count_reg[3]  ( .clear(N24), .preset(1'b0), .next_state(N120), 
        .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(count[3]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(N116) );
  \**SEQGEN**  \count_reg[2]  ( .clear(N24), .preset(1'b0), .next_state(N119), 
        .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(count[2]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(N116) );
  \**SEQGEN**  \count_reg[1]  ( .clear(N24), .preset(1'b0), .next_state(N118), 
        .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(count[1]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(N116) );
  \**SEQGEN**  \count_reg[0]  ( .clear(N24), .preset(1'b0), .next_state(N117), 
        .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(count[0]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(N116) );
  GTECH_OR2 C1109 ( .A(count[3]), .B(count[4]), .Z(N142) );
  GTECH_OR2 C1110 ( .A(count[2]), .B(N142), .Z(N143) );
  GTECH_OR2 C1111 ( .A(count[1]), .B(N143), .Z(N144) );
  GTECH_OR2 C1112 ( .A(count[0]), .B(N144), .Z(N145) );
  GTECH_NOT I_0 ( .A(N145), .Z(N146) );
  GTECH_NOT I_1 ( .A(count[0]), .Z(N147) );
  GTECH_OR2 C1115 ( .A(count[3]), .B(count[4]), .Z(N148) );
  GTECH_OR2 C1116 ( .A(count[2]), .B(N148), .Z(N149) );
  GTECH_OR2 C1117 ( .A(count[1]), .B(N149), .Z(N150) );
  GTECH_OR2 C1118 ( .A(N147), .B(N150), .Z(N151) );
  GTECH_NOT I_2 ( .A(N151), .Z(N152) );
  GTECH_NOT I_3 ( .A(count[4]), .Z(N153) );
  GTECH_OR2 C1121 ( .A(count[3]), .B(N153), .Z(N154) );
  GTECH_OR2 C1122 ( .A(count[2]), .B(N154), .Z(N155) );
  GTECH_OR2 C1123 ( .A(count[1]), .B(N155), .Z(N156) );
  GTECH_OR2 C1124 ( .A(count[0]), .B(N156), .Z(N157) );
  GTECH_NOT I_4 ( .A(N157), .Z(N158) );
  GTECH_NOT I_5 ( .A(count[3]), .Z(N159) );
  GTECH_NOT I_6 ( .A(count[2]), .Z(N160) );
  GTECH_NOT I_7 ( .A(count[1]), .Z(N161) );
  GTECH_OR2 C1130 ( .A(N159), .B(count[4]), .Z(N162) );
  GTECH_OR2 C1131 ( .A(N160), .B(N162), .Z(N163) );
  GTECH_OR2 C1132 ( .A(N161), .B(N163), .Z(N164) );
  GTECH_OR2 C1133 ( .A(N147), .B(N164), .Z(N165) );
  GTECH_NOT I_8 ( .A(N165), .Z(N166) );
  ADD_UNS_OP add_65 ( .A(wr_address), .B(1'b1), .Z({N51, N50, N49, N48}) );
  ADD_UNS_OP add_66 ( .A(rd_address), .B(1'b1), .Z({N55, N54, N53, N52}) );
  ADD_UNS_OP add_74 ( .A(rd_address), .B(1'b1), .Z({N84, N83, N82, N81}) );
  SUB_UNS_OP sub_75 ( .A(count), .B(1'b1), .Z({N89, N88, N87, N86, N85}) );
  ADD_UNS_OP add_70 ( .A(wr_address), .B(1'b1), .Z({N75, N74, N73, N72}) );
  ADD_UNS_OP add_71 ( .A(count), .B(1'b1), .Z({N80, N79, N78, N77, N76}) );
  GTECH_AND2 C1135 ( .A(wr_address[2]), .B(wr_address[3]), .Z(N167) );
  GTECH_AND2 C1136 ( .A(N0), .B(wr_address[3]), .Z(N168) );
  GTECH_NOT I_9 ( .A(wr_address[2]), .Z(N0) );
  GTECH_AND2 C1137 ( .A(wr_address[2]), .B(N1), .Z(N169) );
  GTECH_NOT I_10 ( .A(wr_address[3]), .Z(N1) );
  GTECH_AND2 C1138 ( .A(N2), .B(N3), .Z(N170) );
  GTECH_NOT I_11 ( .A(wr_address[2]), .Z(N2) );
  GTECH_NOT I_12 ( .A(wr_address[3]), .Z(N3) );
  GTECH_AND2 C1139 ( .A(wr_address[0]), .B(wr_address[1]), .Z(N171) );
  GTECH_AND2 C1140 ( .A(N4), .B(wr_address[1]), .Z(N172) );
  GTECH_NOT I_13 ( .A(wr_address[0]), .Z(N4) );
  GTECH_AND2 C1141 ( .A(wr_address[0]), .B(N5), .Z(N173) );
  GTECH_NOT I_14 ( .A(wr_address[1]), .Z(N5) );
  GTECH_AND2 C1142 ( .A(N6), .B(N7), .Z(N174) );
  GTECH_NOT I_15 ( .A(wr_address[0]), .Z(N6) );
  GTECH_NOT I_16 ( .A(wr_address[1]), .Z(N7) );
  GTECH_AND2 C1143 ( .A(N167), .B(N171), .Z(N47) );
  GTECH_AND2 C1144 ( .A(N167), .B(N172), .Z(N46) );
  GTECH_AND2 C1145 ( .A(N167), .B(N173), .Z(N45) );
  GTECH_AND2 C1146 ( .A(N167), .B(N174), .Z(N44) );
  GTECH_AND2 C1147 ( .A(N168), .B(N171), .Z(N43) );
  GTECH_AND2 C1148 ( .A(N168), .B(N172), .Z(N42) );
  GTECH_AND2 C1149 ( .A(N168), .B(N173), .Z(N41) );
  GTECH_AND2 C1150 ( .A(N168), .B(N174), .Z(N40) );
  GTECH_AND2 C1151 ( .A(N169), .B(N171), .Z(N39) );
  GTECH_AND2 C1152 ( .A(N169), .B(N172), .Z(N38) );
  GTECH_AND2 C1153 ( .A(N169), .B(N173), .Z(N37) );
  GTECH_AND2 C1154 ( .A(N169), .B(N174), .Z(N36) );
  GTECH_AND2 C1155 ( .A(N170), .B(N171), .Z(N35) );
  GTECH_AND2 C1156 ( .A(N170), .B(N172), .Z(N34) );
  GTECH_AND2 C1157 ( .A(N170), .B(N173), .Z(N33) );
  GTECH_AND2 C1158 ( .A(N170), .B(N174), .Z(N32) );
  GTECH_AND2 C1159 ( .A(wr_address[2]), .B(wr_address[3]), .Z(N175) );
  GTECH_AND2 C1160 ( .A(N8), .B(wr_address[3]), .Z(N176) );
  GTECH_NOT I_17 ( .A(wr_address[2]), .Z(N8) );
  GTECH_AND2 C1161 ( .A(wr_address[2]), .B(N9), .Z(N177) );
  GTECH_NOT I_18 ( .A(wr_address[3]), .Z(N9) );
  GTECH_AND2 C1162 ( .A(N10), .B(N11), .Z(N178) );
  GTECH_NOT I_19 ( .A(wr_address[2]), .Z(N10) );
  GTECH_NOT I_20 ( .A(wr_address[3]), .Z(N11) );
  GTECH_AND2 C1163 ( .A(wr_address[0]), .B(wr_address[1]), .Z(N179) );
  GTECH_AND2 C1164 ( .A(N12), .B(wr_address[1]), .Z(N180) );
  GTECH_NOT I_21 ( .A(wr_address[0]), .Z(N12) );
  GTECH_AND2 C1165 ( .A(wr_address[0]), .B(N13), .Z(N181) );
  GTECH_NOT I_22 ( .A(wr_address[1]), .Z(N13) );
  GTECH_AND2 C1166 ( .A(N14), .B(N15), .Z(N182) );
  GTECH_NOT I_23 ( .A(wr_address[0]), .Z(N14) );
  GTECH_NOT I_24 ( .A(wr_address[1]), .Z(N15) );
  GTECH_AND2 C1167 ( .A(N175), .B(N179), .Z(N71) );
  GTECH_AND2 C1168 ( .A(N175), .B(N180), .Z(N70) );
  GTECH_AND2 C1169 ( .A(N175), .B(N181), .Z(N69) );
  GTECH_AND2 C1170 ( .A(N175), .B(N182), .Z(N68) );
  GTECH_AND2 C1171 ( .A(N176), .B(N179), .Z(N67) );
  GTECH_AND2 C1172 ( .A(N176), .B(N180), .Z(N66) );
  GTECH_AND2 C1173 ( .A(N176), .B(N181), .Z(N65) );
  GTECH_AND2 C1174 ( .A(N176), .B(N182), .Z(N64) );
  GTECH_AND2 C1175 ( .A(N177), .B(N179), .Z(N63) );
  GTECH_AND2 C1176 ( .A(N177), .B(N180), .Z(N62) );
  GTECH_AND2 C1177 ( .A(N177), .B(N181), .Z(N61) );
  GTECH_AND2 C1178 ( .A(N177), .B(N182), .Z(N60) );
  GTECH_AND2 C1179 ( .A(N178), .B(N179), .Z(N59) );
  GTECH_AND2 C1180 ( .A(N178), .B(N180), .Z(N58) );
  GTECH_AND2 C1181 ( .A(N178), .B(N181), .Z(N57) );
  GTECH_AND2 C1182 ( .A(N178), .B(N182), .Z(N56) );
  SELECT_OP C1183 ( .DATA1({N32, N33, N34, N35, N36, N37, N38, N39, N40, N41, 
        N42, N43, N44, N45, N46, N47}), .DATA2({N56, N57, N58, N59, N60, N61, 
        N62, N63, N64, N65, N66, N67, N68, N69, N70, N71}), .DATA3({1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0}), .DATA4({1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), .CONTROL1(N16), 
        .CONTROL2(N17), .CONTROL3(N18), .CONTROL4(N19), .Z({N105, N104, N103, 
        N102, N101, N100, N99, N98, N97, N96, N95, N94, N93, N92, N91, N90})
         );
  GTECH_BUF B_0 ( .A(N26), .Z(N16) );
  GTECH_BUF B_1 ( .A(N28), .Z(N17) );
  GTECH_BUF B_2 ( .A(N30), .Z(N18) );
  GTECH_BUF B_3 ( .A(N31), .Z(N19) );
  SELECT_OP C1184 ( .DATA1(1'b1), .DATA2(1'b1), .DATA3(1'b0), .DATA4(1'b0), 
        .CONTROL1(N16), .CONTROL2(N17), .CONTROL3(N18), .CONTROL4(N19), .Z(
        N106) );
  SELECT_OP C1185 ( .DATA1({N51, N50, N49, N48}), .DATA2({N75, N74, N73, N72}), 
        .CONTROL1(N16), .CONTROL2(N17), .Z({N110, N109, N108, N107}) );
  SELECT_OP C1186 ( .DATA1(1'b1), .DATA2(1'b0), .DATA3(1'b1), .DATA4(1'b0), 
        .CONTROL1(N16), .CONTROL2(N17), .CONTROL3(N18), .CONTROL4(N19), .Z(
        N111) );
  SELECT_OP C1187 ( .DATA1({N55, N54, N53, N52}), .DATA2({N84, N83, N82, N81}), 
        .CONTROL1(N16), .CONTROL2(N18), .Z({N115, N114, N113, N112}) );
  SELECT_OP C1188 ( .DATA1(1'b0), .DATA2(1'b1), .DATA3(1'b1), .DATA4(1'b0), 
        .CONTROL1(N16), .CONTROL2(N17), .CONTROL3(N18), .CONTROL4(N19), .Z(
        N116) );
  SELECT_OP C1189 ( .DATA1({N80, N79, N78, N77, N76}), .DATA2({N89, N88, N87, 
        N86, N85}), .CONTROL1(N17), .CONTROL2(N18), .Z({N121, N120, N119, N118, 
        N117}) );
  MUX_OP C1190 ( .D0({\reg_buffer[0][0] , \reg_buffer[0][1] , 
        \reg_buffer[0][2] , \reg_buffer[0][3] , \reg_buffer[0][4] , 
        \reg_buffer[0][5] , \reg_buffer[0][6] , \reg_buffer[0][7] , 
        \reg_buffer[0][8] , \reg_buffer[0][9] , \reg_buffer[0][10] , 
        \reg_buffer[0][11] , \reg_buffer[0][12] , \reg_buffer[0][13] , 
        \reg_buffer[0][14] , \reg_buffer[0][15] }), .D1({\reg_buffer[1][0] , 
        \reg_buffer[1][1] , \reg_buffer[1][2] , \reg_buffer[1][3] , 
        \reg_buffer[1][4] , \reg_buffer[1][5] , \reg_buffer[1][6] , 
        \reg_buffer[1][7] , \reg_buffer[1][8] , \reg_buffer[1][9] , 
        \reg_buffer[1][10] , \reg_buffer[1][11] , \reg_buffer[1][12] , 
        \reg_buffer[1][13] , \reg_buffer[1][14] , \reg_buffer[1][15] }), .D2({
        \reg_buffer[2][0] , \reg_buffer[2][1] , \reg_buffer[2][2] , 
        \reg_buffer[2][3] , \reg_buffer[2][4] , \reg_buffer[2][5] , 
        \reg_buffer[2][6] , \reg_buffer[2][7] , \reg_buffer[2][8] , 
        \reg_buffer[2][9] , \reg_buffer[2][10] , \reg_buffer[2][11] , 
        \reg_buffer[2][12] , \reg_buffer[2][13] , \reg_buffer[2][14] , 
        \reg_buffer[2][15] }), .D3({\reg_buffer[3][0] , \reg_buffer[3][1] , 
        \reg_buffer[3][2] , \reg_buffer[3][3] , \reg_buffer[3][4] , 
        \reg_buffer[3][5] , \reg_buffer[3][6] , \reg_buffer[3][7] , 
        \reg_buffer[3][8] , \reg_buffer[3][9] , \reg_buffer[3][10] , 
        \reg_buffer[3][11] , \reg_buffer[3][12] , \reg_buffer[3][13] , 
        \reg_buffer[3][14] , \reg_buffer[3][15] }), .D4({\reg_buffer[4][0] , 
        \reg_buffer[4][1] , \reg_buffer[4][2] , \reg_buffer[4][3] , 
        \reg_buffer[4][4] , \reg_buffer[4][5] , \reg_buffer[4][6] , 
        \reg_buffer[4][7] , \reg_buffer[4][8] , \reg_buffer[4][9] , 
        \reg_buffer[4][10] , \reg_buffer[4][11] , \reg_buffer[4][12] , 
        \reg_buffer[4][13] , \reg_buffer[4][14] , \reg_buffer[4][15] }), .D5({
        \reg_buffer[5][0] , \reg_buffer[5][1] , \reg_buffer[5][2] , 
        \reg_buffer[5][3] , \reg_buffer[5][4] , \reg_buffer[5][5] , 
        \reg_buffer[5][6] , \reg_buffer[5][7] , \reg_buffer[5][8] , 
        \reg_buffer[5][9] , \reg_buffer[5][10] , \reg_buffer[5][11] , 
        \reg_buffer[5][12] , \reg_buffer[5][13] , \reg_buffer[5][14] , 
        \reg_buffer[5][15] }), .D6({\reg_buffer[6][0] , \reg_buffer[6][1] , 
        \reg_buffer[6][2] , \reg_buffer[6][3] , \reg_buffer[6][4] , 
        \reg_buffer[6][5] , \reg_buffer[6][6] , \reg_buffer[6][7] , 
        \reg_buffer[6][8] , \reg_buffer[6][9] , \reg_buffer[6][10] , 
        \reg_buffer[6][11] , \reg_buffer[6][12] , \reg_buffer[6][13] , 
        \reg_buffer[6][14] , \reg_buffer[6][15] }), .D7({\reg_buffer[7][0] , 
        \reg_buffer[7][1] , \reg_buffer[7][2] , \reg_buffer[7][3] , 
        \reg_buffer[7][4] , \reg_buffer[7][5] , \reg_buffer[7][6] , 
        \reg_buffer[7][7] , \reg_buffer[7][8] , \reg_buffer[7][9] , 
        \reg_buffer[7][10] , \reg_buffer[7][11] , \reg_buffer[7][12] , 
        \reg_buffer[7][13] , \reg_buffer[7][14] , \reg_buffer[7][15] }), .D8({
        \reg_buffer[8][0] , \reg_buffer[8][1] , \reg_buffer[8][2] , 
        \reg_buffer[8][3] , \reg_buffer[8][4] , \reg_buffer[8][5] , 
        \reg_buffer[8][6] , \reg_buffer[8][7] , \reg_buffer[8][8] , 
        \reg_buffer[8][9] , \reg_buffer[8][10] , \reg_buffer[8][11] , 
        \reg_buffer[8][12] , \reg_buffer[8][13] , \reg_buffer[8][14] , 
        \reg_buffer[8][15] }), .D9({\reg_buffer[9][0] , \reg_buffer[9][1] , 
        \reg_buffer[9][2] , \reg_buffer[9][3] , \reg_buffer[9][4] , 
        \reg_buffer[9][5] , \reg_buffer[9][6] , \reg_buffer[9][7] , 
        \reg_buffer[9][8] , \reg_buffer[9][9] , \reg_buffer[9][10] , 
        \reg_buffer[9][11] , \reg_buffer[9][12] , \reg_buffer[9][13] , 
        \reg_buffer[9][14] , \reg_buffer[9][15] }), .D10({\reg_buffer[10][0] , 
        \reg_buffer[10][1] , \reg_buffer[10][2] , \reg_buffer[10][3] , 
        \reg_buffer[10][4] , \reg_buffer[10][5] , \reg_buffer[10][6] , 
        \reg_buffer[10][7] , \reg_buffer[10][8] , \reg_buffer[10][9] , 
        \reg_buffer[10][10] , \reg_buffer[10][11] , \reg_buffer[10][12] , 
        \reg_buffer[10][13] , \reg_buffer[10][14] , \reg_buffer[10][15] }), 
        .D11({\reg_buffer[11][0] , \reg_buffer[11][1] , \reg_buffer[11][2] , 
        \reg_buffer[11][3] , \reg_buffer[11][4] , \reg_buffer[11][5] , 
        \reg_buffer[11][6] , \reg_buffer[11][7] , \reg_buffer[11][8] , 
        \reg_buffer[11][9] , \reg_buffer[11][10] , \reg_buffer[11][11] , 
        \reg_buffer[11][12] , \reg_buffer[11][13] , \reg_buffer[11][14] , 
        \reg_buffer[11][15] }), .D12({\reg_buffer[12][0] , \reg_buffer[12][1] , 
        \reg_buffer[12][2] , \reg_buffer[12][3] , \reg_buffer[12][4] , 
        \reg_buffer[12][5] , \reg_buffer[12][6] , \reg_buffer[12][7] , 
        \reg_buffer[12][8] , \reg_buffer[12][9] , \reg_buffer[12][10] , 
        \reg_buffer[12][11] , \reg_buffer[12][12] , \reg_buffer[12][13] , 
        \reg_buffer[12][14] , \reg_buffer[12][15] }), .D13({
        \reg_buffer[13][0] , \reg_buffer[13][1] , \reg_buffer[13][2] , 
        \reg_buffer[13][3] , \reg_buffer[13][4] , \reg_buffer[13][5] , 
        \reg_buffer[13][6] , \reg_buffer[13][7] , \reg_buffer[13][8] , 
        \reg_buffer[13][9] , \reg_buffer[13][10] , \reg_buffer[13][11] , 
        \reg_buffer[13][12] , \reg_buffer[13][13] , \reg_buffer[13][14] , 
        \reg_buffer[13][15] }), .D14({\reg_buffer[14][0] , \reg_buffer[14][1] , 
        \reg_buffer[14][2] , \reg_buffer[14][3] , \reg_buffer[14][4] , 
        \reg_buffer[14][5] , \reg_buffer[14][6] , \reg_buffer[14][7] , 
        \reg_buffer[14][8] , \reg_buffer[14][9] , \reg_buffer[14][10] , 
        \reg_buffer[14][11] , \reg_buffer[14][12] , \reg_buffer[14][13] , 
        \reg_buffer[14][14] , \reg_buffer[14][15] }), .D15({
        \reg_buffer[15][0] , \reg_buffer[15][1] , \reg_buffer[15][2] , 
        \reg_buffer[15][3] , \reg_buffer[15][4] , \reg_buffer[15][5] , 
        \reg_buffer[15][6] , \reg_buffer[15][7] , \reg_buffer[15][8] , 
        \reg_buffer[15][9] , \reg_buffer[15][10] , \reg_buffer[15][11] , 
        \reg_buffer[15][12] , \reg_buffer[15][13] , \reg_buffer[15][14] , 
        \reg_buffer[15][15] }), .S0(N20), .S1(N21), .S2(N22), .S3(N23), .Z({
        \fifo_if.dout  [0], \fifo_if.dout  [1], \fifo_if.dout  [2], 
        \fifo_if.dout  [3], \fifo_if.dout  [4], \fifo_if.dout  [5], 
        \fifo_if.dout  [6], \fifo_if.dout  [7], \fifo_if.dout  [8], 
        \fifo_if.dout  [9], \fifo_if.dout  [10], \fifo_if.dout  [11], 
        \fifo_if.dout  [12], \fifo_if.dout  [13], \fifo_if.dout  [14], 
        \fifo_if.dout  [15]}) );
  GTECH_BUF B_4 ( .A(rd_address[0]), .Z(N20) );
  GTECH_BUF B_5 ( .A(rd_address[1]), .Z(N21) );
  GTECH_BUF B_6 ( .A(rd_address[2]), .Z(N22) );
  GTECH_BUF B_7 ( .A(rd_address[3]), .Z(N23) );
  GTECH_OR2 C1193 ( .A(N183), .B(N186), .Z(\fifo_if.empty ) );
  GTECH_AND2 C1194 ( .A(N146), .B(\fifo_if.wr_n ), .Z(N183) );
  GTECH_AND2 C1195 ( .A(N184), .B(N185), .Z(N186) );
  GTECH_AND2 C1196 ( .A(N152), .B(\fifo_if.wr_n ), .Z(N184) );
  GTECH_NOT I_25 ( .A(\fifo_if.rd_n ), .Z(N185) );
  GTECH_OR2 C1198 ( .A(N187), .B(N190), .Z(\fifo_if.full ) );
  GTECH_AND2 C1199 ( .A(N158), .B(\fifo_if.rd_n ), .Z(N187) );
  GTECH_AND2 C1200 ( .A(N189), .B(\fifo_if.rd_n ), .Z(N190) );
  GTECH_AND2 C1201 ( .A(N166), .B(N188), .Z(N189) );
  GTECH_NOT I_26 ( .A(\fifo_if.wr_n ), .Z(N188) );
  GTECH_NOT I_27 ( .A(reset_n), .Z(N24) );
  GTECH_BUF B_8 ( .A(reset_n), .Z(N25) );
  GTECH_NOT I_28 ( .A(N27), .Z(N28) );
  GTECH_NOT I_29 ( .A(N29), .Z(N30) );
  GTECH_AND2 C1215 ( .A(N25), .B(N26) );
  GTECH_AND2 C1216 ( .A(N25), .B(N28) );
  GTECH_AND2 C1217 ( .A(N25), .B(N30) );
  GTECH_AND2 C1219 ( .A(N90), .B(reset_n), .Z(N122) );
  GTECH_AND2 C1221 ( .A(N90), .B(reset_n), .Z(N123) );
  GTECH_AND2 C1223 ( .A(N90), .B(reset_n), .Z(N124) );
  GTECH_AND2 C1224 ( .A(N91), .B(reset_n), .Z(N125) );
  GTECH_AND2 C1225 ( .A(N92), .B(reset_n), .Z(N126) );
  GTECH_AND2 C1226 ( .A(N93), .B(reset_n), .Z(N127) );
  GTECH_AND2 C1227 ( .A(N93), .B(reset_n), .Z(N128) );
  GTECH_AND2 C1228 ( .A(N94), .B(reset_n), .Z(N129) );
  GTECH_AND2 C1229 ( .A(N95), .B(reset_n), .Z(N130) );
  GTECH_AND2 C1230 ( .A(N96), .B(reset_n), .Z(N131) );
  GTECH_AND2 C1231 ( .A(N97), .B(reset_n), .Z(N132) );
  GTECH_AND2 C1232 ( .A(N98), .B(reset_n), .Z(N133) );
  GTECH_AND2 C1233 ( .A(N99), .B(reset_n), .Z(N134) );
  GTECH_AND2 C1234 ( .A(N99), .B(reset_n), .Z(N135) );
  GTECH_AND2 C1235 ( .A(N100), .B(reset_n), .Z(N136) );
  GTECH_AND2 C1236 ( .A(N101), .B(reset_n), .Z(N137) );
  GTECH_AND2 C1237 ( .A(N102), .B(reset_n), .Z(N138) );
  GTECH_AND2 C1238 ( .A(N103), .B(reset_n), .Z(N139) );
  GTECH_AND2 C1239 ( .A(N104), .B(reset_n), .Z(N140) );
  GTECH_AND2 C1240 ( .A(N105), .B(reset_n), .Z(N141) );
endmodule