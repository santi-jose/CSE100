`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2020 01:35:47 AM
// Design Name: 
// Module Name: Turkey_SM
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


module Turkey_SM(
    input clk,
    input L,
    input R,
    output L_R_count,
    output R_L_count,
    output ResetTimer
    );
    
    //declare wire to store FF inputs and outputs
    wire [6:0] Q;
    wire [6:0] D;
    
    //call turkey_SM logic
    Turkey_logic gen_outputs(.Q(Q),.L(L),.R(R),.L_R_count(L_R_count),.R_L_count(R_L_count),.ResetTimer(ResetTimer),.D(D));
    
    //initialize flip-flops to hold our states
    FDRE #(.INIT(1'b1) ) state_0 (.C(clk), .R(1'b0), .CE(1'b1), .D(D[0]), .Q(Q[0]));
    FDRE #(.INIT(1'b0) ) state[6:1] (.C({6{clk}}), .R({6{1'b0}}), .CE({6{1'b1}}), .D(D[6:1]), .Q(Q[6:1]));    
    
    
endmodule
