`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/23/2020 10:36:22 AM
// Design Name: 
// Module Name: adder_8bit
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


module adder_8bit(
    input [7:0] a,
    input [7:0] b,
    input c_in,
    output [7:0] s
    );
    //declare wires for intermediate and final adder carries
    wire [7:0] c_w;
    
    //call instances of full-adder
    Full_Adder sum_0(.a(a[0]),.b(b[0]),.c_in(c_in),.c_out(c_w[0]),.s(s[0]));
    Full_Adder sum_1(.a(a[1]),.b(b[1]),.c_in(c_w[0]),.c_out(c_w[1]),.s(s[1]));
    Full_Adder sum_2(.a(a[2]),.b(b[2]),.c_in(c_w[1]),.c_out(c_w[2]),.s(s[2]));
    Full_Adder sum_3(.a(a[3]),.b(b[3]),.c_in(c_w[2]),.c_out(c_w[3]),.s(s[3]));
    Full_Adder sum_4(.a(a[4]),.b(b[4]),.c_in(c_w[3]),.c_out(c_w[4]),.s(s[4]));
    Full_Adder sum_5(.a(a[5]),.b(b[5]),.c_in(c_w[4]),.c_out(c_w[5]),.s(s[5]));
    Full_Adder sum_6(.a(a[6]),.b(b[6]),.c_in(c_w[5]),.c_out(c_w[6]),.s(s[6]));
    Full_Adder sum_7(.a(a[7]),.b(b[7]),.c_in(c_w[6]),.c_out(c_w[7]),.s(s[7]));
    
endmodule
