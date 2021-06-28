`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/16/2020 11:13:05 AM
// Design Name: 
// Module Name: full_adder
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


module full_adder(
    input a,
    input b,
    input c_in,
    output s,
    output c_out
    );
    //assign logic for s
    assign s = a^b^c_in;
    
    //assign logic for c_out
    assign c_out = (a&b)|(b&c_in)|(a&c_in);    
    
endmodule
