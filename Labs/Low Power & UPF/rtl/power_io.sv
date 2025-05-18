`ifndef POWER_IO__SV
`define POWER_IO__SV

interface power_io();

	logic[15:0] ipwrcon_pd_n;
	logic[15:0] opwrcon_pd_n;
	logic[15:0] ipwrcon_iso_n;
	logic[15:0] opwrcon_iso_n;
	logic[15:0] opwrcon_save_n;
	logic[15:0] opwrcon_restore_n;

endinterface: power_io

`endif