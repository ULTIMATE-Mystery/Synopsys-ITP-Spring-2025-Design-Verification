module chip_top (
                 output ibe,
                 output din,
                 output obe,
                 output dout,
                 output ds,
                 output sr,
                 output se,
                 output pe,
                 output pd,
                 input [3:0] test_in,
                 input [3:0] moda_in,
                 input [3:0] modb_in,
                 input [3:0] gpio_in,
                 input [5:0] test_ctl_in,
                 input [6:0] port_ctl_in
                 );

   wire [3:0]          test;
   wire [3:0]          moda;
   wire [3:0]          modab;
   wire [3:0]          modb;
   wire [3:0]          gpio;
   wire [3:0]          modbg;
   wire [6:0]          port_ctl;
   wire [5:0]          test_ctl;
   

   DUMMY #4 Test (.din(test_in),.dumout(test));
   DUMMY #4 ModA (.din(moda_in),.dumout(moda));
   DUMMY #4 ModB (.din(modb_in),.dumout(modb));
   DUMMY #4 GPIO (.din(gpio_in),.dumout(gpio));
   DUMMY #7 PORTC (.din(port_ctl_in),.dumout(port_ctl));
   DUMMY #6 TESTC (.din(test_ctl_in),.dumout(test_ctl));
                   
   mux #4 test_mux (.mux_in0(test),
                    .mux_in1(modab),
                    .mux_en(test_ctl[5]),
                    .mux_out({ibe,din,obe,dout})
                    );

   mux #4 moda_mux (.mux_in0(moda),
                    .mux_in1(modbg),
                    .mux_en(port_ctl[5]),
                    .mux_out(modab)
                    );


   mux #4 modb_mux (.mux_in0(modb),
                    .mux_in1(gpio),
`ifndef RTL_BUG_FIX		    
                    .mux_en(port_ctl[5]),
`else		    
                    .mux_en(port_ctl[6]),
`endif		    
                    .mux_out(modbg)
                    );

   
   mux #5 port_test_mux (.mux_in0(port_ctl[4:0]),
                         .mux_in1(test_ctl[4:0]),
                         .mux_en(test_ctl[5]),
                         .mux_out({ds,sr,se,pe,pd})
                         );

endmodule 


module mux (mux_in0, mux_in1, mux_en,mux_out);
   parameter width = 1;

   input [width-1 : 0] mux_in0;
   input [width-1 : 0] mux_in1;
   input               mux_en;
   output wire [width-1 : 0] mux_out;
   
   assign mux_out = ~mux_en ? mux_in1 : mux_in0;
endmodule

module DUMMY (din, dumout);
   parameter width = 1;

   input [width-1:0] din;
   output wire [width-1:0] dumout;
   assign dumout  = din;
endmodule

