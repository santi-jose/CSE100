`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2020 04:51:59 PM
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
        input [7:0]in,
        input [2:0]sel,
        output o
    );
    
    //wires for intermediate mux output
    wire upper_bit;
    wire lower_bit;
     
    
    //call m4_1
    m4_1 upper_mux(.in(in[7:4]),.sel(sel[1:0]),.o(upper_bit));
    m4_1 lower_mux(.in(in[3:0]),.sel(sel[1:0]),.o(lower_bit));
    
    //call m2_1
    m2_1 final_mux(.in({upper_bit,lower_bit}),.sel(sel[2]),.o(o));
    
    
    endmodule