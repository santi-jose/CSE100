`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2020 03:09:50 PM
// Design Name: 
// Module Name: m8_1x16
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


module m8_1x16(
    input [15:0] in0,
    input [15:0] in1,
    input [15:0] in2,
    input [15:0] in3,
    input [15:0] in4,
    input [15:0] in5,
    input [15:0] in6,
    input [15:0] in7,
    input [2:0] sel,
    output [15:0] o
    );
    
    //wires to hold not sel and true select extendd to eight bits
    wire [15:0] not_sel_0;
    wire [15:0] true_sel_0;
    wire [15:0] not_sel_1;
    wire [15:0] true_sel_1;
    wire [15:0] not_sel_2;
    wire [15:0] true_sel_2;
    
    //assign wire values
    assign not_sel_0 = {16{~sel[0]}};
    assign true_sel_0 = {16{sel[0]}};
    assign not_sel_1 = {16{~sel[1]}};
    assign true_sel_1 = {16{sel[1]}};
    assign not_sel_2 = {16{~sel[2]}};
    assign true_sel_2 = {16{sel[2]}};
    
    //assign output vector
    assign o = (
    (not_sel_0&not_sel_1&not_sel_2&in0)
    |(true_sel_0&not_sel_1&not_sel_2&in1)
    |(not_sel_0&true_sel_1&not_sel_2&in2)
    |(true_sel_0&true_sel_1&not_sel_2&in3)
    |(not_sel_0&not_sel_1&true_sel_2&in4)
    |(true_sel_0&not_sel_1&true_sel_2&in5)
    |(not_sel_0&true_sel_1&true_sel_2&in6)
    |(true_sel_0&true_sel_1&true_sel_2&in7)
    );
    
    
endmodule
