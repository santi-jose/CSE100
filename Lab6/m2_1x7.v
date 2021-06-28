`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2020 02:44:08 PM
// Design Name: 
// Module Name: m2_1x7
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


module m2_1x7(
    input [6:0] in0,
    input [6:0] in1,
    input sel,
    output [6:0] o
    );
    
    //wires to hold not sel and true select extendd to eight bits
    wire [6:0] not_sel;
    wire [6:0] true_sel;
    
    //assign wire values
    assign not_sel = {7{~sel}};
    assign true_sel = {7{sel}};
    
    //assign output vector
    assign o = (not_sel&in0)|(true_sel&in1);
    
endmodule
