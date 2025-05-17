create_clock -name c1  -period 10 {clk1}
create_clock -name c2  -period 3 {clk2}
set_clock_groups -group {c1} -group {c2}  -asynchronous
