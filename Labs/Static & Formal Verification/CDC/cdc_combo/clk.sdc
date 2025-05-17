create_clock -name c1  -period 10 {clk1}
create_clock -name c2  -period 3 {clk2}
create_clock -name c3  -period 7 {clk3}

set_clock_groups -group {c1} -group {c2} -group {c3} -asynchronous

