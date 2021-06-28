`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/22/2020 11:06:37 PM
// Design Name: 
// Module Name: m2_1x8
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


module m2_1x4(
    input [3:0] in0,
    input [3:0] in1,
    input sel,
    output [3:0] o
    );
    
    //wires to hold not sel and true select extendd to eight bits
    wire [3:0] not_sel;
    wire [3:0] true_sel;
    
    //assign wire values
    assign not_sel = {4{~sel}};
    assign true_sel = {4{sel}};
    
    //assign output vector
    assign o = (not_sel&in0)|(true_sel&in1);
    
endmodule
