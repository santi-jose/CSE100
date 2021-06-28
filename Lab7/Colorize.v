`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2020 10:57:14 PM
// Design Name: 
// Module Name: Colorize
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


module Colorize(
    input ActiveRegion,
    input car,
    input [6:0]road,
    output [3:0]vgaRed,
    output [3:0]vgaBlue,
    output [3:0]vgaGreen
    );
    
    //assign value of vga colors
//    assign vgaRed = {4{(car)&ActiveRegion}};
//    assign vgaBlue = {4{(((car)|(|road))&ActiveRegion)}};
//    assign vgaGreen = {4{(car)&(ActiveRegion)}};
    
    //new color assignations
    assign vgaRed[0] = ((|road[2:0])|car)&ActiveRegion;
    assign vgaRed[1] = ((|road[2:0]|road[5])|car)&ActiveRegion;
    assign vgaRed[2] = ((|road[2:0])|car)&ActiveRegion;
    assign vgaRed[3] = ((|road[2:0]|road[6])|car)&ActiveRegion;
    
    assign vgaGreen[0]=((|road[3:1])|car)&ActiveRegion;
    assign vgaGreen[1] = ((|road[3:1]|road[5])|car)&ActiveRegion;
    assign vgaGreen[2] = ((|road[3:1])|car)&ActiveRegion;
    assign vgaGreen[3] = ((|road[3:2])|car)&ActiveRegion;
    
    assign vgaBlue[0] = ((|road[6:4])|car)&ActiveRegion;
    assign vgaBlue[1] = ((road[6]|road[4])|car)&ActiveRegion;
    assign vgaBlue[2] = ((|road[6:4])|car)&ActiveRegion;
    assign vgaBlue[3] = ((road[6]|road[4])|car)&ActiveRegion;
    
    
endmodule
