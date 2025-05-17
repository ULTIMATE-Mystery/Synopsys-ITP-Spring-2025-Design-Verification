module vlog_street_ctrl_fsm (clk, rst, 
    waiting, waiting_cross, state_cross,
    red, yellow, green, state_out);

input clk;
input rst;
input waiting;
input waiting_cross;
input [4:0] state_cross;
output red, yellow, green;
output [4:0] state_out;

parameter PRIORITY = 0;
parameter MAX_WAIT = 4;

parameter [4:0]  RESET = 5'b00001, // 1
                 SR0 =  5'b00010,  // 2
                 SR1 =  5'b00100,  // 4
                 SY  =  5'b01000,  // 10
                 SG  =  5'b10000;  // 20

reg [4:0] state_out, next_state;
reg red, yellow, green;

reg[3:0] timer;

// State register update
always @(posedge clk or posedge rst) begin
  if (rst)
     state_out <= RESET;
  else
     state_out <= next_state;
end

// Timer for cross street waiting time
always @(posedge clk or posedge rst) begin
  if (rst)
     timer <= 4'b0001;
  else begin
     if (state_out == SR1 && next_state == SG)
        timer <= 4'b0001;
     else if (timer != MAX_WAIT)
        timer <= timer + 4'b0001;
  end
end

// Next state logic
always @(*)
begin
   case(state_out)
      RESET : begin
               if (PRIORITY) next_state = SG;
               else next_state = SR0;
            end
      SR0 :
         next_state = SR1;
      SR1 : begin
            if (state_cross == SY) next_state = SG;
            else next_state = SR1;
            end
      SG : begin 
           if (waiting_cross && (~waiting || timer == MAX_WAIT))
              next_state = SY;
           else 
              next_state = SG;
           end
      SY :
         next_state = SR0;
      default : 
         next_state = 5'bxxxxx;
   endcase
end

// Output control logic
always @(state_out)
begin
   case(state_out)
      RESET, SR0, SR1:
      begin
         red    = 1;
         green  = 0;
         yellow = 0;
      end

      SG :
      begin
         green  = 1;
         yellow = 0;
         red    = 0;
      end

      SY :
      begin
         yellow = 1;
         green  = 0;
         red    = 0;
      end

   endcase
end

// Check one hot state encoding
`ifdef INLINE_SVA   
oh_state_out: assert property(
    @(posedge clk) disable iff (rst) $onehot(state_out));
`endif

endmodule
