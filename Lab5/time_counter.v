`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/14/2020 03:21:51 PM
// Design Name: 
// Module Name: time_counter
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


module time_counter(
    input clk,
    input count,
    input reset,
    output [15:0] time_bits,
    output sec_2,
    output sec_4
    );
    
    //declare wires to hold TC's
    wire UTC, DTC;
    
    //call insatance of 16 bit counter
    UDL16_count time_counter(.D({16{1'b0}}),.up(count),.dw(1'b0),.ld(reset),.clk(clk),.Q(time_bits),.UTC(UTC),.DTC(DTC));

    //assign secs
    assign sec_2  = time_bits[4];
    assign sec_4 = time_bits[5];
    
    
    
endmodule
