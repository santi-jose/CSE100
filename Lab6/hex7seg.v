`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/23/2020 10:49:12 AM
// Design Name: 
// Module Name: hex7seg
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


module hex7seg(
    input [3:0] n,
    output [6:0] seg
    );
    
    //declare wire to hold mux inputs
    wire [7:0] seg0_in;
    wire [7:0] seg1_in;
    wire [7:0] seg2_in;
    wire [7:0] seg3_in;
    wire [7:0] seg4_in;
    wire [7:0] seg5_in; 
    wire [7:0] seg6_in;
    
    //assign values to input busses
    assign seg0_in = ~{1'b1,~n[0],~n[0],1'b1,1'b1,n[0],1'b1,~n[0]};
    assign seg1_in = ~{1'b0,n[0],~n[0],1'b1,n[0],~n[0],1'b1,1'b1};
    assign seg2_in = ~{1'b0,n[0],1'b1,1'b1,1'b1,1'b1,n[0],1'b1};
    assign seg3_in = ~{~n[0],1'b1,n[0],~n[0],~n[0],n[0],1'b1,~n[0]};
    assign seg4_in = ~{1'b1,1'b1,1'b1,~n[0],~n[0],1'b0,~n[0],~n[0]};
    assign seg5_in = ~{1'b1,~n[0],1'b1,1'b1,~n[0],1'b1,1'b0,~n[0]};
    assign seg6_in = ~{1'b1,n[0],1'b1,1'b1,~n[0],1'b1,1'b1,1'b0};
    
    //call seven muxes to output correct signal for seg[6:0]
    m8_1 seg0_mux (.in(seg0_in),.sel(n[3:1]),.o(seg[0]));
    m8_1 seg1_mux (.in(seg1_in),.sel(n[3:1]),.o(seg[1]));
    m8_1 seg2_mux (.in(seg2_in),.sel(n[3:1]),.o(seg[2]));
    m8_1 seg3_mux (.in(seg3_in),.sel(n[3:1]),.o(seg[3]));
    m8_1 seg4_mux (.in(seg4_in),.sel(n[3:1]),.o(seg[4]));
    m8_1 seg5_mux (.in(seg5_in),.sel(n[3:1]),.o(seg[5]));
    m8_1 seg6_mux (.in(seg6_in),.sel(n[3:1]),.o(seg[6]));
    
    
endmodule
