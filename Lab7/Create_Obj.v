`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2020 12:06:57 AM
// Design Name: 
// Module Name: Create_Obj
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


module Create_Obj(
    input [15:0] H_address,
    input [15:0] V_address,
    input clk,
    input frame,
    input L,
    input R,
    input drive,
    input setup,
    input flash,
    input flash_car,
    input [2:0]size,
    output ActiveRegion,
    output car,
    output off_road,
    output on_road,
    output [6:0]road
    );
    
    //define H_boundary and V_boundary
    wire H_boundary, V_boundary;
    
    //assign boundaries of our Active Region
    assign H_boundary = H_address<=16'd639;
    assign V_boundary = V_address<=16'd479;
    
    //assign ActiveRegion
    assign ActiveRegion = H_boundary&&V_boundary;
    
    //define wires for x and y bounds of our car 
    wire car_x;
    wire car_y;
    
    //assign x and y bounds for car
    assign car_x = (H_address>=16'd312)&&(H_address<=16'd327);
    assign car_y = (V_address>=16'd393)&&(V_address<=16'd408);
    
    //declare wire to assign car flashing and car not flashing values
    wire flashing_car;
    wire static_car;
    
    //assign static and flashing_car values
    assign flashing_car = car_x&car_y&flash;
    assign static_car = car_x&car_y;
    
    //assign car object using a 2_1_mux to determine the output
    //as flashing or not
    m2_1 car_mux(
        .in({flashing_car,static_car}),
        .sel(flash_car),
        .o(car)
    );
        
    //declare wire for road_1
    wire [15:0]road_h_address_0;
    wire [15:0]road_h_address_1;
    wire [15:0]road_h_address_2;
    wire [15:0]road_h_address_3;
    wire [15:0]road_h_address_4;
    wire [15:0]road_h_address_5;
    wire [15:0]road_h_address_6;
    
    //call an instance of our road generator
    gen_road road_seg_0(
        .clk(clk),
        .drive(drive),
        .V_address(V_address),
        .H_address(H_address),
        .frame(frame),
        .INIT_H_POS(16'd280),
        .PREV_H_POS(road_h_address_6),
        .INIT_V_POS(16'd559),
        .L(L),
        .R(R),
        .reset_road(setup),
        .size(size),
        .road(road[0]),
        .road_h_address(road_h_address_0)
    );
    
    
    //call an instance of our road generator
    gen_road road_seg_1(
        .clk(clk),
        .drive(drive),
        .V_address(V_address),
        .H_address(H_address),
        .frame(frame),
        .INIT_H_POS(16'd310),
        .PREV_H_POS(road_h_address_0),
        .INIT_V_POS(16'd479),
        .L(L),
        .R(R),
        .reset_road(setup),
        .size(size),
        .road(road[1]),
        .road_h_address(road_h_address_1)
    );
    
    
    //call an instance of our road generator
    gen_road road_seg_2(
        .clk(clk),
        .drive(drive),
        .V_address(V_address),
        .H_address(H_address),
        .frame(frame),
        .INIT_H_POS(16'd326),
        .PREV_H_POS(road_h_address_1),
        .INIT_V_POS(16'd399),
        .L(L),
        .R(R),
        .reset_road(setup),
        .size(size),
        .road(road[2]),
        .road_h_address(road_h_address_2)
    );
    
    //call an instance of our road generator
    gen_road road_seg_3(
        .clk(clk),
        .drive(drive),
        .V_address(V_address),
        .H_address(H_address),
        .frame(frame),
        .INIT_H_POS(16'd301),
        .PREV_H_POS(road_h_address_2),
        .INIT_V_POS(16'd319),
        .L(L),
        .R(R),
        .reset_road(setup),
        .size(size),
        .road(road[3]),
        .road_h_address(road_h_address_3)
    );
    
    //call an instance of our road generator
    gen_road road_seg_4(
        .clk(clk),
        .drive(drive),
        .V_address(V_address),
        .H_address(H_address),
        .frame(frame),
        .INIT_H_POS(16'd289),
        .PREV_H_POS(road_h_address_3),
        .INIT_V_POS(16'd239),
        .L(L),
        .R(R),
        .reset_road(setup),
        .size(size),
        .road(road[4]),
        .road_h_address(road_h_address_4)
    );
    
    //call an instance of our road generator
    gen_road road_seg_5(
        .clk(clk),
        .drive(drive),
        .V_address(V_address),
        .H_address(H_address),
        .frame(frame),
        .INIT_H_POS(16'd261),
        .PREV_H_POS(road_h_address_4),
        .INIT_V_POS(16'd159),
        .L(L),
        .R(R),
        .reset_road(setup),
        .size(size),
        .road(road[5]),
        .road_h_address(road_h_address_5)
    );
    
    //call an instance of our road generator
    gen_road road_seg_6(
        .clk(clk),
        .drive(drive),
        .V_address(V_address),
        .H_address(H_address),
        .frame(frame),
        .INIT_H_POS(16'd287),
        .PREV_H_POS(road_h_address_5),
        .INIT_V_POS(16'd79),
        .L(L),
        .R(R),
        .reset_road(setup),
        .size(size),
        .road(road[6]),
        .road_h_address(road_h_address_6)
    );
    
    //wire off_road, on_road;
    
    //detect on and off road with static car evaluation
    assign on_road = ((|road)&&static_car);
    assign off_road = ~on_road;
    
endmodule
