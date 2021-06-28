`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/06/2020 09:17:59 AM
// Design Name: 
// Module Name: ring_counter
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


module ring_counter(
    input Advance,
    input clk,
    output [3:0] an
    );
    //intermediate wires to connect ring counter D and Q's 
    wire [3:0] connect;
        
    //call four flip flops to store current 4-bit value output by counter
    FDRE #(.INIT(1'b1) ) ring_0 (.C(clk), .R(1'b0), .CE(Advance), .D(connect[3]), .Q(connect[0]));
    FDRE #(.INIT(1'b0) ) ring_1 (.C(clk), .R(1'b0), .CE(Advance), .D(connect[0]), .Q(connect[1]));
    FDRE #(.INIT(1'b0) ) ring_2 (.C(clk), .R(1'b0), .CE(Advance), .D(connect[1]), .Q(connect[2]));
    FDRE #(.INIT(1'b0) ) ring_3 (.C(clk), .R(1'b0), .CE(Advance), .D(connect[2]), .Q(connect[3]));

    //assign Q wire to output
    assign an = connect;
    
    
    
endmodule
