/*******************************************************************************
* (c) 2016 Synopsys, Inc.
*
* This file and it's contents are proprietary to Synopsys, Inc. and may
* only be used pursuant to the terms and conditions of a written license
* agreement with Synopsys, Inc. All other use, reproduction, modification,
* or distribution of this file is stricly prohibited.
*******************************************************************************/

`timescale 1ns/1ns

module SDPRAM_TOP #( parameter ADDR_WIDTH = 4, parameter DATA_WIDTH = 8 )
  (
    input                       L_Clock     , // clock
    input      [ADDR_WIDTH-1:0] L_Address   , // address bus
    input      [DATA_WIDTH-1:0] L_DataIn    , // data input bus
    output reg [DATA_WIDTH-1:0] L_DataOut   , // data output bus
    input                       L_ReadEn    , // Active high read  enable
    input                       L_WriteEn   , // Active high write enable
    input                       R_Clock     , // clock
    input      [ADDR_WIDTH-1:0] R_Address   , // address bus
    input      [DATA_WIDTH-1:0] R_DataIn    , // data input bus
    output reg [DATA_WIDTH-1:0] R_DataOut   , // data output bus
    input                       R_ReadEn    , // Active high read  enable
    input                       R_WriteEn   , // Active high write enable
    output                      EccError      // Active high
  ); 

  wire [DATA_WIDTH+4-1:0] DataInEnc;
  wire [DATA_WIDTH+4-1:0] DataOutEnc;

  ECC_8BIT_ENC ECC_Enc (
    .DataIn(L_DataIn)                 , // data input bus
    .DataEnc(DataInEnc)               // ECC data protected input bus
  );

  ECC_8BIT_DEC ECC_Dec (
    .DataOutEnc(DataOutEnc)         , // ECC data protected output bus
    .DataOut(R_DataOut)               , // Decoded data output bus
    .EccError(EccError)               // Error Signal
  );

  SDPRAM #( .ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH+4)) sdpram_i1
  ( 
    // Left port
    .L_Clock(L_Clock)                 ,
    .L_Address(L_Address)             , // address bus
    .L_DataIn(DataInEnc)              , // data input bus
    .L_DataOut()                      , // data output bus
    .L_ReadEn(1'b0)                   , // Active high read  enable
    .L_WriteEn(L_WriteEn)             , // Active high write enable
    // Right port
    .R_Clock(R_Clock)                 , // Clock
    .R_Address(R_Address)             , // address bus
    .R_DataIn({DATA_WIDTH+4 {1'b0}})    , // data input bus
    .R_DataOut(DataOutEnc)            , // data output bus
    .R_ReadEn(R_ReadEn)               , // Active high read  enable
    .R_WriteEn(1'b0)                  // Active high write enable
  ) ;
endmodule


module SDPRAM #( parameter ADDR_WIDTH = 4, parameter DATA_WIDTH = 8 )
  (
    input                       L_Clock     , // clock
    input      [ADDR_WIDTH-1:0] L_Address   , // address bus
    input      [DATA_WIDTH-1:0] L_DataIn    , // data input bus
    output reg [DATA_WIDTH-1:0] L_DataOut   , // data output bus
    input                       L_ReadEn    , // Active high read  enable
    input                       L_WriteEn   , // Active high write enable
    input                       R_Clock     , // clock
    input      [ADDR_WIDTH-1:0] R_Address   , // address bus
    input      [DATA_WIDTH-1:0] R_DataIn    , // data input bus
    output reg [DATA_WIDTH-1:0] R_DataOut   , // data output bus
    input                       R_ReadEn    , // Active high read  enable
    input                       R_WriteEn     // Active high write enable
  ); 

  parameter RAM_DEPTH = 1 << ADDR_WIDTH;
  reg [DATA_WIDTH-1:0] mem_array [RAM_DEPTH-1:0];
   
  always @ (posedge L_Clock)
    begin
      if ( L_WriteEn == 1'b1 )
        mem_array[L_Address] <= L_DataIn;
      if ( L_ReadEn == 1'b1 )
        L_DataOut <= mem_array[L_Address];
    end
   
  always @ (posedge R_Clock)
    begin
      if ( R_WriteEn == 1'b1 )
        mem_array[R_Address] <= R_DataIn;
      if ( R_ReadEn == 1'b1 )
        R_DataOut <= mem_array[R_Address];
    end

endmodule
