`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2020 08:26:19 PM
// Design Name: 
// Module Name: drive_SM_logic
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


module drive_SM_logic(
    input go,
    input sec_2,
    input off_road,
    input [3:0]Q,
    output drive,
    output setup,
    output flash_car,
    output ResetTimer,
    output [3:0]D
    );
    
    //assign next state logic
    assign D[0] = (Q[0]&(~go));
    //transition into D[1] from D[2] b/c D[3] transition broken
    assign D[1] = (Q[0]&go)|(Q[1]&(~sec_2))|(Q[3]&go);
    //no D[3] transition because state machine is not working
    //testing state machine with states D[2:0]
    assign D[2] = (Q[1]&sec_2)|(Q[2]);
    //no transition into D[3] to test the off_road output 
    assign D[3] = (|Q[3]&(~go));
   
    //assign outputs
    assign drive = Q[2];
    assign setup = Q[0]|Q[1];
    assign flash_car = (Q[1]|Q[3]);
    assign ResetTimer = (Q[0]&go)|(Q[3]&go)|(Q[1]&sec_2);
    
endmodule
