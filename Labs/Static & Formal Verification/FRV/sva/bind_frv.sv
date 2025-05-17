bind axi4lite_dmac snps_frv_gen_wrapper
  #(.ADDR_WIDTH  (6),
    .DATA_WIDTH  (32),
    .RSVD_MODE   (0),
    .BUS_LATENCY (1),
    .WR_LATENCY  (1),
    .RD_LATENCY  (1),
    .LATENCY_MD  (1),
    .OUTABLK_MD  (0),
    .COVER_TYPE  (3'h7),
    .COVER_WRITE (1),
    .COVER_READ  (1),
    .OUTADDR_EN  (1))
i_snps_frv_generic
  (.clk    (CLK),
   .resetn (RSTN),
   .addr   (RGADDR),
   .wren   ((RGCSEL &  RGWRITE & ~RGBUSY)),
   .wbe    (4'hf),
   .wdata  (RGWDATA),
   .rden   ((RGCSEL & ~RGWRITE & ~RGBUSY)),
   .rdata  (RGRDATA));

