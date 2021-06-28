`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/06/2020 09:17:59 AM
// Design Name: 
// Module Name: selector
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


module selector(
    input [3:0] sel,
    input [15:0] N,
    output [3:0] H
    );
    //create wires to extend sel values
    wire sel_0 = {4{sel[0]}};
    wire sel_1 = {4{sel[1]}};
    wire sel_2 = {4{sel[2]}};
    wire sel_3 = {4{sel[3]}};
    
    //assign output using logic as a mux would
    //include logic to ensure this module only works when only one sel value is high
    //^sel
//    assign H ={4{(sel[0]^sel[1]^sel[2]^sel[3])}}&{(sel_0&N[3:0])|(sel_1&N[7:4])|(sel_2&N[11:8])|(sel_3&N[15:12])};
    assign H = N[15:12] & {4{sel[3]}} | N[11:8] & {4{sel[2]}}
    | N[7:4] & {4{sel[1]}}| N[3:0] & {4{sel[0]}};
    endmodule
