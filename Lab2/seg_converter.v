`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/16/2020 11:26:02 AM
// Design Name: 
// Module Name: seg_converter
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


module seg_converter(
    input n3,
    input n2,
    input n1,
    input n0,
    output CA,
    output CB,
    output CC,
    output CD,
    output CE,
    output CF,
    output CG
    );
    
    //assign output segment logic
    //CA = PI(M(14,11,13))
    assign CA = ~((n3|n2|n1|~n0)&(n3|~n2|n1|n0)&(~n3|n2|~n1|~n0)&(~n3|~n2|n1|~n0));
    //CB = PI(M(5,6,11,12,14,15))
    assign CB = ~((n3|~n2|n1|~n0)&(n3|~n2|~n1|n0)&(~n3|n2|~n1|~n0)&(~n3|~n2|n1|n0)&(~n3|~n2|~n1|n0)&(~n3|~n2|~n1|~n0));
    //CC = PI(M(2,12,14,15))
    assign CC = ~((n3|n2|~n1|n0)&(~n3|~n2|n1|n0)&(~n3|~n2|~n1|n0)&(~n3|~n2|~n1|~n0));
    //CD = PI(M(1,4,7,9,10,15))
    assign CD =~((n3|n2|n1|~n0)&(n3|~n2|n1|n0)&(n3|~n2|~n1|~n0)&(~n3|n2|n1|~n0)&(~n3|n2|~n1|n0)&(~n3|~n2|~n1|~n0));
    //CE = PI(M(1,3,4,5,7,9))
    assign CE = ~((n3|n2|n1|~n0)&(n3|n2|~n1|~n0)&(n3|~n2|n1|n0)&(n3|~n2|n1|~n0)&(n3|~n2|~n1|~n0)&(~n3|n2|n1|~n0));
    //CF = PI(M(1,2,3,7,13))
    assign CF = ~((n3|n2|n1|~n0)&(n3|n2|~n1|n0)&(n3|n2|~n1|~n0)&(n3|~n2|~n1|~n0)&(~n3|~n2|n1|~n0));
    //CG = PI(M(0,1,7,12))
    assign CG = ~((n3|n2|n1|n0)&(n3|n2|n1|~n0)&(n3|~n2|~n1|~n0)&(~n3|~n2|n1|n0));
    
    
endmodule
