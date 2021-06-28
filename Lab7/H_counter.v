`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2020 06:54:12 PM
// Design Name: 
// Module Name: H_counter
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


module H_counter(
    input clk,
    input ce,
    output hsync,
    output [15:0] H_address,
    output V_count
    );
    
    //declare wire to store values for 16-bit counter instance
    wire rollover, UTC, DTC;
    wire [15:0] h_MAX;
    
    //define horizontal max address
    assign h_MAX = 16'd799;
    
    //call instance of 16-bit counter
    UDL16_count H_count(.D(16'd0),.up(ce),.dw(1'b0),.ld(rollover),.clk(clk),.UTC(UTC),.DTC(DTC),.Q(H_address));
    
    //define rollover signal
    assign rollover = (h_MAX==H_address)&ce;
    
    //assign Hsync range
    assign hsync = ~((H_address>=16'd655)&(H_address<=16'd750));
    
    //assign value to tell our vertical address counter to count
    assign V_count = rollover;
    
endmodule
