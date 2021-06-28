`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/14/2020 04:16:54 PM
// Design Name: 
// Module Name: Lab5_top
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


module Lab5_top(
    input clkin,
    input btnR,
    input btnU,
    input btnC,
    output [15:0] led,
    output [3:0] an,
    output dp,
    output [6:0] seg
    );
    
    //declare wires to store input signals
    wire go, stop;
    
    //declare wires for Stop_It FSM
    wire ShowNum, ResetTimer, ResetGCount, RunGame, Scored, Flash_A, Flash_B;
    
   //declare wire to store digsel, clk, and qsec
    wire digsel, clk, qsec;
    
    //call FFs to synchronize buttons C and U
    FDRE #(.INIT(1'b0)) btnU_FF (.C(clk), .CE(1'b1), .D(btnU), .Q(stop));
    FDRE #(.INIT(1'b0)) btnC_FF (.C(clk), .CE(1'b1), .D(btnC), .Q(go));

    //call instance of lab5clks
    lab5_clks slowit (.clkin(clkin), .greset(btnR), .clk(clk), .digsel(digsel), .qsec(qsec));
    
    //declare wire to store random number bits
    wire [7:0]rnd;
    
    //call instance of Random_LFSR
    Random_LFSR randomize(.clk(clk),.ce(~ShowNum),.rnd(rnd));
    
    //declare wires to store game_counter bits
    wire [7:0] gcount_bits;
    
    //call instance of game_counter
    game_counter gcount(.clk(clk),.count(RunGame&qsec),.reset(ResetGCount),.gcount_bits(gcount_bits));
    
    //declare wires to store time_counter bits
    wire [15:0] time_bits;
    wire sec_2, sec_4;    
    
    //call instance of time_counter
    time_counter tcount(.clk(clk),.count(qsec),.reset(ResetTimer),.time_bits(time_bits),.sec_2(sec_2),.sec_4(sec_4));
    
    //declare wire for match
    wire match;
    
    //declare match value
    assign match = ~|(gcount_bits[5:0]^rnd[5:0]);
    
    //call instance of Stop_It FSM
    Stop_It_FSM Stop_It(.clk(clk),.go(go),.stop(stop),.sec_2(sec_2),.sec_4(sec_4),.match(match),.ShowNum(ShowNum),.ResetTimer(ResetTimer),.ResetGCount(ResetGCount),.RunGame(RunGame),.Scored(Scored),.Flash_A(Flash_A),.Flash_B(Flash_B));
    
    //declare wire to store score count
    wire score_count;
    
    //feed scored through an Edge detector
    edge_detector score_detect(.btnIN(Scored),.clk(clk),.o(score_count));
    
    //call instance of LED shifter
    SR_16b LED_shifter(.in(1'b1),.ce(score_count),.clk(clk),.reset(1'b0),.Q(led[15:0]));
    
    //declare wire to store select bits
    wire [3:0] sel_bits;
    
    //call instance of ring_counter
    ring_counter digits(.clk(clk),.Advance(digsel),.an(sel_bits));
    
    //declare wire to store 16-bit 7seg values
    wire [15:0]N;
    wire [3:0]H;
    
    //assign value of N vector
    assign N = {1'b0,1'b0,rnd[5:0],gcount_bits[7:0]};
    
    //call instance of selector
    selector select_hex(.sel(sel_bits),.N(N),.H(H));
    
    //calli nstance of hex7seg
    hex7seg convert(.n(H),.seg(seg));
    
    //declare wire to store intermediate an values
    wire [3:0]an_flash;
    
    //call flash logic module
    an_logic logic_an(.qsec(time_bits[0]),.ShowNum(ShowNum),.sel_bits(sel_bits),.Flash_A(Flash_A),.Flash_B(Flash_B),.an(an));
    
    //assign an and dp
    assign dp = 1'b1;
    
endmodule
