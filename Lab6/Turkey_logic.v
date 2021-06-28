`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2020 01:35:47 AM
// Design Name: 
// Module Name: Turkey_logic
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


module Turkey_logic(
    input [6:0]Q,
    input L,
    input R,
    output L_R_count,
    output R_L_count,
    output ResetTimer,
    output [6:0]D
    );
    
    //assign next state logic
    //Start 
    assign D[0] = (Q[0]&L&R)|(Q[1]&L&R)|(Q[4]&L&R)|(Q[0]&(~L)&(~R))|(Q[3]&L&R)|(Q[6]&L&R);
    //Left
    assign D[1] = ((Q[0]&(~L)&R)|(Q[1]&(~L)&R)|(Q[2]&(~L)&R));
    //L_both
    assign D[2] = ((Q[1]&(~L)&(~R))|(Q[2]&(~L)&~(R))|(Q[3]&(~L)&(~R)));
    //L_right
    assign D[3] = ((Q[2]&L&(~R))|(Q[3]&L&(~R)));
    //Right
    assign D[4] = ((Q[0]&L&(~R))|(Q[4]&L&(~R))|(Q[5]&L&(~R)));
    //R_both
    assign D[5] = ((Q[4]&(~L)&(~R))|(Q[5]&(~L)&(~R))|(Q[6]&(~L)&(~R)));
    //R_left
    assign D[6] = ((Q[5]&(~L)&R)|(Q[6]&(~L)&R));
       
    //assign SM outputs
    assign L_R_count = Q[3]&L&R;
    assign R_L_count = Q[6]&L&R;   
    assign ResetTimer = Q[0];
       
endmodule
