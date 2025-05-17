/*********************************************************************
 * SYNOPSYS CONFIDENTIAL                                             *
 *                                                                   *
 * This is an unpublished, proprietary work of Synopsys, Inc., and   *
 * is fully protected under copyright and trade secret laws. You may *
 * not view, use, disclose, copy, or distribute this file or any     *
 * information contained herein except pursuant to a valid written   *
 * license from Synopsys.                                            *
 *********************************************************************/

`timescale 1ps/1ps
/* The following is a simple multiplier which computes the product of 2 unsigned 4-bit quantities via
 * a simple lookup (implemented as a case statement).
 */
module mul4x4(a,b, product);
   output [7:0] product;
   
   input [3:0] a;
   input [3:0] b;

   logic [3:0] a;
   logic [3:0] b;
   logic [7:0] product;

   always @(a or b)begin
      case({a,b})
        8'h0: product = 8'h0;
        8'h1: product = 8'h0;
        8'h2: product = 8'h0;
        8'h3: product = 8'h0;
        8'h4: product = 8'h0;
        8'h5: product = 8'h0;
        8'h6: product = 8'h0;
        8'h7: product = 8'h0;
        8'h8: product = 8'h0;
        8'h9: product = 8'h0;
        8'ha: product = 8'h0;
        8'hb: product = 8'h0;
        8'hc: product = 8'h0;
        8'hd: product = 8'h0;
        8'he: product = 8'h0;
        8'hf: product = 8'h0;
        8'h10: product = 8'h0;
        8'h11: product = 8'h1;
        8'h12: product = 8'h2;
        8'h13: product = 8'h3;
        8'h14: product = 8'h4;
        8'h15: product = 8'h5;
        8'h16: product = 8'h6;
        8'h17: product = 8'h7;
        8'h18: product = 8'h8;
        8'h19: product = 8'h9;
        8'h1a: product = 8'ha;
        8'h1b: product = 8'hb;
        8'h1c: product = 8'hc;
        8'h1d: product = 8'hd;
        8'h1e: product = 8'he;
        8'h1f: product = 8'hf;
        8'h20: product = 8'h0;
        8'h21: product = 8'h2;
        8'h22: product = 8'h4;
        8'h23: product = 8'h6;
        8'h24: product = 8'h8;
        8'h25: product = 8'ha;
        8'h26: product = 8'hc;
        8'h27: product = 8'he;
        8'h28: product = 8'h10;
        8'h29: product = 8'h12;
        8'h2a: product = 8'h14;
        8'h2b: product = 8'h16;
        8'h2c: product = 8'h18;
        8'h2d: product = 8'h1a;
        8'h2e: product = 8'h1c;
        8'h2f: product = 8'h1e;
        8'h30: product = 8'h0;
        8'h31: product = 8'h3;
        8'h32: product = 8'h6;
        8'h33: product = 8'h9;
        8'h34: product = 8'hc;
        8'h35: product = 8'hf;
        8'h36: product = 8'h12;
        8'h37: product = 8'h15;
        8'h38: product = 8'h18;
        8'h39: product = 8'h1b;
        8'h3a: product = 8'h1e;
        8'h3b: product = 8'h21;
        8'h3c: product = 8'h24;
        8'h3d: product = 8'h27;
        8'h3e: product = 8'h2a;
        8'h3f: product = 8'h2d;
        8'h40: product = 8'h0;
        8'h41: product = 8'h4;
        8'h42: product = 8'h8;
        8'h43: product = 8'hc;
        8'h44: product = 8'h10;
        8'h45: product = 8'h14;
        8'h46: product = 8'h18;
        8'h47: product = 8'h1c;
        8'h48: product = 8'h20;
        8'h49: product = 8'h24;
        8'h4a: product = 8'h28;
        8'h4b: product = 8'h2c;
        8'h4c: product = 8'h30;
        8'h4d: product = 8'h34;
        8'h4e: product = 8'h38;
        8'h4f: product = 8'h3c;
        8'h50: product = 8'h0;
        8'h51: product = 8'h5;
        8'h52: product = 8'ha;
        8'h53: product = 8'hf;
        8'h54: product = 8'h14;
        8'h55: product = 8'h19;
        8'h56: product = 8'h1e;
        8'h57: product = 8'h23;
        8'h58: product = 8'h28;
        8'h59: product = 8'h2d;
        8'h5a: product = 8'h32;
        8'h5b: product = 8'h37;
        8'h5c: product = 8'h3c;
        8'h5d: product = 8'h41;
        8'h5e: product = 8'h46;
        8'h5f: product = 8'h4b;
        8'h60: product = 8'h0;
        8'h61: product = 8'h6;
        8'h62: product = 8'hc;
        8'h63: product = 8'h12;
        8'h64: product = 8'h18;
        8'h65: product = 8'h1e;
        8'h66: product = 8'h24;
        8'h67: product = 8'h2a;
        8'h68: product = 8'h30;
        8'h69: product = 8'h36;
        8'h6a: product = 8'h3c;
        8'h6b: product = 8'h42;
        8'h6c: product = 8'h48;
        8'h6d: product = 8'h4e;
        8'h6e: product = 8'h54;
        8'h6f: product = 8'h5a;
        8'h70: product = 8'h0;
        8'h71: product = 8'h7;
        8'h72: product = 8'he;
        8'h73: product = 8'h15;
        8'h74: product = 8'h1c;
        8'h75: product = 8'h23;
        8'h76: product = 8'h2a;
        8'h77: product = 8'h31;
        8'h78: product = 8'h38;
        8'h79: product = 8'h3f;
        8'h7a: product = 8'h46;
        8'h7b: product = 8'h4d;
        8'h7c: product = 8'h54;
        8'h7d: product = 8'h5b;
        8'h7e: product = 8'h62;
        8'h7f: product = 8'h69;
        8'h80: product = 8'h0;
        8'h81: product = 8'h8;
        8'h82: product = 8'h10;
        8'h83: product = 8'h18;
        8'h84: product = 8'h20;
        8'h85: product = 8'h28;
        8'h86: product = 8'h30;
        8'h87: product = 8'h38;
        8'h88: product = 8'h40;
        8'h89: product = 8'h48;
        8'h8a: product = 8'h50;
        8'h8b: product = 8'h58;
        8'h8c: product = 8'h60;
        8'h8d: product = 8'h68;
        8'h8e: product = 8'h70;
        8'h8f: product = 8'h78;
        8'h90: product = 8'h0;
        8'h91: product = 8'h9;
        8'h92: product = 8'h12;
        8'h93: product = 8'h1b;
        8'h94: product = 8'h24;
        8'h95: product = 8'h2d;
        8'h96: product = 8'h36;
        8'h97: product = 8'h3f;
        8'h98: product = 8'h48;
        8'h99: product = 8'h51;
        8'h9a: product = 8'h5a;
        8'h9b: product = 8'h63;
        8'h9c: product = 8'h6c;
        8'h9d: product = 8'h75;
        8'h9e: product = 8'h7e;
        8'h9f: product = 8'h87;
        8'ha0: product = 8'h0;
        8'ha1: product = 8'ha;
        8'ha2: product = 8'h14;
        8'ha3: product = 8'h1e;
        8'ha4: product = 8'h28;
        8'ha5: product = 8'h32;
        8'ha6: product = 8'h3c;
        8'ha7: product = 8'h46;
        8'ha8: product = 8'h50;
        8'ha9: product = 8'h5a;
        8'haa: product = 8'h64;
        8'hab: product = 8'h6e;
        8'hac: product = 8'h78;
        8'had: product = 8'h82;
        8'hae: product = 8'h8c;
        8'haf: product = 8'h96;
        8'hb0: product = 8'h0;
        8'hb1: product = 8'hb;
        8'hb2: product = 8'h16;
        8'hb3: product = 8'h21;
        8'hb4: product = 8'h2c;
        8'hb5: product = 8'h37;
        8'hb6: product = 8'h42;
        8'hb7: product = 8'h4d;
        8'hb8: product = 8'h58;
        8'hb9: product = 8'h63;
        8'hba: product = 8'h6e;
        8'hbb: product = 8'h79;
        8'hbc: product = 8'h84;
        8'hbd: product = 8'h8f;
        8'hbe: product = 8'h9a;
        8'hbf: product = 8'ha5;
        8'hc0: product = 8'h0;
        8'hc1: product = 8'hc;
        8'hc2: product = 8'h18;
        8'hc3: product = 8'h24;
        8'hc4: product = 8'h30;
        8'hc5: product = 8'h3c;
        8'hc6: product = 8'h48;
        8'hc7: product = 8'h54;
        8'hc8: product = 8'h60;
        8'hc9: product = 8'h6c;
        8'hca: product = 8'h78;
        8'hcb: product = 8'h84;
        8'hcc: product = 8'h90;
        8'hcd: product = 8'h9c;
        8'hce: product = 8'ha8;
        8'hcf: product = 8'hb4;
        8'hd0: product = 8'h0;
        8'hd1: product = 8'hd;
        8'hd2: product = 8'h1a;
        8'hd3: product = 8'h27;
        8'hd4: product = 8'h34;
        8'hd5: product = 8'h41;
        8'hd6: product = 8'h4e;
        8'hd7: product = 8'h5b;
        8'hd8: product = 8'h68;
        8'hd9: product = 8'h75;
        8'hda: product = 8'h82;
        8'hdb: product = 8'h8f;
        8'hdc: product = 8'h9c;
        8'hdd: product = 8'ha9;
        8'hde: product = 8'hb6;
        8'hdf: product = 8'hc3;
        8'he0: product = 8'h0;
        8'he1: product = 8'he;
        8'he2: product = 8'h1c;
        8'he3: product = 8'h2a;
        8'he4: product = 8'h38;
        8'he5: product = 8'h46;
        8'he6: product = 8'h54;
        8'he7: product = 8'h62;
        8'he8: product = 8'h70;
        8'he9: product = 8'h7e;
        8'hea: product = 8'h8c;
        8'heb: product = 8'h9a;
        8'hec: product = 8'ha8;
        8'hed: product = 8'hb6;
        8'hee: product = 8'hc4;
        8'hef: product = 8'hd2;
        8'hf0: product = 8'h0;
        8'hf1: product = 8'hf;
        8'hf2: product = 8'h1e;
        8'hf3: product = 8'h2d;
        8'hf4: product = 8'h3c;
        8'hf5: product = 8'h4b;
        8'hf6: product = 8'h5a;
        8'hf7: product = 8'h69;
        8'hf8: product = 8'h78;
        8'hf9: product = 8'h87;
        8'hfa: product = 8'h96;
        8'hfb: product = 8'ha5;
        8'hfc: product = 8'hb4;
        8'hfd: product = 8'hc3;
        8'hfe: product = 8'hd2;
        8'hff: product = 8'he1;
      endcase // case ({a,b})
   end
endmodule // mul4x4

/* The mul module below takes in 2, unsigned 8-bit quantities and computes 4 partial products by taking
 * 4 bits from the multiplier and multiplicand.These partial products are them summed up in a a 4-stage
 * pipeline two at a time to produce the final result. A "1" on the "go" input starts the multiplication
 * and the output is valid when the "valid" output is asserted.
 */

module mul(clk, rst, op1, op2, go, product, valid);
   output [15:0] product;
   output        valid;
   
   input [7:0]   op1,op2;
   input         go, clk, rst;

   logic [15:0]  product;
   logic [7:0]   op1, op2;
   logic         valid, go, clk, rst;

   logic [16:0]  stage1;
   logic [32:0]  stage2;
   logic [32:0]  stage3;
   logic [24:0]  stage4;

   logic [7:0]   hh, hl, lh, ll;

   mul4x4 mll(stage1[3:0], stage1[11:8], ll);
   mul4x4 mlh(stage1[3:0], stage1[15:12], lh);
   mul4x4 mhl(stage1[7:4], stage1[11:8], hl);
   mul4x4 mhh(stage1[7:4], stage1[15:12], hh);

   always @(posedge clk or negedge rst)begin
      if(!rst)begin
         product <= 16'b0;
         valid <= 1'b0;
         stage1 <= 17'b0;
         stage2 <= 33'b0;
         stage3 <= 33'b0;
         stage4 <= 25'b0;
      end else begin
         stage1 <= {go, op1, op2};
         stage2 <= {stage1[16], hh, hl, lh, ll};
         stage3 <= {stage2[32], { {stage2[31:24],8'b0} + {4'b0, stage2[23:16], 4'b0} }, stage2[15:0]};
         stage4 <= {stage3[32], { stage3[31:16] + { 4'b0, stage3[15:8], 4'b0 }}, stage3[7:0] };
         if(stage4[24] === 1'b1)
           product <= stage4[23:8] + stage4[7:0];
         else
           product <= product;
         valid <= stage4[24];
      end
   end // always @ (posedge clk or rst)
endmodule // mul
