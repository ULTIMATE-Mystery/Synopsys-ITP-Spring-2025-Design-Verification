# dc_setup.tcl

set_app_var search_path "$search_path $ADDITIONAL_SEARCH_PATH"
set_app_var target_library $TARGET_LIBRARY_FILES
set_app_var link_library "* $target_library"
#set_app_var link_library "* $target_library dw_foundation.sldb"
# set_app_var link_library "* $target_library $synthetic_library"
# set_app_var symbol_library $SYMBOL_LIBRARY_FILES

# set_app_var mw_reference_library $MW_REFERENCE_LIB_DIRS
# set_app_var mw_design_library $MW_DESIGN_LIB

# Only create new Milkyway design library if it doesn't already exist
#     if {![file isdirectory $mw_design_library ]} {
#       create_mw_lib   -technology $TECH_FILE -mw_reference_library $mw_reference_library $mw_design_library
#     } else {
# If Milkyway design library already exists, continue by opening the existing library
#     }

# open_mw_lib     $mw_design_library
# set_tlu_plus_files -max_tluplus $TLUPLUS_MAX_FILE -tech2itf_map $MAP_FILE