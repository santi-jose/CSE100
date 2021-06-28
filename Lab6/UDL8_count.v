`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2020 01:43:17 AM
// Design Name: 
// Module Name: UDL8_count
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


module UDL8_count(
    input [7:0] D,
    input up,
    input dw,
    input ld,
    input clk,
    output UTC,
    output DTC,
    output [7:0] Q
    );
    
    //declare wires to store DTC and UTC
    wire UTC_0, UTC_1, DTC_0, DTC_1;
    
    //call two instances of UDL4 count
    UDL4_count count_0(.clk(clk),.D(D[3:0]),.up(up),.dw(dw),.ld(ld),.UTC(UTC_0),.DTC(DTC_0),.Q(Q[3:0]));
    UDL4_count count_1(.clk(clk),.D(D[7:4]),.up(up&UTC_0),.dw(dw&DTC_0),.ld(ld),.UTC(UTC_1),.DTC(DTC_1),.Q(Q[7:4]));
    
    //assign outputs
    assign DTC = DTC_0&DTC_1;//zero
    assign UTC = UTC_0&UTC_1;//max value
    
    
endmodule
