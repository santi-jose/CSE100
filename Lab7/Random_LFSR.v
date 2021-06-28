`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/14/2020 08:42:04 AM
// Design Name: 
// Module Name: Random_LFSR
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


module Random_LFSR(
    input clk,
    input ce,
    output [7:0] rnd
    );
    
    //wire to hold random logic
    wire rnd_logic;
    
    //assign rnd_logic
    assign rnd_logic = rnd[0]^rnd[5]^rnd[6]^rnd[7];
    
    FDRE #(.INIT(1'b1)) rnd_0_FF (.C(clk), .CE(ce), .D(rnd_logic), .Q(rnd[0]),.R(1'b0));
    FDRE #(.INIT(1'b0)) rnd_FF[7:1] (.C({7{clk}}), .CE({7{ce}}), .D(rnd[6:0]), .Q(rnd[7:1]),.R(1'b0));

    
    
endmodule
