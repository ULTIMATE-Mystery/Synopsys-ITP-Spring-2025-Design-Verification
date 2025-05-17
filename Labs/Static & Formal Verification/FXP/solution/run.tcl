set_fml_appmode FXP

set design pipeline

read_file -top $design -format sverilog -sva -vcs {../design/pipeline_fixed.v}

create_clock clk -period 100
create_reset resetn -sense low

sim_run -stable
sim_save_reset

fxp_generate


