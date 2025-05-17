/*******************************************************************************
* (c) 2016 Synopsys, Inc.
*
* This file and it's contents are proprietary to Synopsys, Inc. and may
* only be used pursuant to the terms and conditions of a written license
* agreement with Synopsys, Inc. All other use, reproduction, modification,
* or distribution of this file is stricly prohibited.
*******************************************************************************/

`timescale 1ns/1ns

module FIFO #( parameter FIFO_DEPTH = 4, parameter DATA_WIDTH = 8 )
  (  
    input                   Reset_,
    input                   WriteEn,
    input                   WriteClk,
    input  [DATA_WIDTH-1:0] DataIn,
    input                   ReadEn,
    input                   ReadClk,
    output [DATA_WIDTH-1:0] DataOut,
    output                  Empty_,
    output                  HalfFull_,
    output                  Full_,
    output                  Error
  ); 

  parameter ADDR_WIDTH = $clog2(FIFO_DEPTH);

  wire [ADDR_WIDTH-1:0] ReadPtr;
  wire [ADDR_WIDTH-1:0] WritePtr;

  assign DoRead = ReadEn & Empty_;
  assign DoWrite = WriteEn & Full_;

  assign IClock = ReadClk | WriteClk;

  FLAGS #(.ADDR_WIDTH(ADDR_WIDTH)) FL ( Reset_, IClock, DoRead, DoWrite, Empty_, HalfFull_, Full_ );

  COUNTER #(.ADDR_WIDTH(ADDR_WIDTH)) RP( Reset_, DoRead, ReadClk, ReadPtr );
  COUNTER #(.ADDR_WIDTH(ADDR_WIDTH)) WP( Reset_, DoWrite, WriteClk, WritePtr );

  SDPRAM #( .ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH)) sdpram_i1
  ( 
    // Left port
    .L_Clock(WriteClk)                ,
    .L_Address(WritePtr)              , // address bus
    .L_DataIn(DataIn)                 , // data input bus
    .L_DataOut()                      , // data output bus
    .L_ReadEn(1'b0)                   , // Active high read  enable
    .L_WriteEn(DoWrite)               , // Active high write enable
    // Right port
    .R_Clock(ReadClk)                 , // Clock
    .R_Address(ReadPtr)               , // address bus
    .R_DataIn({DATA_WIDTH {1'b0}})    , // data input bus
    .R_DataOut(DataOut)               , // data output bus
    .R_ReadEn(DoRead)                 , // Active high read  enable
    .R_WriteEn(1'b0)                  // Active high write enable
  ) ;

endmodule

module FLAGS ( Reset_, Clock, Read, Write, Empty_, HalfFull_, Full_ );

  parameter ADDR_WIDTH = 4;

  input   Reset_;
  input   Clock;
  input   Read;
  input   Write;
  output  Empty_;
  output  HalfFull_;
  output  Full_;

  reg [ADDR_WIDTH:0] Count;

  assign Empty_ = |Count;
  assign HalfFull_ = ~(Count[ADDR_WIDTH] | Count[ADDR_WIDTH-1]);
  assign Full_ = ~Count[ADDR_WIDTH];

  always @(posedge Clock or negedge Reset_)
    if (!Reset_)
      Count <= {ADDR_WIDTH {1'b0}};
    else
      if (Read & ~Write)
        Count <= Count - 1'b1;
      else if (~Read & Write)
        Count <= Count + 1'b1;

endmodule

module COUNTER ( Reset_, Enable, Clock, Count );

  parameter ADDR_WIDTH = 4;

  input                       Reset_;
  input                       Enable;
  input                       Clock;
  output reg [ADDR_WIDTH-1:0] Count;

  always @(posedge Clock or negedge Reset_)
    if (!Reset_)
      Count <= {ADDR_WIDTH {1'b0}};
    else if (Enable)
      Count <= Count + 1'b1;

endmodule
