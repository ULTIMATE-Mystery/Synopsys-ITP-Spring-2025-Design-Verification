exec mvcmp psw1.v -log mvcmp.design.log
exec mvcmp -upf psw1.upf -log mvcmp.upf.log
exec mvdbgen -rc -top top -rc -write_xover xover.txt -write_pbp pbp.txt -write_mv apf.txt -unconnected_src -unconnected_sink -log mvdbgen.log
exec mvphydbgen -top top -log mvphydbgen.log
read_db
read_phydb
check_design -pgnetlist -verbose
quit
