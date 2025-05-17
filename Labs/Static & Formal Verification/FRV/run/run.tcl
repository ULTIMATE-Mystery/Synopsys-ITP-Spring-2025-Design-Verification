# set environment directory with ENV_DIR
set ENV_DIR ..

# set design directory with SRC_DIR
set SRC_DIR $ENV_DIR/design
set ::env(SRC_DIR) $SRC_DIR

# set SVA directory with SVA_DIR
set SVA_DIR $ENV_DIR/sva
set ::env(SVA_DIR) $SVA_DIR

# Enable FRV appmode
set_fml_

# read IP-XACT XML file or RALF and generate FRV checker file
frv_

# read design and testbench files
read_file 

# clock setting
create_clock

# reset setting
create_reset

sim_
sim_

