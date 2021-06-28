`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/06/2020 12:58:01 PM
// Design Name: 
// Module Name: Lab_4_top
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


module Lab_4_top(
    input clkin,
    input btnR,
    input btnU,
    input btnD,
    input btnC,
    input btnL,
    input [15:0] sw,
    output dp,
    output [3:0] an,
    output [15:0] led,
    output [6:0] seg
    );
    
    //declare wires to store input button logic 
    wire up;
    wire dw;
    
    //declare wires to store counter outputs
    wire [15:0] Q;
    wire UTC;
    wire DTC;
    
    //declare clk wire
    wire clk;
    
    //initialize Edge detector for btnD input
    edge_detector btnD_edge(.btnIN(btnD),.clk(clk),.o(dw));
    
    //declare wire to store btnU edge
    wire btnU_e;
    
    //initialize Edge detectore for btnU input
    edge_detector btnU_edge(.btnIN(btnU),.clk(clk),.o(btnU_e));    
    
    //declare wire to store value of &Q[15:2]
    wire btnC_invalid_range;
    
    assign btnC_invalid_range = &Q[15:2];
    
    //wire to store value going into & out of our FF for signal btnC
    wire btnC_logic;
    wire btnC_FF_out;
    
    assign btnC_logic =  (~btnC_invalid_range)&btnC_FF_out;
    
    //feed btnC through flip-flop to synchronize
    FDRE #(.INIT(1'b0) ) btnC_FF (.C(clk), .R(1'b0), .CE(1'b1), .D(btnC), .Q(btnC_FF_out));    
    
    //call instance of 16bit counter
    UDL16_count counter(.up(up),.dw(dw),.ld(btnL),.clk(clk),.D(sw),.Q(Q),.UTC(UTC),.DTC(DTC));
    
    //assign value for counter up signal
    assign up = btnC_logic|btnU_e;
    
    //declare wire to store output of ring counter
    wire [3:0] sel_bits;
    
    //declare wire to store digsel
    wire digsel;
    
    //initialize ring counter, selector, and hex7seg
    ring_counter r_count(.Advance(digsel),.clk(clk),.an(sel_bits));   
    
    //declre wire to store output of selectore
    wire [3:0] H;
    
    selector select_hex(.sel(sel_bits),.N(Q),.H(H)); 
    
    hex7seg convert(.n(H),.seg(seg));
    
    //instantiate lab4clks
    lab4_clks slowit (.clkin(clkin), .greset(btnR), .clk(clk), .digsel(digsel));
    
    //assign led outputs to correspond to switch values
    assign led = sw;
    
    //assign dp and an output; inverted sel_bits bc anode active low
    assign an = {~sel_bits[3],~sel_bits[2],~sel_bits[1],~sel_bits[0]};
    
    //only want dp on for annodes 2 and 1 at UTC and DTC
    assign dp = ~((UTC&sel_bits[2])|(DTC&sel_bits[1]));
    
endmodule
