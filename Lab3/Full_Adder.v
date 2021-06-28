`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/22/2020 11:08:55 PM
// Design Name: 
// Module Name: Full_Adder
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


module Full_Adder(
    input a,
    input b,
    input c_in,
    output c_out,
    output s
    );
    
    //declare sel bus for sel input
    wire [1:0] sel;
    
    //assign sel
    assign sel = {a,b};
    
    //declare input busses to muxes
    wire [3:0] c_mux_in;
    wire [3:0] s_mux_in;
    
    //assign values to input busses
    assign c_mux_in = {1'b1,c_in,c_in,1'b0};
    assign s_mux_in = {c_in,~c_in,~c_in,c_in};
    
    //call instances of muxes for c_out and s outputs
    m4_1 c_mux(.in(c_mux_in),.sel(sel),.o(c_out));
    m4_1 s_mux(.in(s_mux_in),.sel(sel),.o(s));
    
endmodule
