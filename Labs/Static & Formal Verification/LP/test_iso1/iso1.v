module top (iso1, iso2, iso3, vdd, vss, vdda, vdda2, vdda3, vddb,
   ai0, ai1, ai2, ai3, ai4, ai5, ai6, ai7, ai8, ai9, ai10, ai11,
   bi0, bi1, bi2, bi3, bi4, bi5, bi6, bi7, bi8, bi9, bi10, bi11,
   ao0, ao1, ao2, ao3, ao4, ao5, ao6, ao7, ao8, ao9, ao10, ao11,
   bo0, bo1, bo2, bo3, bo4, bo5, bo6, bo7, bo8, bo9, bo10, bo11);

   input iso1, iso2, iso3, vdd, vss, vdda, vdda2, vdda3, vddb;
   input ai0, ai1, ai2, ai3, ai4, ai5, ai6, ai7, ai8, ai9, ai10, ai11;
   input bi0, bi1, bi2, bi3, bi4, bi5, bi6, bi7, bi8, bi9, bi10, bi11;
   output ao0, ao1, ao2, ao3, ao4, ao5, ao6, ao7, ao8, ao9, ao10, ao11;
   output bo0, bo1, bo2, bo3, bo4, bo5, bo6, bo7, bo8, bo9, bo10, bo11;
   wire aw0, aw1, aw2, aw3, aw4, aw5, aw6, aw7, aw8, aw9, aw10, aw11;
   wire bo0, bo1, bo2, bo3, bo4, bo5, bo6, bo7, bo8, bo9, bo10, bo11;
   wire dangle, isoinv;

   // A and related isolation
   ma ua (.iso1(iso1), .ai0(ai0), .ai1(ai1), .ai2(ai2), .ai3(ai3),
      .ai4(ai4), .ai5(ai5), .ai6(ai6), .ai7(ai7), .ai8(ai8), .ai9(ai9),
      .ai10(ai10), .ai11(ai11), .ao0(aw0), .ao1(aw1), .ao2(aw2),
      .ao3(aw3), .ao4(aw4), .ao5(aw5), .ao6(aw6), .ao7(aw7),
      .ao8(aw8), .ao9(aw9), .ao10(aw10), .ao11(aw11));
   ISOLO a0 (.I(aw0), .ISO(iso1), .Z(ao0), .VDDAON(vdda),
      .VSS(vss)); // wrong power
   ISOLO a1 (.I(aw1), .ISO(iso1), .Z(ao1), .VDDAON(vdda2),
      .VSS(vss)); // insufficient power, special policy
   ISOLO a2 (.I(aw2), .ISO(iso2), .Z(ao2)); // wrong iso signal
   ISOLO a3 (.I(iso1), .ISO(aw3), .Z(ao3)); // swapped data, 
      // control -- NOT VIOLATING?
   DTINV i4 (.I(iso1), .ZN(isoinv)); // set up for wrong polarity
   ISOLO a4 (.I(aw4), .ISO(isoinv), .Z(ao4)); // wrong polarity
   ISOLO a5 (.I(aw5), .ISO(iso1), .Z(ao5), .VDDAON(vdd),
      .VSS(vss)); // correct power
   ISOLO a8 (.I(1'b1), .ISO(iso1), .Z(ao8)); // tiehi
   ISOLO a9 (.ISO(iso1), .Z(bo9)); // open
   ISOLO a10 (.I(dangle), .ISO(iso1), .Z(ao10)); // dangling net
   DTINV a11 (.I(aw11), .ZN(ao11)); // to pull wrong-loc from below

   // B and related isolation
   mb ub (.bi0(bi0), .bi1(bi1), .bi2(bi2), .bi3(bi3),
      .bo0(bo0), .bo1(bo1), .bo2(bo2), .bo3(bo3),
      .vdd(vdd), .vddb(vddb), .vss(vss));
   ISOLO b0 (.I(bw0), .ISO(iso1), .Z(bo0)); // unneeded, no policy
   ISOLO b1 (.I(bw1), .ISO(iso1), .Z(bo1)); // unneeded, policy
   DTINV b2 (.I(bw2), .ZN(bo2)); // no isolation, policy
   DTINV b3 (.I(bw3), .ZN(bo3)); // neither isolation nor policy
endmodule

module ma (iso1,
   ai0, ai1, ai2, ai3, ai4, ai5, ai6, ai7, ai8, ai9, ai10, ai11,
   ao0, ao1, ao2, ao3, ao4, ao5, ao6, ao7, ao8, ao9, ao10, ao11);

   input iso1;
   input ai0, ai1, ai2, ai3, ai4, ai5, ai6, ai7, ai8, ai9, ai10, ai11;
   output ao0, ao1, ao2, ao3, ao4, ao5, ao6, ao7, ao8, ao9, ao10, ao11;
   wire w11;
   DTINV u0 (.I(ai0),  .ZN(ao0));
   DTINV u1 (.I(ai1),  .ZN(ao1));
   DTINV u2 (.I(ai2),  .ZN(ao2));
   DTINV u3 (.I(ai3),  .ZN(ao3));
   DTINV u4 (.I(ai4),  .ZN(ao4));
   DTINV u5 (.I(ai5),  .ZN(ao5));
   DTINV u6 (.I(ai6),  .ZN(ao6));
   DTINV u7 (.I(ai7),  .ZN(ao7));
   DTINV u8 (.I(ai8),  .ZN(ao8));
   DTINV u9 (.I(ai9),  .ZN(ao9));
   DTINV ua (.I(ai10), .ZN(ao10));
   DTINV ub (.I(ai11), .ZN(w11));
   ISOLO ib (.I(w11), .ISO(iso1), .Z(ao11)); // wrong
      // location -- NOT VIOLATING?
endmodule

module mb (bi0, bi1, bi2, bi3, bo0, bo1, bo2, bo3, vdd, vddb, vss);
   input vdd, vddb, vss, bi0, bi1, bi2, bi3;
   output bo0, bo1, bo2, bo3;
   DTINV u0 (.I(bi0), .ZN(bo0), .VDD(vddb), .VSS(vss)); // right
   DTINV u1 (.I(bi1), .ZN(bo1), .VDD(vdd), .VSS(vss)); // wrong
   DTINV u2 (.I(bi2), .ZN(bo2));
   DTINV u3 (.I(bi3), .ZN(bo3));
endmodule

