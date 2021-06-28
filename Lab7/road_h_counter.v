`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2020 02:26:57 AM
// Design Name: 
// Module Name: road_h_counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module road_h_counter(
    input clk,
    input L,
    input R,
    input reset,
    input rollover,
    input [15:0]INIT_H_POS,
    input [15:0]RESET_H_POS,
    output [15:0]road_h_address
    );
    
    //declare wires to store 16-bit counter inputs/outputs
    wire UTC,DTC; 
    wire [15:0]ld_bus;
    
    wire [15:0]shift_l;
    wire [15:0]shift_r;
    
    //call mux to deterine proper load value
    m2_1x16 ld_mux(
        .in0(INIT_H_POS),
         .in1(RESET_H_POS),
         .sel(rollover),
         .o(ld_bus)
     );
    
    assign shift_r = ld_bus>>1;
    
    //call instance of 16-bit counter
    UDL16_count road_h(
        .up(R),
        .dw(L),
        .ld(reset|rollover),
        .D(shift_r),
        .clk(clk),
        .UTC(UTC),
        .DTC(DTC),
        .Q(shift_l)
     );

    //assign output with shifted bits to left
    assign road_h_address = shift_l<<1;
    
endmodule
