
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/27 12:08:02
// Design Name: 
// Module Name: blue
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


module blue(
    input clk,
    input i_rst,
	input data_rx,
	input restart,
    output left_key_press,
    output right_key_press,
    output up_key_press,
    output down_key_press,
    output [1:0]led

    );
    reg rx_int;
    reg [12:0]cnt_bps;
	reg bps_start;
    parameter bps_t = 20'd10416;  
    wire rst_n;
    assign  rst_n=~i_rst;                      //传输1bit所需计数值 
    always @(posedge clk or negedge rst_n or	negedge	 restart)
    begin
       if(rst_n) 
          cnt_bps <= 13'd0;
       else if(restart) 
          cnt_bps <= 13'd0;
       else if(cnt_bps == bps_t) 
          cnt_bps <= 13'd0;
       else if(bps_start) 
          cnt_bps <= cnt_bps + 1'b1;
       else 
          cnt_bps <= 1'b0;
    end
    wire bps_sig;
    assign bps_sig = (cnt_bps ==  20'd5208) ? 1'b1 : 1'b0;  //将采集数据的时刻放在波特率计数器每次循环计数的中间位置
	
	reg	[1:0]	rx;
	always @(posedge	clk	or	negedge	rst_n or	negedge	 restart)begin
		if(rst_n)	rx <= 2'b11;
		else if(restart) 
          rx <= 2'b11;
		else begin
			rx[0]	<=	data_rx;
			rx[1]	<=	rx[0];
		end
	end
	wire nege_edge;
	assign nege_edge= rx[1]	& ~rx[0];						//检测下降沿

	reg	[3:0]num;	
	always@(posedge	clk	or	negedge 	rst_n 	or	negedge	 restart )begin
		if(rst_n)	begin	
			bps_start <= 1'b0;	
			rx_int <= 1'b0;
		end
		else if(restart) 
          begin	
			bps_start <= 1'b0;	
			rx_int <= 1'b0;
		end
		else if(nege_edge)begin
			bps_start <= 1'b1;
			rx_int <= 1'b1;
		end
		else if(num == 4'd9)begin
			bps_start <= 1'b0;	
			rx_int <= 1'b0;
		end
	end

	reg	[7:0]	rx_data_temp_r;								//当前数据接收寄存器
	reg	[7:0]	rx_data_r;									//用来锁存数据
	always@(posedge	clk	or	negedge	rst_n or	negedge	 restart)begin
		if(rst_n)	begin	
			rx_data_r	<= 8'd0;
			rx_data_temp_r	<= 8'd0;
			num <= 4'd0;
			end
		else if(restart) 
          begin	
			rx_data_r	<= 8'd0;
			rx_data_temp_r	<= 8'd0;
			num <= 4'd0;
		end
		else if(rx_int) begin
			if(bps_sig) begin
				num <= num + 1'b1;
				case(num)
					4'd1: rx_data_temp_r[0] <= data_rx;		//锁存第0bit
					4'd2: rx_data_temp_r[1] <= data_rx;		//锁存第1bit
					4'd3: rx_data_temp_r[2] <= data_rx;		//锁存第2bit
					4'd4: rx_data_temp_r[3] <= data_rx;		//锁存第3bit
					4'd5: rx_data_temp_r[4] <= data_rx;		//锁存第4bit
					4'd6: rx_data_temp_r[5] <= data_rx;		//锁存第5bit
					4'd7: rx_data_temp_r[6] <= data_rx;		//锁存第6bit
					4'd8: rx_data_temp_r[7] <= data_rx;		//锁存第7bit
					default: ;
				endcase
			end
			else if(num == 4'd9)begin
				rx_data_r <= rx_data_temp_r;
				num <= 4'd0;
			end
		end
	end


	//assign	data_tx = rx_data_r;							
    assign left_key_press=~rx_data_r[0]&&~rx_data_r[1];
    assign right_key_press=rx_data_r[0]&&~rx_data_r[1];
    assign up_key_press=~rx_data_r[0]&&rx_data_r[1];
    assign down_key_press=rx_data_r[0]&&rx_data_r[1];
    assign led[0]=rx_data_r[0];
    assign led[1]=rx_data_r[1];
	
	
endmodule
