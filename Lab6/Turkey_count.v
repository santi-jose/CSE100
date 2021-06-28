`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2020 01:54:27 AM
// Design Name: 
// Module Name: Turkey_count
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

module Turkey_count(
    input clk,
    input L_R_count,
    input R_L_count,
    output [6:0]t_count,
    output neg
    );
    
    //declare wire to store negative
    wire neg_w;

    //declare wires to store up and dw logic
    wire up, dw;
    
    //assign wires for counter outputs
    wire UTC, DTC;
    wire [7:0]Q;    
    
    //declare wire to store turkey count TC(127)
    wire turkey_TC;
    
    //assign turkey_TC
    assign turkey_TC = &Q[6:0];
    
    //assign up and dw logic 
    assign up = ((L_R_count&~neg_w)|(R_L_count&neg_w)|(R_L_count&DTC))&~turkey_TC;
    assign dw = ((L_R_count&neg_w)|(R_L_count&~neg_w))&~DTC;
    
    //call instance of 8-bit counter
    UDL8_count count_Turkeys(.clk(clk),.D({8{1'b0}}),.up(up),.dw(dw),.ld(1'b0),.UTC(UTC),.DTC(DTC),.Q(Q));
    
    //assign time bits
    assign t_count = Q[6:0];
   
    //declare wires to store ff enable and reset logic
    wire ce_neg, r_neg, one;
    
    //assign wire to go high when our counter value is one
    assign one = (~(|Q[7:1]))&Q[0];
    
    //assign logic for ce and reset
    assign ce_neg = DTC&R_L_count;
    assign r_neg = neg_w&L_R_count&one;
   
    //instantiatte flip-flop to hold negative value
    FDRE #(.INIT(1'b0) ) neg_ff (.C(clk), .R(r_neg), .CE(ce_neg), .D(1'b1), .Q(neg_w));
    
    //assign output that tells us whether our number is negative or not
    assign neg = neg_w;
    
endmodule