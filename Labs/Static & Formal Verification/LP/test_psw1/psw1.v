module top(i11, i12, i21, i22, i3, i41, i42, i51, i52, i61, i62, 
   o21, o22, o23, VDD, VDD1, VDD2, VDD3, VDD4, VDD5, VSS);

input i11, i12, i21, i22, i3, i41, i42, i51, i52, i61, i62,
   VDD, VDD1, VDD2, VDD3, VDD4, VDD5, VSS;
output o21, o22, o23;
wire w61, w62;

// correct
PSW psw1 (.VDDSW(VDD1) , .VSS(VSS), .NSLEEPIN1(i11),
   .NSLEEPIN2(i12), .VDD(VDD));

// correct with ack
PSW psw2 (.VDDSW(VDD2) , .VSS(VSS) , .NSLEEPIN1(i21),
   .NSLEEPIN2(i22), .NSLEEPOUT1(o21), .NSLEEPOUT2(o22), .VDD(VDD));

// correct
PSW psw5 (.VDDSW(VDD5) , .VSS(VSS) , .NSLEEPIN1(i51),
   .NSLEEPIN2(i52), .VDD(VDD));

// input supply wrong
PSW inconn (.VDDSW(VDD1) , .VSS(VSS), .NSLEEPIN1(i11),
   .NSLEEPIN2(i12), .VDD(VDD1));

// output supply wrong
PSW outconn (.VDDSW(VDD3) , .VSS(VSS), .NSLEEPIN1(i11),
   .NSLEEPIN2(i12), .VDD(VDD));

// control wrong
PSW conconn (.VDDSW(VDD1) , .VSS(VSS), .NSLEEPIN1(i21),
   .NSLEEPIN2(i12), .VDD(VDD));

// ack wrong
PSW ackconn (.VDDSW(VDD2) , .VSS(VSS) , .NSLEEPIN1(i21),
   .NSLEEPIN2(i22), .NSLEEPOUT1(o23), .NSLEEPOUT2(o22), .VDD(VDD));

// not related to any policy
PSW nopol (.VDDSW(VDD3) , .VSS(VSS), .NSLEEPIN1(i3),
   .NSLEEPIN2(i3), .VDD(VDD3));

// rail order violation
PSW psw6 (.VDDSW(VDD6) , .VSS(VSS), .NSLEEPIN1(w61),
   .NSLEEPIN2(w62), .VDD(VDD));

endmodule
