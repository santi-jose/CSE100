`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/14/2020 08:01:51 AM
// Design Name: 
// Module Name: flash_logic
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


module an_logic(
    input qsec,
    input Flash_B,
    input Flash_A,
    input ShowNum,
    input [3:0]sel_bits,
    output [3:0] an
    );
    
    //declare wires to define anode values for flashing both and alternate
    wire [7:0]flash_B_values;
    wire [7:0]flash_A_values;
    
    //assign values for flash_B and flash_A values
    //~(sel_bits[3]&ShowNum),~(sel_bits[2]&ShowNum),~sel_bits[1],~sel_bits[0]
    assign flash_B_values = {1'b1,1'b1,1'b1,1'b1,~sel_bits[3],~sel_bits[2],~sel_bits[1],~sel_bits[0]};
    assign flash_A_values = {1'b1,1'b1,~sel_bits[1],~sel_bits[0],~sel_bits[3],~sel_bits[2],1'b1,1'b1};
    
    //declare bus to connect flash mux outputs to final mux
    wire [3:0]flash_B_mux_out;
    wire [3:0]flash_A_mux_out;
        
    //initialize muxes to show flashing both and alternating dependent on qsec    
    m2_1x4 Flash_B_mux(.in0(flash_B_values[3:0]),.in1(flash_B_values[7:4]),.sel(qsec),.o(flash_B_mux_out));
    m2_1x4 Flash_A_mux(.in0(flash_A_values[3:0]),.in1(flash_A_values[7:4]),.sel(qsec),.o(flash_A_mux_out)); 
    
    //declare wire to hold default an values,  ={4'b0}
    wire [3:0]default_an;
    
    //assign default_an;
    assign default_an = {~(sel_bits[3]&ShowNum),~(sel_bits[2]&ShowNum),~sel_bits[1],~sel_bits[0]};
    
    //create wire to hold select {Flash_B,Flash_A}
    wire [1:0]flash_sel;
    
    //assign flash_sel
    assign flash_sel = {Flash_B,Flash_A}; 
    
    //initialize mux to choose between regular anode display or flashing
    m4_1x4 Flash_mux(.in0(default_an),.in1(flash_A_mux_out),.in2(flash_B_mux_out),.in3(default_an),.sel(flash_sel),.o(an));
    
    
endmodule
