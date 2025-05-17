module generic_props
  #(parameter ADDR_WIDTH  = 6,
    parameter DATA_WIDTH  = 32)
   (input logic                  CLK,
    input logic 		 RSTN,
    input logic [ADDR_WIDTH-1:0] RGADDR,
    input logic 		 RGCSEL,
    input logic 		 RGWRITE,
    input logic 		 RGBUSY,
    input logic [DATA_WIDTH-1:0] RGWDATA,
    input logic [DATA_WIDTH-1:0] RGRDATA);

   bit reset_done;
   always @(posedge CLK)
     reset_done <= ~RSTN;

   property p_lower_addr;
      @(posedge CLK) disable iff (!RSTN)
	(RGADDR[1:0]==2'b0);
   endproperty
   property p_csel_reset;
      @(posedge CLK) disable iff (!RSTN)
	(reset_done==1'b1) |-> (RGCSEL==1'b0);
   endproperty
   property p_csel_pulse;
      @(posedge CLK) disable iff (!RSTN)
	(RGCSEL==1'b1) |=> (RGCSEL==1'b0);
   endproperty

   asm_lower_addr : assume property(p_lower_addr);
   asm_csel_reset : assume property(p_csel_reset);
   asm_csel_pulse : assume property(p_csel_pulse);

endmodule // generic_props
