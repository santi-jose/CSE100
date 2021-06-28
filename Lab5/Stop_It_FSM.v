`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/14/2020 10:16:41 AM
// Design Name: 
// Module Name: Stop_It_FSM
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


module Stop_It_FSM(
    input clk,
    input go,
    input stop,
    input sec_2,
    input sec_4,
    input match,
    output ShowNum,
    output ResetTimer,
    output ResetGCount,
    output RunGame,
    output Scored,
    output Flash_A,
    output Flash_B
    );
    
    //declare wires for flip-flop 
    wire [4:0]D;
    wire [4:0]Q;
    
    //call Stop_it logic
    Stop_It_logic stop_it (.go(go),.stop(stop),.sec_2(sec_2),.sec_4(sec_4),.match(match),.Q(Q),.D(D),.ShowNum(ShowNum),.ResetTimer(ResetTimer),.ResetGCount(ResetGCount),.RunGame(RunGame),.Scored(Scored),.Flash_A(Flash_A),.Flash_B(Flash_B));
    
    //instantiate flip-flops
    FDRE #(.INIT(1'b1)) state0_FF (.C(clk), .CE(1'b1), .D(D[0]), .Q(Q[0]));
    FDRE #(.INIT(1'b0)) state1234_FF[4:1] (.C({4{clk}}), .CE({4{1'b1}}), .D(D[4:1]), .Q(Q[4:1]));
    
endmodule
