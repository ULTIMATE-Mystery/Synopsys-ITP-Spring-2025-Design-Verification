// AMBA AHB Lite AIP instantiation
bind ahb_apb_bridge snps_<Step 1>
  #(.AGENT_TYPE      (snps_ahb_aip_pkg::<Step 2>),
    .ADDR_WIDTH      (<Step 4>),
    .DATA_WIDTH      (<Step 4>),
    .ERROR_IDLE      (1),
    .CHECK_MAX_WAITS (1),
    .MAX_WAITS       (16))
snps_ahb_lite_m
  (.hclk    (<Step 3>),
   .hresetn (<Step 3>),
   .*);

// AMBA APB AIP instantiation
bind ahb_apb_bridge snps_<Step 1>
  #(.PROTOCOL_VER    (snps_apb_aip_pkg::AMBA3),
    .AGENT_TYPE      (snps_apb_aip_pkg::<Step 2>),
    .PSEL_WIDTH      (<Step 4>),
    .ADDR_WIDTH      (<Step 4>),
    .WDATA_WIDTH     (<Step 4>),
    .RDATA_WIDTH     (<Step 4>),
    .CHECK_MAX_WAITS (1),
    .MAX_WAITS       (11),
    .PSLVERR_RCMND   (1))
snps_apb_s
  (.pclk    (<Step 3>),
   .presetn (<Step 3>),
   .pselx   (<Step 3>),
   .*);
