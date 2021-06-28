`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/23/2020 11:33:12 AM
// Design Name: 
// Module Name: Lab_3_top
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


module Lab_3_top(
    input [7:0] sw,
    input btnL,
    input btnC,
    input btnR,
    input clkin,
    output [6:0] seg,
    output [3:0] an,
    output dp
    //output digsel
    );
    
    //declare wire to store 2-bit value corresponding to btnL,btnC
    wire [7:0] val_2bit;
    
    //assign value of 2bit 
    assign val_2bit = {1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,btnL,btnC};
    
    //declare wire to hold result of incrementor
    wire [7:0] sum;
    
    //incrementor instance
    adder_8bit Incrementor(.a(sw),.b(val_2bit),.c_in(1'b0),.s(sum));
    
    //declaare wires to hold seperate segment outputs
    wire [6:0] lower_seg;
    wire [6:0] upper_seg;
    
    //call instances of hex7seg
    hex7seg lower_bits(.n(sum[3:0]),.seg(lower_seg));
    hex7seg upper_bits(.n(sum[7:4]),.seg(upper_seg));
    
    //add wire for digsel
    wire digsel;
    
    //instantiate m2_1x8 for final output seg[6:0]
    m2_1x8 seg_mux (.in0(~lower_seg),.in1(~upper_seg),.sel(digsel),.o(seg));
    
    //assign values for annodes 0 andd 1
    assign an[1] = ~digsel;
    assign an[0] = digsel;
    
    //assign remaining annodes and dp
    assign an[3] = 1'b1;    //active low
    assign an[2] = 1'b1;
    assign dp = 1'b1;
    
    lab3_digsel mod(.clkin(clkin),.greset(btnR),.digsel(digsel));
    
endmodule
