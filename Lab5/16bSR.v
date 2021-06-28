`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/14/2020 03:54:59 PM
// Design Name: 
// Module Name: 16bSR
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


module SR_16b(
    input in,
    input ce,
    input reset,
    input clk,
    output [15:0] Q
    );
    
    //instantiate flip-flops
    FDRE #(.INIT(1'b0)) LED_SR_FF_0 (.C(clk), .CE(ce), .R(reset), .D(in), .Q(Q[0]));
    FDRE #(.INIT(1'b0)) LED_SR_FFs[15:1] (.C({15{clk}}), .CE({15{ce}}), .R({15{reset}}), .D(Q[14:0]), .Q(Q[15:1]));

    
endmodule
