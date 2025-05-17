module top (vdd, vss, vdda, vddb, vddc, clk, save, rest, iso,
   i0, i1, i2, i3, i4, i5, o0, o1, o2, o3, o4, o5);

   input  vdd, vss, vdda, vddb, vddc, clk, save, rest, iso;
   input i0, i1, i2, i3, i4, i5;
   output o0, o1, o2, o3, o4, o5;

   ma ua (.clk(clk), .save(save), .rest(rest), .iso(iso), .i0(i0),
      .i1(i1), .i2(i2), .vdd(vdd), .vdda(vdda), .vddb(vddb),
      .vddc(vddc), .vss(vss), .o0(o0), .o1(o1), .o2(o2), .si(si));
   mb ub (.clk(clk), .save(save), .rest(rest), .si(si), .i0(i3),
      .i1(i4), .i2(i5), .vdd(vdd), .vdda(vdda), .vddb(vddb),
      .vddc(vddc), .vss(vss), .o0(o4), .o1(o5), .o2(o6));
endmodule

module ma (clk, save, rest, iso, i0, i1, i2, vss, vdd, vdda, vddb,
   vddc, o0, o1, o2, si);

   input clk, save, rest, iso, i0, i1, i2, vss, vdd, vdda, vddb, vddc;
   output o0, o1, o2, si;
   // i0, o0 unused: room for expansion
   AONBUF u1 (.I(i1),  .Z(o1), .VDD(vdda), .VDDAON(vdd), .VSS(vss)); // rails-equiv
   AONBUF u2 (.I(i2),  .Z(o2), .VDDAON(vdda), .VSS(vss)); // primary unconn
   // isolation gate on save, for isolated global signal
   ISOLO  us (.I(save), .ISO(iso), .Z(si), .VDD(vdda), .VDDAON(vddaon),
      .VSS(vss));
endmodule

module mb (clk, save, si, rest, i0, i1, i2, vss, vdd, vdda, vddb, vddc,
   o0, o1, o2);

   input clk, save, si, rest, i0, i1, i2, vss, vdd, vdda, vddb, vddc;
   output o0, o1, o2;
   wire w1, w2, sc;
   INV n2 (.I(save),  .ZN(sc), .VDD(vddb), .VSS(vss)); // corrupts save on f2
   RETFF f1 (.D(i0), .CP(clk), .S(si), .R(rest), .Q(w1), .VDD(vddb),
       .VDDAON(vdd), .VSS(vss)); // si is coming through iso gate
   RETFF f2 (.D(w1), .CP(clk), .S(sc),   .R(rest), .Q(w2), .VDD(vddb),
       .VSS(vss)); // backup unconn
   RETFF f3 (.D(w2), .CP(clk), .S(save), .R(rest), .Q(o0), .VDD(vddb),
      .VDDAON(1'b1), .VSS(vss)); // backup tiehi
   AONBUF u1 (.I(i1),  .Z(o1), .VDD(vddb), .VDDAON(vddb), .VSS(vss)); // sink state
   AONBUF u2 (.I(i2),  .Z(o2), .VDD(vddb), .VDDAON(vddc), .VSS(vss)); // prim state
endmodule
