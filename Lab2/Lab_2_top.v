`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/16/2020 11:18:34 AM
// Design Name: 
// Module Name: Lab_2_top
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


module Lab_2_top(
        input sw0,
        input sw1,
        input sw2,
        input sw3,
        input sw4,
        input sw5,
        input sw6,
        output seg0,
        output seg1,
        output seg2,
        output seg3,
        output seg4,
        output seg5,
        output seg6,
        output DP,
        output AN0,
        output AN1,
        output AN2,
        output AN3
    );
    //declare wires to connect carry in wires across full_adders
    wire c_1;
    wire C_2;
    
    //declare wires to hold adder output
    wire s0;
    wire s1;
    wire s2;
    wire s3;
    
    //instantiate and connect 3 full adders
    full_adder adder_0 (.a(sw1),.b(sw4),.c_in(sw0),.c_out(c_1),.s(s0));
    full_adder adder_1 (.a(sw2),.b(sw5),.c_in(c_1),.c_out(c_2),.s(s1));
    full_adder adder_2 (.a(sw3),.b(sw6),.c_in(c_2),.c_out(s3),.s(s2));
    
    //calli instance of seg_converter
    seg_converter convert (.n3(s3),.n2(s2),.n1(s1),.n0(s0),.CA(seg0),.CB(seg1),.CC(seg2),.CD(seg3),.CE(seg4),.CF(seg5),.CG(seg6));
    
    //turn on anode 0
    assign AN0 = 1'b0;
    
    //keep other anodes off
    assign AN1 = 1'b1;
    assign AN2 = 1'b1;
    assign AN3 = 1'b1;
    
    //keep DP off
    assign DP = 1'b1;

endmodule
