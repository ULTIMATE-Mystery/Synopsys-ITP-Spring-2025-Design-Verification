# Set FuSa mode

# Max Time Setting
set_fml_var fml_max_time 5M

# Max Mem Setting
set_fml_var fml_max_mem 16GB

# Load the faultlist
# (1) fusa_config -sff <file>.sff
# (2) fusa_config -fdb <prj> -fdb_server localhost:<dddd> -fdb_campaign <fc> 

# Read/Compile the design

# Specify clock(s) in the design

# Specify reset(s) in the design

# Initialize VCF environment

# Generate FuSa properties

# Map OO status after observability to ON (Required for observability results to be in sync with FDB flow)
fusa_map_status OOB -sff_status ON

# Map DD status after detectability to NF (Required for detectability results to be in sync with FDB flow)
fusa_map_status DDT -sff_status NF 

# Add Observation/Detection point(s)

# Run Structural analysis

# Run Controllability analysis

# Run Observability analysis

# Run Detectability analysis

# Save results
