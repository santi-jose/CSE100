`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2020 06:54:12 PM
// Design Name: 
// Module Name: V_counter
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


module V_counter(
    input clk,
    input ce,
    output vsync,
    output [15:0] V_address
    );
    
    //declare wires for 16-bit ocunter
    wire rollover, UTC, DTC;
    wire [15:0] v_MAX;
    
    //set wire to define max vertical pixel address
    assign v_MAX = 16'd524;
    
    //call instance of 16-bit counter
    UDL16_count V_count(.D(16'd0),.up(ce),.dw(1'b0),.ld(rollover),.clk(clk),.Q(V_address),.UTC(UTC),.DTC(DTC));
    
    //set wire to define when we want to roll over back to 0
    assign rollover = (v_MAX==V_address)&ce;
    
    //define VSync range
    assign vsync = ~((16'd489<=V_address)&(V_address<=16'd490));
    
endmodule
