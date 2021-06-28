`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/14/2020 10:25:17 AM
// Design Name: 
// Module Name: Stop_It_logic
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


module Stop_It_logic(
    input go,
    input stop,
    input sec_2,
    input sec_4,
    input match,
    input [4:0]Q,
    output [4:0]D,
    output ShowNum,
    output ResetTimer,
    output ResetGCount,
    output RunGame,
    output Scored,
    output Flash_A,
    output Flash_B
    );
    
    //assign next state logic
    //HIT = (PLAY & STOP & MATCH) OR (HIT & (NOT(4SECS))
    assign D[4] = (Q[2]&stop&match)|(Q[4]&(~sec_4));
    //MISS = (PLAY & STOP & NOT MATCH) OR (MISS & (NOT(4SECS))
    assign D[3] = (Q[2]&stop&(~match))|(Q[3]&~sec_4);
    //PLAY = (SETUP & 2SECS) OR (PLAY & (NOT(STOP)))
    assign D[2] = (Q[1]&sec_2)|(Q[2]&(~stop));
    //SETUP = (START & GO) OR (SETUP & (NOT(2SECS))
    assign D[1] = (Q[0]&go)|(Q[1]&(~sec_2));
    //START = (START & (NOT(GO)) OR (MISS & 4SECS) OR (HIT & 4SECS)
    assign D[0] = (Q[0]&(~go))|(Q[3]&sec_4)|(Q[4]&sec_4);
    
    //assign output logic
    //ShowNum = (NOT(START))
    assign ShowNum = ~Q[0];
    //ResetTimer = START OR PLAY
    assign ResetTimer = (Q[0]&go)|(Q[2]&stop);
    //ResetGCount = Go AND Q[2]
    assign ResetGCount = Q[0]&go;
    //sec_2&Q[1];
    //RunGame = PLAY
    assign RunGame = Q[2];
    //Scored = HIT 
    assign Scored = Q[4];
    //FlashBoth = HIT
    assign Flash_B = Q[4];
    //FlashAlt = MISS
    assign Flash_A = Q[3];
    
    
    
endmodule
