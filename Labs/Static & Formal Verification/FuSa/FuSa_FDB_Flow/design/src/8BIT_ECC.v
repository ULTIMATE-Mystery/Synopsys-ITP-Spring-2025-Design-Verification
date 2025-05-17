/*******************************************************************************
* (c) 2016 Synopsys, Inc.
*
* This file and it's contents are proprietary to Synopsys, Inc. and may
* only be used pursuant to the terms and conditions of a written license
* agreement with Synopsys, Inc. All other use, reproduction, modification,
* or distribution of this file is stricly prohibited.
*******************************************************************************/

`timescale 1ns/1ns

module ECC_8BIT_ENC (
    input  [7:0] DataIn,
    output [11:0] DataEnc
  );

  // Encoding will be:
  // Assume data index start at 1 instead of 0:
  // d8,d7,d6,d5,d4,d3,d2,d1
  // e12(d8),e11(d7),e10(d6),e9(d5),e8(ECC),e7(d4),e6(d3)
  //        ,e5(d2),e4(ECC),e3(d1),e2(ECC),e1(ECC)
  // e1 = e3^e5^e7^e9^e11  = d1^d2^d4^d5^d7
  // e2 = e3^e6^e7^e10^e11 = d1^d3^d4^d6^d7
  // e4 = e5^e6^e7^e12     = d2^d3^d4^d8
  // e8 = e9^e10^e11^e12   = d5^d6^d7^d8

  //e1: remember index should be -1 from above numbers in comments
  assign DataEnc[0] = DataIn[0]^DataIn[1]^DataIn[3]^DataIn[4]^DataIn[6];
  //e2
  assign DataEnc[1] = DataIn[0]^DataIn[2]^DataIn[3]^DataIn[5]^DataIn[6];
  //e3
  assign DataEnc[2] = DataIn[0];
  //e4
  assign DataEnc[3] = DataIn[1]^DataIn[2]^DataIn[3]^DataIn[7];
  //e5
  assign DataEnc[4] = DataIn[1];
  //e6
  assign DataEnc[5] = DataIn[2];
  //e7
  assign DataEnc[6] = DataIn[3];
  //e8
  assign DataEnc[7] = DataIn[4]^DataIn[5]^DataIn[6]^DataIn[7];
  //e9
  assign DataEnc[8] = DataIn[4];
  //e10
  assign DataEnc[9] = DataIn[5];
  //e11
  assign DataEnc[10] = DataIn[6];
  //e12
  assign DataEnc[11] = DataIn[7];

endmodule


module ECC_8BIT_DEC (
    input  [11:0] DataOutEnc,
    output [7:0] DataOut,
    output EccError
  );

  wire [7:0] DataOut_tmp;
  wire [3:0] synd;
  wire [3:0] ErrIdx;
  // Encoding will be:
  // Assume data index start at 1 instead of 0:
  // d8,d7,d6,d5,d4,d3,d2,d1
  // e12(d8),e11(d7),e10(d6),e9(d5),e8(ECC),e7(d4),e6(d3)
  //        ,e5(d2),e4(ECC),e3(d1),e2(ECC),e1(ECC)
  // e1 = e3^e5^e7^e9^e11  = d1^d2^d4^d5^d7
  // e2 = e3^e6^e7^e10^e11 = d1^d3^d4^d6^d7
  // e4 = e5^e6^e7^e12     = d2^d3^d4^d8
  // e8 = e9^e10^e11^e12   = d5^d6^d7^d8

  //e3
  assign DataOut_tmp[0] = DataOutEnc[2];
  //e5
  assign DataOut_tmp[1] = DataOutEnc[4];
  //e6
  assign DataOut_tmp[2] = DataOutEnc[5];
  //e7
  assign DataOut_tmp[3] = DataOutEnc[6];
  //e9
  assign DataOut_tmp[4] = DataOutEnc[8];
  //e10
  assign DataOut_tmp[5] = DataOutEnc[9];
  //e11
  assign DataOut_tmp[6] = DataOutEnc[10];
  //e12
  assign DataOut_tmp[7] = DataOutEnc[11];

  // Recalculate Syndrome:
  //e1
  assign synd[0] = DataOut_tmp[0]^DataOut_tmp[1]^DataOut_tmp[3]^DataOut_tmp[4]^DataOut_tmp[6];
  //e2
  assign synd[1] = DataOut_tmp[0]^DataOut_tmp[2]^DataOut_tmp[3]^DataOut_tmp[5]^DataOut_tmp[6];
  //e4
  assign synd[2] = DataOut_tmp[1]^DataOut_tmp[2]^DataOut_tmp[3]^DataOut_tmp[7];
  //e8
  assign synd[3] = DataOut_tmp[4]^DataOut_tmp[5]^DataOut_tmp[6]^DataOut_tmp[7];

  assign ErrIdx = synd ^ {DataOutEnc[7],DataOutEnc[3],DataOutEnc[1],DataOutEnc[0]};

  always @(posedge EccError)
  begin
    #1;
    if (EccError) begin
      // Correct the error.  ErrIdx should be the data that needs to be
      // flipped. Remember, ErrIdx refers to e1-e12, so needs to be
      // subtracted by 1
      $display("ECC error detected at Data Index %d",ErrIdx-1);
    end
  end

  assign #1 EccError = (ErrIdx) ? 1'b1 : 1'b0;

  assign #1 DataOut[0] = (ErrIdx == 4'd3) ? ~DataOut_tmp[0] : DataOut_tmp[0];
  assign #1 DataOut[1] = (ErrIdx == 4'd5) ? ~DataOut_tmp[1] : DataOut_tmp[1];
  assign #1 DataOut[2] = (ErrIdx == 4'd6) ? ~DataOut_tmp[2] : DataOut_tmp[2];
  assign #1 DataOut[3] = (ErrIdx == 4'd7) ? ~DataOut_tmp[3] : DataOut_tmp[3];
  assign #1 DataOut[4] = (ErrIdx == 4'd9) ? ~DataOut_tmp[4] : DataOut_tmp[4];
  assign #1 DataOut[5] = (ErrIdx == 4'd10) ? ~DataOut_tmp[5] : DataOut_tmp[5];
  assign #1 DataOut[6] = (ErrIdx == 4'd11) ? ~DataOut_tmp[6] : DataOut_tmp[6];
  assign #1 DataOut[7] = (ErrIdx == 4'd12) ? ~DataOut_tmp[7] : DataOut_tmp[7];
endmodule
