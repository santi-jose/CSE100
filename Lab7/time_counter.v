`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2020 09:43:54 PM
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
    input ce,
    input r,
    output sec_2,
    output qsec,
    output flash
    );
    
    //declare wires to store 16-bit counter outputs
    wire UTC, DTC;
    wire [15:0]time_bits;
    
    //call instance of 16-bit counter
    UDL16_count count_time(.clk(clk),.up(ce),.dw(1'b0),.ld(r),.D({16{1'b0}}),.UTC(UTC),.DTC(DTC),.Q(time_bits));
    
    //assign output values
    assign sec_2 = time_bits[7];
    assign flash = time_bits[5];
    assign qsec = time_bits[4];
    
endmodule
