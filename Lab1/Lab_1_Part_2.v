`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/09/2020 11:07:57 AM
// Design Name: 
// Module Name: Lab_1_Part_2
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


module Lab_1_Part_2(
//button and switch input declarations
    input btnC,
    input SW0,
    input SW1,
    input SW2,
//LED output declarations
    output LD0,
    output LD1,
    output LD2,
    output LD3
    );
    
//    the NOT of pushbutton C output to LD0
    assign LD0 = ~btnC;
    
//    the AND of switch SW0 and SW1 output to LD1
    assign LD1 = SW0 & SW1;
    
//    the OR of switch SW0 and SW1 output to LD2
    assign LD2 = SW0 | SW1;
    
//    the XOR of switches SW0, SW1, and SW2
    assign LD3 = SW0^SW1^SW2;

endmodule

