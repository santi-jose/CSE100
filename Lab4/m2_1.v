`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/22/2020 10:51:52 PM
// Design Name: 
// Module Name: m2_1
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


module m2_1(
    input [1:0] in,
    input sel,
    output o
    );
    
    //assign output to 2-to-1 mux
    assign o = (in[0]&~sel)|(in[1]&sel);
    
endmodule

