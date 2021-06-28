`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2020 06:50:07 PM
// Design Name: 
// Module Name: VGAcontroller
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


module VGAcontroller(
    input clk,
    output hsync,
    output vsync,
    output [15:0]H_address,
    output [15:0]V_address
    );
    
    //declare wire to hold V_count output of H_counter
    wire V_count;
    
    //call instance of horizontal and vertical address counters
    H_counter H_pixel_address(.clk(clk),.ce(1'b1),.hsync(hsync),.H_address(H_address),.V_count(V_count));
    V_counter V_pixel_address(.clk(clk),.ce(V_count),.vsync(vsync),.V_address(V_address));
  
    
endmodule
