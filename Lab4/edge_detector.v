`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/06/2020 09:17:59 AM
// Design Name: 
// Module Name: edge_detector
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


module edge_detector(
    input btnIN,
    input clk,
    output o
    );
    
    //declare intermediary wires to make boolean logic 
    wire connect;
    wire out;
    
    FDRE #(.INIT(1'b0) ) ED_0 (.C(clk), .R(1'b0), .CE(1'b1), .D(btnIN), .Q(connect));
    FDRE #(.INIT(1'b0) ) ED_1 (.C(clk), .R(1'b0), .CE(1'b1), .D(connect), .Q(out));

    //assign final output by performing logic on connect & out
    assign o = connect&(~out);
    
endmodule
