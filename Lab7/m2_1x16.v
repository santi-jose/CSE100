`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2020 03:13:19 AM
// Design Name: 
// Module Name: m2_1x16
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


module m2_1x16(
    input [15:0] in0,
    input [15:0] in1,
    input sel,
    output [15:0] o
    );
    
    //wires to hold not sel and true select extendd to eight bits
    wire [15:0] not_sel;
    wire [15:0] true_sel;
    
    //assign wire values
    assign not_sel = {16{~sel}};
    assign true_sel = {16{sel}};
    
    //assign output vector
    assign o = (not_sel&in0)|(true_sel&in1);
    
endmodule
