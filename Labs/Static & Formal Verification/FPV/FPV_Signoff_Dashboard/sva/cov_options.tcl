########################################################
# Coverage Setup
########################################################

# FC
# Avoid computing minimum set of constraints during Formal Core, this helps Formal Core performance
set_fml_var fml_formal_core_reduced_constraints false

# Enable new Formal Core orchestration
set_fml_var formal_core_flow_version v2

# If toggle coverage is enabled
# Include toggle of primary inputs in coverage analysis
set_app_var fml_cov_tgl_input_port true

# If toggle coverage is enabled
# Treat toggle coverage of undriven signals/inputs as unreachable
set_fml_var fml_cov_tgl_undriven_as_unr true

# FTA
# If branch coverage has been enabled
# Include branch coverage in analysis. This is currently a Beta feature
set_fml_var fml_cov_enable_branch_cov true


