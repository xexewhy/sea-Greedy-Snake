`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/18 13:37:19
// Design Name: 
// Module Name: ADC_Demo
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

//This is an example program for an ADC that displays the waveform read by the ADC pin through the display.
module Lab_13(
    input clk_100MHz,
    input data_rx,
    input rst,
    output [1:0]led,
    output TMDS_Tx_Clk_N,
    output TMDS_Tx_Clk_P, 
    output [2:0]TMDS_Tx_Data_N,
    output [2:0]TMDS_Tx_Data_P
    );
    wire clk_100MHz_system;
    wire clk_system;
    wire [23:0]RGB_Data;
    wire [23:0]RGB_In;
    wire RGB_HSync;
    wire RGB_VSync;
    wire RGB_VDE;
    wire [11:0]Set_X;
    wire [11:0]Set_Y;
    
    wire left_key_press;
    wire right_key_press;
    wire up_key_press;
    wire down_key_press;
    wire [1:0]color_state;
    
    wire[1:0]game_status;
    wire hit_wall;
    wire hit_body;
    wire die_flash;
    wire restart;
    
    wire [5:0]apple_x;
    wire [4:0]apple_y;
    wire [5:0]head_x;
    wire [5:0]head_y;  
    wire add_cube;    
   
    wire[1:0] status;
	wire[3:0] ready_flash;
	wire[1:0]key_state;
	wire game_en;
    clk_wiz_0 clk_10(.clk_out1(clk_system),.clk_out2(clk_100MHz_system),.clk_in1(clk_100MHz));
    
    //RGBToDvi instantiation
    rgb2dvi_0 rgb2dvi(
        .TMDS_Clk_p(TMDS_Tx_Clk_P),
        .TMDS_Clk_n(TMDS_Tx_Clk_N),
        .TMDS_Data_p(TMDS_Tx_Data_P),
        .TMDS_Data_n(TMDS_Tx_Data_N),
        .aRst_n(1),
        .vid_pData(RGB_Data),
        .vid_pVDE(RGB_VDE),
        .vid_pHSync(RGB_HSync),
        .vid_pVSync(RGB_VSync),
        .PixelClk(clk_system));
    //Video production
    Driver_HDMI_0 Driver_HDMI0(
        .clk(clk_system),        //Clock
        .Rst(1),                 //Reset signal, low reset
        .Video_Mode(0),          //Video format
        .RGB_In(RGB_In),         //Input data
        .RGB_Data(RGB_Data),     //Output data
        .RGB_HSync(RGB_HSync),   //Line signal
        .RGB_VSync(RGB_VSync),   //Field signal
        .RGB_VDE(RGB_VDE),       //Data valid signal
        .Set_X(Set_X),           //Image coordinate X
        .Set_Y(Set_Y)            //Image coordinate Y
        );
     //游戏规则控制
       Game_Ctrl_Unit U1 (
           .clk(clk_system),
           .rst(game_en),
           .key1_press(left_key_press),
           .key2_press(right_key_press),
           .key3_press(up_key_press),
           .key4_press(down_key_press),
           .game_status(game_status),
           .hit_wall(hit_wall),
           .hit_body(hit_body),
           .die_flash(die_flash),
           .restart(restart)        
       );   
    //苹果产生控制模块
   Snake_Eatting_Apple U2 (
       .clk(clk_system),
       .rst(game_en),
       .apple_x(apple_x),
       .apple_y(apple_y),
       .head_x(head_x),
       .head_y(head_y),
       .add_cube(add_cube)    
   ); 
   	move U3 (
        .clk(clk_system),
        .rst(game_en),
        .left_press(left_key_press),
        .right_press(right_key_press),
        .up_press(up_key_press),
        .down_press(down_key_press),
        .snake(color_state),
        .x_pos(Set_X),
        .y_pos(Set_Y),      //扫描坐标
        .head_x(head_x),
        .head_y(head_y),
        .add_cube(add_cube),
        .game_status(game_status),
        //.cube_num(cube_num),
        .hit_body(hit_body),
        .hit_wall(hit_wall),
        .key_state(key_state),
        .die_flash(die_flash)
        );
    blue U5 (
        .clk(clk_100MHz_system),
        .i_rst(rst),
        .data_rx(data_rx),
        .left_key_press(left_key_press),
        .right_key_press(right_key_press),
        .up_key_press(up_key_press),
        .down_key_press(down_key_press),
        .restart(restart),
        .led(led)        
            );
    Wave_Generator U6(
        .clk(clk_system),
        .RGB_VDE(RGB_VDE),      
        .x_pos(Set_X),
        .y_pos(Set_Y),
        .apple_x(apple_x),
        .apple_y(apple_y),
        .head_x(head_x),
        .head_y(head_y),
        .snake(color_state),
        .status(status),             
         .ready_flash(ready_flash),
    	.key_state(key_state),
        .color_out(RGB_In)    //方格颜色
        );
     game_ctrol  U7(	
        .clk(clk_system),
	    .rst(rst),
	    .key1_press(left_key_press),
	    .key2_press(right_key_press),
	    .key3_press(up_key_press),
	    .key4_press(down_key_press),
	    .restart(restart),
	     .status(status),
	     .ready_flash(ready_flash),
	     .game_en(game_en),
	     .key_state(key_state)
		
);
endmodule
