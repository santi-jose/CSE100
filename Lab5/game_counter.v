`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/14/2020 02:58:30 PM
// Design Name: 
// Module Name: game_counter
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


module game_counter(
    input clk,
    input count,
    input reset,
    output [7:0]gcount_bits
    );
    //wires to store counter outputs
    wire [15:0] Q;
    wire UTC, DTC;
    
    //call instance of 16bit counter
    UDL16_count game_counter(.D({16{1'b0}}),.up(count),.dw(1'b0),.ld(reset),.clk(clk),.Q(Q),.UTC(UTC),.DTC(DTC));
    
    //assign gcount_bits
    assign gcount_bits = {1'b0,1'b0,Q[5:0]};
    
endmodule
