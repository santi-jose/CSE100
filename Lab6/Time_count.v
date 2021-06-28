`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2020 01:54:27 AM
// Design Name: 
// Module Name: Time_count
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


module Time_count(
    input clk,
    input qsec,
    input R,
    output [3:0]time_bits
    );
    //declare wire to store 8-bit adder outputs
    wire [7:0]Q;
    wire UTC,DTC, time_TC;
    
    //assign time_TC value
    assign time_TC = &Q[5:0];
    
    //call instance of 8-bit counter
    UDL8_count count_time(.clk(clk),.D({8{1'b0}}),.up(qsec&(~time_TC)),.dw(1'b0),.ld(R),.UTC(UTC),.DTC(DTC),.Q(Q));
    
    //assign time bits
    assign time_bits = {Q[5:2]};
    
endmodule
