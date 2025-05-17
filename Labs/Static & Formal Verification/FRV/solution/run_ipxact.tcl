# set environment directory with ENV_DIR
set ENV_DIR ..

# set design directory with SRC_DIR
set SRC_DIR $ENV_DIR/design
set ::env(SRC_DIR) $SRC_DIR

# set SVA directory with SVA_DIR
set SVA_DIR $ENV_DIR/sva
set ::env(SVA_DIR) $SVA_DIR

# execution directory
set RUN_DIR $ENV_DIR/run
set ::env(RUN_DIR) $RUN_DIR

# solution directory
set SOL_DIR $ENV_DIR/solution
set ::env(SOL_DIR) $SOL_DIR

# Enable FRV appmode
set_fml_appmode FRV

# read IP-XACT XML file and generate FRV checker file
frv_load -ipxact $SRC_DIR/xml/axi4lite_dmac.xml -auto_load

# read design and testbench files
read_file -top axi4lite_dmac -format sverilog -sva \
-vcs "-f $SOL_DIR/filelist.f $SVA_DIR/bind_frv.sv" 

# clock setting
create_clock CLK -period 100

# reset setting
create_reset RSTN -sense low 

sim_run -stable
sim_save_reset

check_fv

