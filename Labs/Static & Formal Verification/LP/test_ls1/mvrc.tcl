exec mvcmp ls1.v -log mvcmp.design.log
exec mvcmp -upf ls1.upf -log mvcmp.upf.log
exec mvdbgen -rc -top top -write_xover xover.txt -write_pbp pbp.txt -write_mv apf.txt -unconnected_src -unconnected_sink -log mvdbgen.log
exec mvphydbgen -top top -log mvphydbgen.log
read_db
read_phydb
check_design -netlist
quit
