`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2020 08:11:14 PM
// Design Name: 
// Module Name: drive_SM
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


module drive_SM(
    input clk,
    input go,
    input sec_2,
    input off_road,
    output drive,
    output setup,
    output flash_car,
    output ResetTimer,
    output [3:0]Q
    );
    
    //declare wire to store state transitions
    wire [3:0]D;
    //wire [3:0]Q;
    
    //call instance of drive_logic
    drive_SM_logic play(
        .go(go),
        .sec_2(sec_2),
        .off_road(off_road),
        .drive(drive),
        .setup(setup),
        .flash_car(flash_car),
        .ResetTimer(ResetTimer),
        .D(D),
        .Q(Q)
    );
    
    FDRE #(.INIT(1'b1) ) STATE_0 (.C(clk), .R(1'b0), .CE(1'b1), .D(D[0]), .Q(Q[0]));
    FDRE #(.INIT(1'b0) ) STATE[3:1] (.C({3{clk}}), .R({3{1'b0}}), .CE({3{1'b1}}), .D(D[3:1]), .Q(Q[3:1]));

    
endmodule
