bind axi4lite_dmac generic_props
  #(.ADDR_WIDTH (6), .DATA_WIDTH (32)) if_master (.*);

bind axi4lite_dmac axi4lite_props
  #(.AGENT_TYPE    (1), // SLAVE
    .ENABLE_ASSERT (0),
    .ENABLE_ASSUME (1),
    .ADDR_WIDTH    (32),
    .DATA_WIDTH    (32),
    .STRB_WIDTH    (4),
    .MAX_OUTS      (4))
axi4lite_chk
  (.ACLK    (CLK),
   .ARESETn (RSTN),
   .*);
