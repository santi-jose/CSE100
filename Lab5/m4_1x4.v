`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/14/2020 08:42:04 AM
// Design Name: 
// Module Name: m4_1x4
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


module m4_1x4(
    input [3:0] in0,
    input [3:0] in1,
    input [3:0] in2,
    input [3:0] in3,
    input [1:0] sel,
    output [3:0]o
    );
    
    //wires to hold not sel and true select extendd to 4-bits for both select bits 1 and 0
    wire [3:0] not_sel_0;
    wire [3:0] true_sel_0;
    wire [3:0] not_sel_1;
    wire [3:0] true_sel_1;
    
    //assign wire values
    assign not_sel_0 = {4{~sel[0]}};
    assign true_sel_0 = {4{sel[0]}};
    assign not_sel_1 = {4{~sel[1]}};
    assign true_sel_1 = {4{sel[1]}};
    
    //assign output vector
    assign o = (not_sel_1&not_sel_0&in0)|(not_sel_1&true_sel_0&in1)|(true_sel_1&not_sel_0&in2)|(true_sel_1&true_sel_0&in3);
    
endmodule
