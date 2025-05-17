/*********************************************************************
 * SYNOPSYS CONFIDENTIAL                                             *
 *                                                                   *
 * This is an unpublished, proprietary work of Synopsys, Inc., and   *
 * is fully protected under copyright and trade secret laws. You may *
 * not view, use, disclose, copy, or distribute this file or any     *
 * information contained herein except pursuant to a valid written   *
 * license from Synopsys.                                            *
 *********************************************************************/

module wrapper
  (
   input logic go,
   input logic clk,
   input logic rst,
   input logic [7:0] op1,
   input logic [7:0] op2
   );
   
   logic [15:0] product1, product2;
   logic        valid1, valid2;

   logic        check_valid, check_product;

   assign check_valid = valid1 == valid2;
   assign check_product = product1 == product2;
   
   mul sp(.valid(valid1), .product(product1), .*);
   mul_cg im(.valid(valid2), .product(product2), .*);

   chk_valid: assert property (@(posedge clk) check_valid == 1'b1);
   chk_prod:  assert property (@(posedge clk) check_product == 1'b1);
   
endmodule // wrapper
