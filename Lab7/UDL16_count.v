`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/06/2020 10:09:13 AM
// Design Name: 
// Module Name: UDL16_count
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


module UDL16_count(
    input [15:0] D,
    input up,
    input dw,
    input ld,
    input clk,
    output [15:0] Q,
    output UTC,
    output DTC
    );
    
    //wire to store UTC's & DTC's
    wire [3:0] UTC_bus;
    wire [3:0] DTC_bus;
    //declare wires to stoer MSB logic
    wire [3:0] up_w;
    wire [3:0] dw_w;
    
    //assign logic to up & dw wires
    assign up_w[0] = ~dw&up;
    assign up_w[1] = ~dw&up&UTC_bus[0];
    assign up_w[2] = ~dw&up&UTC_bus[0]&UTC_bus[1];
    assign up_w[3] = ~dw&up&UTC_bus[0]&UTC_bus[1]&UTC_bus[2]; 
    
    assign dw_w[0] = ~up&dw;
    assign dw_w[1] = ~up&dw&DTC_bus[0];
    assign dw_w[2] = ~up&dw&DTC_bus[0]&DTC_bus[1];
    assign dw_w[3] = ~up&dw&DTC_bus[0]&DTC_bus[1]&DTC_bus[2];
    
    //instantiate four 4-bit counter
    UDL4_count count4_0(.D(D[3:0]),.up(up_w[0]),.dw(dw_w[0]),.ld(ld),.clk(clk),.Q(Q[3:0]),.UTC(UTC_bus[0]),.DTC(DTC_bus[0]));
    UDL4_count count4_1(.D(D[7:4]),.up(up_w[1]),.dw(dw_w[1]),.ld(ld),.clk(clk),.Q(Q[7:4]),.UTC(UTC_bus[1]),.DTC(DTC_bus[1]));
    UDL4_count count4_2(.D(D[11:8]),.up(up_w[2]),.dw(dw_w[2]),.ld(ld),.clk(clk),.Q(Q[11:8]),.UTC(UTC_bus[2]),.DTC(DTC_bus[2]));
    UDL4_count count4_3(.D(D[15:12]),.up(up_w[3]),.dw(dw_w[3]),.ld(ld),.clk(clk),.Q(Q[15:12]),.UTC(UTC_bus[3]),.DTC(DTC_bus[3]));
    
    //assign UTC and DTC values
    assign UTC = &UTC_bus;
    assign DTC = &DTC_bus;
    
endmodule
