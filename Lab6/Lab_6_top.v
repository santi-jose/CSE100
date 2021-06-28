`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2020 02:48:14 PM
// Design Name: 
// Module Name: Lab_6_top
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


module Lab_6_top(
    input btnL,
    input btnR,
    input btnU,
    input clkin,
    output [6:0] seg,
    output [3:0] an,
    output [15:0] led
    );
    //declare wires to hold lab6_clks outputs
    wire digsel, qsec, clk;
    
    //instance of lab6_clks
    lab6_clks slowit (.clkin(clkin), .greset(btnU), .clk(clk), .digsel(digsel), .qsec(qsec));
    
    //declare wires to hold synchronized btnL and btnR signals
    wire R,L;
    
    //call instance of FF's for R and L signals
    FDRE #(.INIT(1'b1) ) R_ff (.C(clk), .R(1'b0), .CE(1'b1), .D(~btnR), .Q(R));
    FDRE #(.INIT(1'b1) ) L_ff (.C(clk), .R(1'b0), .CE(1'b1), .D(~btnL), .Q(L));

    //declare wires to store outputs to SM
    wire L_R_count, R_L_count, ResetTimer;

    //call instance of Turkey_SM
    Turkey_SM go_Turkeys(.clk(clk),.L(L),.R(R),.L_R_count(L_R_count),.R_L_count(R_L_count),.ResetTimer(ResetTimer));
    
    //declare wires to store outputs of counters
    wire [7:0]t_count;
    wire neg;
    wire [3:0]time_bits;
    
    //call instances of Turkey counter and time counter
    Turkey_count count_turkeys(.L_R_count(L_R_count),.R_L_count(R_L_count),.clk(clk),.neg(neg),.t_count(t_count));
    Time_count count_time(.qsec(qsec),.R(ResetTimer),.clk(clk),.time_bits(time_bits));
    
    //declare wires for output of ring_counter
    wire [3:0]sel_bits;
    
    //call instance of ring_counter
    ring_counter ring(.Advance(digsel),.clk(clk),.sel_bits(sel_bits));
    
    //declare wire to store input to selector
    wire [15:0]N;
    
    //assign value for selector input
    assign N = {time_bits,{4{1'b0}},t_count};
    
    //declare wire to store output of selector
    wire [3:0] H;
    
    //call instance of selector
    selector select(.sel(sel_bits),.N(N),.H(H));
    
    //declare wire to store converter output
    wire [6:0]convert_out;
    
    //call seg converter
    hex7seg convert(.n(H),.seg(convert_out));
    //hex7seg convert(.n(H),.seg(seg));
  
    //declare wire to store inverted conversion of seg outputs
    wire [6:0] convert_inverse;
    
    //assign convert inverse value
    assign convert_inverse = {~convert_out[6],~convert_out[5],~convert_out[4],~convert_out[3],~convert_out[2],~convert_out[1],~convert_out[0]};
    
    //declare wire to store logic for selecting to invert segment outputs
    wire sel_inv;
    
    //assign logic for sel_inverse 
    assign sel_inv = neg&sel_bits[2]&~sel_bits[3]&~sel_bits[1]&~sel_bits[0];
    
    //call mux to choose between true conversion vs inverted for our negative value
    m2_1x7 seg_mux(.in0(convert_out),.in1(convert_inverse),.sel(sel_inv),.o(seg));
    
    //assign an and led outputs
    assign an = {~(sel_bits[3]&(~ResetTimer)),~(sel_bits[2]&neg),~sel_bits[1],~sel_bits[0]};
    
    assign led[9] = R;
    assign led[15] = L;
    
endmodule
