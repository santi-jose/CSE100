`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/22/2020 10:51:03 PM
// Design Name: 
// Module Name: m8_1
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


module m8_1(
    input [7:0] in,
    input [2:0] sel,
    output o
    );
    
    wire [1:0] MSB_input;
    
    //LSB muxes
    m4_1 lower_bits(.in(in[3:0]),.sel(sel[1:0]),.o(MSB_input[0]));
    m4_1 upper_bits(.in(in[7:4]),.sel(sel[1:0]),.o(MSB_input[1]));
    
    //MSB mux
    m2_1 final_bit(.in(MSB_input),.sel(sel[2]),.o(o));
    
    
endmodule
