`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2020 04:00:51 PM
// Design Name: 
// Module Name: gen_road
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


module gen_road(
        input clk,
        input drive,
        input [15:0]V_address,
        input [15:0]H_address,
        input frame,
        input [15:0]INIT_H_POS,
        input [15:0]PREV_H_POS,
        input [15:0]INIT_V_POS,
        input L,
        input R,
        input reset_road,
        input [2:0]size,
        output road,
        output [15:0]road_h_address
    );
    
    //declare wires to store road_v_address for road segment 1
    wire [15:0]road_v_address;
    wire rollover;
    
    //call instance of road_v_counter for road segment 1
    road_v_counter road_v_pos(
        .up(frame&drive),
        .reset(reset_road),
        .clk(clk),
        .INIT_V_POS(INIT_V_POS),
        .road_v_address(road_v_address),
        .rollover(rollover)
     );
    
    //declare wires to hold road position
    wire road_y, road_x;
    
    //assign road coordinate ranges
    
    //declare wire to tell our road to generate properly from top of the screen to bottom
    wire sel;
    wire plus_80;
    wire minus_80;
    
    //define select
    assign sel = (road_v_address<16'd80);
    
    //assign ranges for the inputs
    assign plus_80 = (V_address>=(road_v_address-16'd80))&&((road_v_address)>=V_address);
    assign minus_80 = V_address<=road_v_address;
    
    //use a mux to output the correct coordinates
    m2_1 road_y_mux(
        .in({minus_80,plus_80}),
        .sel(sel),
        .o(road_y)
    );
    
    //declare wire to store rand value
    wire [15:0]rnd;
    
    //call randomizer
    Random_LFSR random_offset(.clk(clk),.ce(1'b1),.rnd(rnd[7:0]));
    
    //declare wire to store inputs to Reset mux 
    wire [15:0]ADD_OFFSET;
    wire [15:0]SUB_OFFSET;
    wire [15:0]RESET_H_POS;
    wire [15:0]OFFSET;
    
    //assign random offset and addition and subtraction of them
    assign OFFSET = {10'd0,rnd[5:3],3'd0};
    assign ADD_OFFSET = {PREV_H_POS+OFFSET};
    assign SUB_OFFSET = {PREV_H_POS-OFFSET};
    
    //use a mux to determine the proper reset position
    m2_1x16 RESET_H_mux(
        .in0(ADD_OFFSET),
        .in1(SUB_OFFSET),
        .sel(rnd[6]),
        .o(RESET_H_POS)
    );
    
    //call instance of road_h_counter
    road_h_counter road_h_pos(
        .clk(clk),        
        .L(L&frame&drive),
        .R(R&frame&drive),
        .reset(reset_road),
        .rollover(rollover),
        .INIT_H_POS(INIT_H_POS),
        .RESET_H_POS(RESET_H_POS),
        .road_h_address(road_h_address)
    );
    
    //declare wire to store offset for H- address
    wire [15:0]H_OFFSET;
    wire [15:0]OFFSET_0;
    wire [15:0]OFFSET_1;
    wire [15:0]OFFSET_2;
    wire [15:0]OFFSET_3;
    wire [15:0]OFFSET_4;
    wire [15:0]OFFSET_5;
    wire [15:0]OFFSET_6;
    wire [15:0]OFFSET_7;
    
        
    //assign eight different offset values
    assign OFFSET_0 = 16'd8;
    assign OFFSET_1 = 16'd24;
    assign OFFSET_2 = 16'd40;
    assign OFFSET_3 = 16'd56;
    assign OFFSET_4 = 16'd72;
    assign OFFSET_5 = 16'd88;
    assign OFFSET_6 = 16'd104;
    assign OFFSET_7 = 16'd120;
    
    //call instance of mux 
    m8_1x16 pick_H_SIZE(
    .in0(OFFSET_0),
    .in1(OFFSET_1),
    .in2(OFFSET_2),
    .in3(OFFSET_3),
    .in4(OFFSET_4),
    .in5(OFFSET_5),
    .in6(OFFSET_6),
    .in7(OFFSET_7),
    .sel(size),
    .o(H_OFFSET)
    );
    
//    //assign static horizontal boundaries for now
    assign road_x = (H_address<(road_h_address+(H_OFFSET>>1)))&&(H_address>=(road_h_address-(H_OFFSET>>1)));
      
    assign road = road_y&road_x;
    
    
endmodule
