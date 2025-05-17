// AMBA AHB Lite AIP instantiation
bind ahb_apb_bridge snps_ahb_lite_master_aip
  #(.AGENT_TYPE      (snps_ahb_aip_pkg::MASTER),
    .ADDR_WIDTH      (HADDR_WIDTH),
    .DATA_WIDTH      (DATA_WIDTH),
    .ERROR_IDLE      (1),
    .CHECK_MAX_WAITS (1),
    .MAX_WAITS       (16))
snps_ahb_lite_m
  (.hclk    (hclk),
   .hresetn (hresetn),
   .hprot   (4'b0),
   .hmastlock (1'b0),
   .*);

// AMBA APB AIP instantiation
bind ahb_apb_bridge snps_apb_aip
  #(.PROTOCOL_VER    (snps_apb_aip_pkg::AMBA3),
    .AGENT_TYPE      (snps_apb_aip_pkg::SLAVE),
    .PSEL_WIDTH      (PSEL_WIDTH),
    .ADDR_WIDTH      (PADDR_WIDTH),
    .WDATA_WIDTH     (DATA_WIDTH),
    .RDATA_WIDTH     (DATA_WIDTH),
    .CHECK_MAX_WAITS (1),
    .MAX_WAITS       (11),
    .PSLVERR_RCMND   (1))
snps_apb_s
  (.pclk    (hclk),
   .presetn (hresetn),
   .pselx   (psel),
   .pprot   (3'b0),
   .pstrb   (8'b0),
   .*);
