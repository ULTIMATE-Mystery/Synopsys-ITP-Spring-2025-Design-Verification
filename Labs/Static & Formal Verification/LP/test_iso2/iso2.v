module top (iso,
   ai0, ai1, ai2, ai3, ai4, ai5, ai6, ai7,
   ao0, ao1, ao2, ao3, ao4, ao5, ao6, ao7);

   input iso;
   input  ai0, ai1, ai2, ai3, ai4, ai5, ai6, ai7;
   output ao0, ao1, ao2, ao3, ao4, ao5, ao6, ao7;
   wire   aw0, aw1, aw2, aw3, aw4, aw5, aw6, aw7;
   wire aw00, aw01;

   ma ua (.ai0(ai0), .ai1(ai1), .ai2(ai2), .ai3(ai3), .ai4(ai4),
      .ai5(ai5), .ai6(ai6), .ai7(ai7), .ao0(aw0), .ao1(aw1),
      .ao2(aw2), .ao3(aw3), .ao4(aw4), .ao5(aw5), .ao6(aw6),
      .ao7(aw7));
   ISOLO a0  (.I(aw0),  .ISO(iso), .Z(aw00)); // redundant
   ISOLO a00 (.I(aw00), .ISO(iso), .Z(aw01)); // more redundant
   ISOLO a01 (.I(aw01), .ISO(iso), .Z(ao0));
   ISOLO a1  (.I(iso),  .ISO(aw1), .Z(ao1)); // swap data/enable
   ISOHI a2  (.I(aw2),  .ISO(iso), .Z(ao2)); // clamp invert
   assign ao3 = 1'b1; // constant clamp mismatch -- not coming
   INTIBUF a4 (.I(aw4), .Z(ao4)); // policy redundant
   ISOLO a5  (.I(aw5),  .ISO(iso), .Z(ao5)); // redundant, in child
   DTINV a6  (.I(aw6), .ZN(ao6)); // in child, but no_iso
   ISOLO a7  (.I(aw7),  .ISO(iso), .Z(ao7));

endmodule

module ma (
   ai0, ai1, ai2, ai3, ai4, ai5, ai6, ai7,
   ao0, ao1, ao2, ao3, ao4, ao5, ao6, ao7);

   input ai0, ai1, ai2, ai3, ai4, ai5, ai6, ai7;
   output ao0, ao1, ao2, ao3, ao4, ao5, ao6, ao7;
   DTINV u0 (.I(ai0),  .ZN(ao0));
   DTINV u1 (.I(ai1),  .ZN(ao1));
   DTINV u2 (.I(ai2),  .ZN(ao2));
   DTINV u3 (.I(ai3),  .ZN(ao3));
   DTINV u4 (.I(ai4),  .ZN(ao4));
   INTOBUF u5 (.I(ai5), .Z(ao5)); // built in isolation
   INTOBUF u6 (.I(ai6), .Z(ao6)); // built in isolation
   DTINV u7 (.I(ai7),  .ZN(ao7));
endmodule
