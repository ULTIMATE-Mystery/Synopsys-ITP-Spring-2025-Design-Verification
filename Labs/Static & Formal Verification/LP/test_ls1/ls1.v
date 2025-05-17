module top (vdd, vss, vdda, vddb,
   ai0, ai1, bi0, bi1, ci0, di0, ao0, ao1, bo0, bo1, co0, do0, eo1);

   input  vdd, vss, vdda, vddb, ai0, ai1, bi0, bi1, ci0, di0;
   output ao0, ao1, bo0, bo1, co0, do0, eo1;
   wire   aw0, aw1, ax0, ax1, bw0, bw1, bx0, be1, cw0, dw0;

   // A and related shifters
   ma ua (.ai0(aw0), .ai1(aw1), .ao0(ax0), .ao1(ax1));
   LSHL si0  (.I(ai0));           // output unconn
   LSHL si1  (.I(ai1), .Z(aw1));
   LSLH so0  (.I(ax0), .Z(ao0)); // redundant no_shift
   LSLH so1  (.I(ax1), .Z(ao1));

   // B and related shifters
   mb ub (.bi0(bw0), .bi1(bw1), .bo0(bx0), .bo1(be1));
   LSHL ti0  (.I(bi0),  .Z(bw0)); // outrange
   LSHL ti1  (.I(bi1),  .Z(bw1)); // outrange
   LSLH to0  (.I(bx0),  .Z(bo0)); // inrange

   // C and related shifters
   mc uc (.ci0(cw0), .co0(co0));
   LSHL ui0  (.I(ci0),  .Z(cw0)); // no policy

   // D (has policy but not needed)
   md ud (.di0(dw0), .do0(do0));
   LSHL vi0  (.I(di0),  .Z(dw0));

   // E (crossing bo1-ei1 for duplicate policy)
   me ue (.ei1(be1), .eo1(eo1));
endmodule

module ma (ai0, ai1, ao0, ao1);
   input ai0, ai1;
   output ao0, ao1;
   DTINV u0 (.I(ai0),  .ZN(ao0));
   DTINV u1 (.I(ai1),  .ZN(ao1));
endmodule

module mb (bi0, bi1, bo0, bo1);
   input bi0, bi1;
   output bo0, bo1;
   DTINV u0 (.I(bi0), .ZN(bo0));
   DTINV u1 (.I(bi1), .ZN(bo1));
endmodule

module mc (ci0, co0);
   input ci0;
   output co0;
   DTINV u0 (.I(ci0), .ZN(co0));
endmodule

module md (di0, do0);
   input di0;
   output do0;
   DTINV u0 (.I(di0), .ZN(do0));
endmodule

module me (ei1, eo1);
   input ei1;
   output eo1;
   DTINV u0 (.I(ei1), .ZN(eo1));
endmodule
