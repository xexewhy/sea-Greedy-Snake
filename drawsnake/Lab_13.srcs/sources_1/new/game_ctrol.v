`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/31 11:18:01
// Design Name: 
// Module Name: game_ctrol
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


module game_ctrol(
input clk,
	input rst,
	input key1_press,//вС
	input key2_press,//ср
	input key3_press,//ио
	input key4_press,//об
	output reg [1:0]status,
	output reg [3:0]ready_flash,
	output reg game_en,
	output reg[1:0]key_state,
	input restart		
);
	
	localparam START = 2'b00;
	localparam READY = 2'b01;
	localparam PLAY= 2'b10;
	
	reg[31:0]clk_cnt;
	
	always@(posedge clk or negedge rst)
	begin
		if(!rst) begin
			status <= START;
			clk_cnt <= 0;
			key_state <= 0;
			game_en<=0;
			//restart <= 0;
		end
		else begin
			case(status)			
				START:begin
				game_en<=0;
				ready_flash <= 4'd0;
				if(key4_press&&key_state==0)
				    begin
						key_state <= 1;
						status <= START;
						
					end
				if(key3_press&&key_state==1)
				    begin
						key_state <= 0;
						status <= START;
						
					end
				if(key2_press&&key_state==0)
				    begin
						
						key_state <= 2;
						clk_cnt <= 0;
						status <= READY;
					end
				if(key2_press&&key_state==1)
				    begin
						
						key_state <= 3;
						clk_cnt <= 0;
						status <= READY;
					end
				end
				READY:begin
				    game_en<=0;
					if(clk_cnt <= 800_000_000) begin
						clk_cnt <= clk_cnt + 1'b1;
						status <=READY;
					   if(clk_cnt <= 100_000_000)
					       ready_flash <= 4'd0;
					   else if(clk_cnt <= 200_000_000)
					       ready_flash <= 4'd1;
					   else if(clk_cnt <= 300_000_000)
					       ready_flash <= 4'd2;
					   else if(clk_cnt <= 400_000_000)
					       ready_flash <= 4'd3;
					   else if(clk_cnt <= 500_000_000)
					       ready_flash<= 4'd4;
					   else if(clk_cnt <= 600_000_000)
					       ready_flash<= 4'd5;
					   else if(clk_cnt <= 700_000_000)
					       ready_flash<= 4'd6;
					   else
                            begin
                                ready_flash<= 4'd7;
                            end
						end
					else 
					begin
		          	if(key_state == 2|key_state == 3)status <= PLAY;
					else status <=START;
					end
				end

				PLAY:begin
				    game_en<=1;
					if(restart)
					begin
					   status <= START;
					   key_state<=0;
					end
					else status <= PLAY;
				end					
				
			endcase
		end
	end


endmodule
