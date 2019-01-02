`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:11:34 09/23/2016 
// Design Name: 
// Module Name:    mc6809e 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module mc6809_cen(
    input   clk,
    (* direct_enable *) input   clk_en,
    input   [7:0] D,
    output  [7:0] DOut,
    output  [15:0] ADDR,
    output  RnW,
    output  BS,
    output  BA,
    input   nIRQ,
    input   nFIRQ,
    input   nNMI,
    input   nHALT,   
    input   nRESET,
    input   MRDY,
    input   nDMABREQ,
    output reg VMA
);

wire   LIC;
wire   BUSY, AVMA;

reg cen_Q, cen_E;

always @(posedge clk) if(cen_E)
    VMA <= AVMA;

mc6809i cpucore(
    .clk      ( clk      ),
    .D        ( D        ), 
    .DOut     ( DOut     ), 
    .ADDR     ( ADDR     ), 
    .RnW      ( RnW      ), 
    .cen_E    ( cen_E    ), 
    .cen_Q    ( cen_Q    ), 
    .BS       ( BS       ), 
    .BA       ( BA       ), 
    .nIRQ     ( nIRQ     ), 
    .nFIRQ    ( nFIRQ    ), 
    .nNMI     ( nNMI     ), 
    .AVMA     ( AVMA     ), 
    .BUSY     ( BUSY     ), 
    .LIC      ( LIC      ), 
    .nHALT    ( nHALT    ), 
    .nRESET   ( nRESET   ), 
    .nDMABREQ ( nDMABREQ ),
    .RegData  (          )
);

always @(negedge clk) begin
    cen_E <= MRDY & cen_Q;
    cen_Q <= MRDY & clk_en;
end

endmodule
