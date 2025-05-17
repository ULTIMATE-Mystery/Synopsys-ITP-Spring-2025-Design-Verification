set_fml_appmode FPV

########################################################
## AIP Setup
########################################################
aip_load -protocol {APB AHB}

########################################################
## Setup Specific to DUT
########################################################
set design ahb_apb_bridge

########################################################
## Compile & Setup
########################################################
# Compilation Step 
read_file -top $design -format sverilog -sva -vcs \
     {-f ../design/filelist ../sva/bind_ahb_apb_bridge.sv}

# Clock Definitions 
create_clock hclk -period 100 
# Reset Definitions 
create_reset hresetn -sense low

# Initialisation Commands 
sim_run -stable 
sim_save_reset

########################################################
## Property Setup
########################################################
fvdisable {
  ahb_apb_bridge.snps_ahb_lite_m.CFG_AHB_LITE_COVER.cov_snps_ahb_hmastlock_locked
  ahb_apb_bridge.snps_ahb_lite_m.CFG_COVER.cov_snps_ahb_hprot_data_access 
  ahb_apb_bridge.snps_ahb_lite_m.CFG_COVER.cov_snps_ahb_hprot_privileged_access 
  ahb_apb_bridge.snps_ahb_lite_m.CFG_COVER.cov_snps_ahb_hprot_bufferable 
  ahb_apb_bridge.snps_ahb_lite_m.CFG_COVER.cov_snps_ahb_hprot_cacheable
}

fvassume asm_hready_hreadyout -expr {hready==hreadyout}
