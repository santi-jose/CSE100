`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2020 12:05:35 AM
// Design Name: 
// Module Name: Lab7_top
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


module Lab7_top(
    input clkin,
    input sw,
    input btnL,
    input btnR,
    input btnC,
    input [2:0]size,
    output hsync,
    output vsync,
    output [3:0] vgaRed,
    output [3:0] vgaBlue,
    output [3:0] vgaGreen,
    output [5:0] led,
    output [6:0] seg,
    output [3:0] an
    //output car_off_road: output for simulation
    );
    
    //declare wires for lab7_clks outputs
    wire clk, digsel;
    
    //call instance of lab7_clks
    lab7_clks not_so_slow (
        .clkin(clkin),
        .greset(sw), 
        .clk(clk), 
        .digsel(digsel)
    );

    //declare wires for time_counter
    wire sec_2, flash, ResetTimer, frame,qsec;
    
    //call instance of time counter
    time_counter count_time(
        .clk(clk),
        .ce(frame),
        .r(ResetTimer),
        .sec_2(sec_2),
        .flash(flash),
        .qsec(qsec)
    );
    
    //wires for score counter output
    wire score_UTC, score_DTC;
    wire [15:0]score;
    
    //declare wires for state machine                    
    wire setup, drive, go, flash_car, off_road, on_road; 
    
    //call score counter
    UDL16_count count_score(
        .up(sec_2&drive),
        .dw(1'b0),
        .ld(setup),
        .clk(clk),
        .D(16'd0),
        .UTC(score_UTC),
        .DTC(score_DTC),
        .Q(score)
    );

    
    //declare wire to store dig_sel bits
    wire [3:0] dig_sel;
    
    //declare wire to store hex value for conversion
    wire [3:0] H;
    
    //output score to 7-segment display
    //call ring counter to generate dig_sel bits
    ring_counter select_dig(.clk(clk),.Advance(digsel),.dig_sel(dig_sel));
    
    //call selector to choose hex value to convert to seg representation
    selector select_hex(.sel(dig_sel),.N(score),.H(H));
    
    //send Hex value be converted to seg representation
    hex7seg convert_hex(.n(H),.seg(seg));
    
    //assign an output
    assign an[3:0] = {~dig_sel[3],~dig_sel[2],~dig_sel[1],~dig_sel[0]};
    
    //edge detector to tell us when to start a game
    edge_detector detect_btnC(.btnIN(btnC),.clk(clk),.o(go));

    //call instance of state machine
    drive_SM play(
        .clk(clk),
        .go(go),
        .sec_2(sec_2),
        .off_road((~on_road)&drive),
        .drive(drive),
        .setup(setup),
        .flash_car(flash_car),
        .ResetTimer(ResetTimer),
        .Q(led[3:0])
    );

   
    
    //declare wires for VGAcontroller output
    wire [15:0]H_address;
    wire [15:0]V_address;

    //call instance of VGAcontroller
    VGAcontroller control(
        .clk(clk),
        .hsync(hsync),
        .vsync(vsync),
        .H_address(H_address),
        .V_address(V_address)
    );
    
    
    //call instance of edge detector to give a frame signal
    edge_detector detect_frame(.btnIN(vsync),.clk(clk),.o(frame));
        
    //declare wire for Create_Obj output
    wire ActiveRegion, car,L,R;
    wire [6:0]road;
    
    //instantiate FF's to synchronize button signals
    FDRE #(.INIT(1'b0) ) btnL_FF (.C(clk), .R(1'b0), .CE(1'b1), .D(btnR&(~btnL)), .Q(L));
    FDRE #(.INIT(1'b0) ) btnR_FF (.C(clk), .R(1'b0), .CE(1'b1), .D(btnL&(~btnR)), .Q(R));
   
    //call instance of Create_Obj
    Create_Obj create(        
        .clk(clk),
        .R(R),
        .L(L),
        .frame(frame),
        .setup(setup),
        .drive(drive),
        .flash(flash),
        .flash_car(flash_car),
        .size(size),
        .H_address(H_address),
        .V_address(V_address),
        .ActiveRegion(ActiveRegion),
        .car(car),
        .road(road),
        .off_road(off_road),//off road and on road should only be on at drive
        .on_road(on_road)
    );
    
    
//    //assign off_road and on_road
//    assign off_road = ~on_road;
//    assign on_road = ((|road)&car);
    
     //assign led [4] and [5] to test off_road & on_road signal
    assign led[4] = off_road;   //THIS IS HIGH AT ALL TIMES (WHY??)
    //ITS ALSO HIGH WHEN THE RESET SIGNAL IS HIGH
    assign led[5] = on_road;//this signal is very faint but looks like the 
    //correct evaluation
    
    
    //call insgtance of Colorize
    Colorize colors(
        .ActiveRegion(ActiveRegion),
        .car(car),
        .road(road),
        .vgaRed(vgaRed),
        .vgaBlue(vgaBlue),
        .vgaGreen(vgaGreen)
    );
    
    
    
endmodule
