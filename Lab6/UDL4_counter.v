`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/06/2020 01:26:03 AM
// Design Name: 
// Module Name: UDL4_counter
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


module UDL4_count(
    input [3:0] D,
    input up,
    input dw,
    input ld,
    input clk,
    output [3:0] Q,
    output UTC,
    output DTC
    );
    
    //assign CE wire to enable our flip-flops update
    wire CE;
    wire reset;
    assign reset = 1'b0;
    assign CE = ld|((up^dw)&~ld);
    
    //declare wires to store boolean logic
    wire [3:0] bus_up;
    wire [3:0] bus_dw;
    wire [3:0] data;
    wire [3:0] count;
    
    //assign bus_up logic
    assign bus_up[0] = Q[0]^CE;
    assign bus_up[1] = Q[1]^(CE&Q[0]);
    assign bus_up[2] = Q[2]^(CE&Q[1]&Q[0]);
    assign bus_up[3] = Q[3]^(CE&Q[2]&Q[1]&Q[0]);
    
    //assign bus_dw logic
    assign bus_dw[0] = Q[0]^(CE);
    assign bus_dw[1] = Q[1]^(CE&(~Q[0]));
    assign bus_dw[2] = Q[2]^(CE&(~Q[1])&(~Q[0]));
    assign bus_dw[3] = Q[3]^(CE&(~Q[2])&(~Q[1])&(~Q[0]));
    
    //assign UTC and DTC outputs
    assign UTC = Q[0]&Q[1]&Q[2]&Q[3];
    assign DTC = ~(Q[0]|Q[1]|Q[2]|Q[3]);
    
    //call mux to determine which 4-bit bus to enter the FF's
    m2_1x4 up_dw_mux(.in0(bus_up),.in1(bus_dw),.sel(dw),.o(count));
    m2_1x4 count_ld_mux(.in0(count),.in1(D),.sel(ld),.o(data));
    
    //instantiate FF's
    FDRE #(.INIT(1'b0) ) count_0 (.C(clk), .R(reset), .CE(CE), .D(data[0]), .Q(Q[0]));
    FDRE #(.INIT(1'b0) ) count_1 (.C(clk), .R(reset), .CE(CE), .D(data[1]), .Q(Q[1]));
    FDRE #(.INIT(1'b0) ) count_2 (.C(clk), .R(reset), .CE(CE), .D(data[2]), .Q(Q[2]));
    FDRE #(.INIT(1'b0) ) count_3 (.C(clk), .R(reset), .CE(CE), .D(data[3]), .Q(Q[3]));


        
endmodule
