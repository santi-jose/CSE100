`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/22/2020 10:43:33 PM
// Design Name: 
// Module Name: m4_1
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


module m4_1(
    input [3:0] in,
    input [1:0] sel,
    output o
    );
    
    //declare wires for sum terms within mux design
    wire [3:0] sum_term;
    
    //assign product term as a sum term
    assign sum_term[3] = in[3]&sel[1]&sel[0];
    assign sum_term[2] = in[2]&sel[1]&~sel[0];
    assign sum_term[1] = in[1]&~sel[1]&sel[0];
    assign sum_term[0] = in[0]&~sel[1]&~sel[0];
    
    //assign output as the OR of sum terms
    assign o = sum_term[3]|sum_term[2]|sum_term[1]|sum_term[0];
    
    
endmodule
