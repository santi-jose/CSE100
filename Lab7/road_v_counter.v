`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2020 02:26:57 AM
// Design Name: 
// Module Name: road_v_counter
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

module road_v_counter(
    input [15:0]INIT_V_POS,
    input up,
    input reset,
    input clk,
    output [15:0]road_v_address,
    output rollover
    );
    
    //declare wire to store inputs/outputs of 16-bit counter
    wire UTC, DTC; 
    wire [15:0]v_road_MAX;
    wire [15:0]ld_bus;
    
    //assign rollover value
    assign v_road_MAX = road_v_address>16'd557;
    
    //assign rollover signal
    assign rollover = up&(v_road_MAX);
    
    //call mux to determine load value
    m2_1x16 ld_mux(
        .in0(INIT_V_POS>>1),
        .in1(16'd0),
        .sel(rollover),
        .o(ld_bus)
    );
    
    //wire to store unshifted address
    wire [15:0]unshifted_address;
    
    //call instance of 16-bit counter
    UDL16_count road_y(
        .up(up),
        .dw(1'b0),
        .ld(reset|rollover),
        .D(ld_bus),
        .clk(clk),
        .UTC(UTC),
        .DTC(DTC),
        .Q(unshifted_address)
    );

    //assign final output shifted once to the left
    assign road_v_address = unshifted_address<<1;

endmodule