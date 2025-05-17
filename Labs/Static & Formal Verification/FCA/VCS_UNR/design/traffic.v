
module traffic(green_main, yellow_main, red_main, green_first, yellow_first, 
               red_first, clk, rst, waiting_main, waiting_first);

input rst;
input clk;
input waiting_main;
input waiting_first;
output green_main, yellow_main, red_main, 
       green_first, yellow_first, red_first;

//parameter MAX_WAIT = 4;

wire [4:0] state_first;
wire [4:0] state_main;

vlog_street_ctrl_fsm #(1, 4) main(.clk           (clk), 
                 .rst           (rst), 
                 .waiting       (waiting_main),
                 .waiting_cross (waiting_first), 
                 .state_cross   (state_first),
                 .red           (red_main), 
                 .yellow        (yellow_main), 
                 .green         (green_main),
                 .state_out     (state_main)
                );


vlog_street_ctrl_fsm #(0, 4) first(.clk           (clk), 
                  .rst           (rst), 
                  .waiting       (waiting_first),
                  .waiting_cross (waiting_main), 
                  .state_cross   (state_main),
                  .red           (red_first), 
                  .yellow        (yellow_first), 
                  .green         (green_first),
                  .state_out     (state_first)
                );
`ifdef SNPS_INSTANCE
checker chk (clk,rst,
              waiting_main, waiting_first,
              green_main,green_first, yellow_main,yellow_first,
              red_main,red_first,state_main, state_first);
`endif

   reg 	   dummy_reg;
   always @(posedge clk or posedge rst)
     if (rst) dummy_reg <= 0;
     else dummy_reg <= 1'bx;
endmodule

