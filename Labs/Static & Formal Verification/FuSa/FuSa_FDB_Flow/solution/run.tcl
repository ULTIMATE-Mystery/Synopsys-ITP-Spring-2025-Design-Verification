# Set FuSa mode
set_fml_var fml_enable_fusa_appmode true -global
set_fml_appmode FUSA

# Max Time Setting
set_fml_var fml_max_time 5M

# Max Mem Setting
set_fml_var fml_max_mem 16GB

# Load the faultlist
# (1) fusa_config -sff <file>.sff
# (2) fusa_config -fdb <prj> -fdb_server localhost:<dddd> -fdb_campaign <fc> 
fusa_config -fdb_campaign $::env(SNPS_FDB_FAULT_CAMPAIGN) -dut_path test

# Read/Compile the design
read_file -top test -format verilog -vcs "-sverilog -f ../design/rtl.f  "

# Specify clock(s) in the design
create_clock Clock -period 100 

# Specify reset(s) in the design
create_reset Reset_ -sense low 

# Initialize VCF environment
sim_run -stable
sim_save_reset

# Generate FuSa properties
fusa_generate

# Map OO status after observability to ON (Required for observability results to be in sync with FDB flow)
fusa_map_status OOB -sff_status ON

# Map DD status after detectability to NF (Required for detectability results to be in sync with FDB flow)
fusa_map_status DDT -sff_status NF 

# Run Structural analysis
set_fml_var fusa_run_mode  structural
check_fv -block
fusa_report

# Run Controllability analysis
set_fml_var fusa_run_mode  control
check_fv -block
fusa_report

# Run Observability analysis
set_fml_var fusa_run_mode  observe
check_fv -block
fusa_report

# Run Detectability analysis
set_fml_var fusa_run_mode  detect
check_fv -block
fusa_report

# Save results
fusa_save

# Report/Print status of faults in database
exec vc_fdb_report -campaign $::env(SNPS_FDB_FAULT_CAMPAIGN) -report output.sff

