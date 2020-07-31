`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/18 13:52:42
// Design Name: 
// Module Name: Wave_Generator
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


module Wave_Generator(
    input clk,
    input RGB_VDE,
    input [11:0]x_pos,
    input [11:0]y_pos,
    input [5:0]apple_x,
    input [4:0]apple_y,
    input [5:0]head_x,
    input [5:0]head_y,
    input [1:0]snake,        //定义颜色状态
    input [1:0]status,
	input [3:0]ready_flash,
	input [1:0] key_state,
    output reg[23:0]color_out=0    //RBG
    );
	reg [19:0]clk_cnt;

	
	localparam NONE = 2'b00;
	localparam HEAD = 2'b01;
	localparam BODY = 2'b10;
	localparam WALL = 2'b11;
	
	localparam HEAD_COLOR = 24'h00ff00;
	localparam BODY_COLOR = 24'h00ffff;
	
	
	reg [3:0]lox;
	reg [3:0]loy;
	
	parameter 
char_line0=192'h0000000000080000000000, 
char_line1=192'h00600000000E0000000000, 
char_line2=192'h0040000000080000000000, 
char_line3=192'h0040000000080000000000, 
char_line4=192'h3C7C3C7F00081C7F773C3B, 
char_line5=192'h42424292000822924C4246, 
char_line6=192'h4242429200083092044242, 
char_line7=192'h7E42429200082C92044242,
char_line8=192'h0242429200082292044242,
char_line9=192'h4262429200083292044242,
char_line10=192'h3CDC3CB7003E6CB71F3CE7;

reg [7:0]x_dis;
reg [7:0]y_dis;
reg [2:0]x_dis2;
reg [2:0]y_dis2;
parameter 
char_line00=192'h00600000000000000000, 
char_line01=192'h00600000000000000000,
char_line02=192'h00600000000000000000,
char_line03=192'h00400000000000000000,
char_line04=192'h00400000000000000000,
char_line05=192'h3C7C3C7F00E77E1C7738,
char_line06=192'h42424292004222224C44, 
char_line07=192'h42424292002410300402,
char_line08=192'h7E4242920024082C0402,
char_line09=192'h02424292001808220402,
char_line010=192'h42624292001844320444,
char_line011=192'h3CDC3CB700087E6C1F38,
char_line012=192'h00000000000800000000, 
char_line013=192'h00000000000600000000;

    reg [13:0]Address=0;
    wire [7:0]R_apple;
    wire [7:0]G_apple;
    wire [7:0]B_apple;
    
    wire [7:0]R_snake;
    wire [7:0]G_snake;
    wire [7:0]B_snake;
    
    wire [7:0]R_body;
    wire [7:0]G_body;
    wire [7:0]B_body;
		
	always@(*)
    begin
    if(status==2)begin
 if(y_pos>=0&&y_pos<960&&x_pos>=0&&x_pos<1280) begin
                if(x_pos[10:5] == apple_x && y_pos[10:5]== apple_y)
                    begin
                               
                          Address=(x_pos-apple_x*32+3)*32+(y_pos-apple_y*32+1);
                                //set_x里加代表左移
                          color_out<={R_apple,B_apple,G_apple};
                           
                    end
                    //RGB_Data<=24'h0000ff;
                else if(x_pos[10:5] == head_x && y_pos[10:5]== head_y)
                    begin
                    //RGB_Data<=24'hff00ff;
                    Address=(x_pos-head_x*32+1)*32+(y_pos-head_y*32+1);
                    color_out<={R_snake,B_snake,G_snake};
                    end
                else if(snake==NONE)
                    color_out<=24'hffffff;
                else if(snake==WALL)
                    color_out<=24'hff00ff;
                
                else if(snake==BODY)
                    begin
                    //RGB_Data<=24'h00fff00;
                    Address=(x_pos)*32+(y_pos);    
                    color_out<={R_body,B_body,G_body};  
                    end         
                else
                    color_out<=24'hffffff;
                end
            else
                color_out<=24'h000000;
		end
else if(status==0)
begin
			case(key_state)			
				2'b00:	begin
		 if(x_pos>=12'd256&&x_pos<12'd1664&&y_pos>=12'd320&&y_pos<12'd408) begin
            x_dis =(x_pos - 10'd256)>>3;
	        y_dis =(y_pos - 10'd320)>>3;
            case(y_dis)
                8'd0: if(char_line0[x_dis]) color_out <= 24'hffffff;		
                         else color_out <=24'hc95637;	
                8'd1:  if(char_line1[x_dis]) color_out <= 24'hffffff;		
                         else color_out <=24'hc95637;
                8'd2: if(char_line2[x_dis]) color_out <= 24'hffffff;		
                         else color_out <=24'hc95637; 
                8'd3:  if(char_line3[x_dis]) color_out <= 24'hffffff;		
                         else color_out <=24'hc95637;
                8'd4:  if(char_line4[x_dis]) color_out <= 24'hffffff;		
                         else color_out <=24'hc95637; 
                8'd5:  if(char_line5[x_dis]) color_out <= 24'hffffff;		
                         else color_out <=24'hc95637;  
                8'd6: if(char_line6[x_dis]) color_out <= 24'hffffff;		
                         else color_out <=24'hc95637;   
                8'd7: if(char_line7[x_dis]) color_out <= 24'hffffff;		
                         else color_out <=24'hc95637;  
                8'd8: if(char_line8[x_dis]) color_out <= 24'hffffff;		
                         else color_out <=24'hc95637;     
                8'd9: if(char_line9[x_dis]) color_out <= 24'hffffff;		
                         else color_out <=24'hc95637;    
                8'd10: if(char_line10[x_dis])color_out <= 24'hffffff;		
                         else color_out <=24'hc95637;
   		
                		
            default: color_out <=24'hdb6b5a;
            endcase
        end
        else if(x_pos>=12'd256&&x_pos<12'd1664&&y_pos>=12'd576&&y_pos<12'd688) begin
            x_dis =(x_pos - 10'd320)>>3;
	        y_dis =(y_pos - 10'd576)>>3;
            case(y_dis)
                8'd0: if(char_line00[x_dis]) color_out <= 24'h000000;		
                         else color_out <=24'hdb6b5a;	
                8'd1:  if(char_line01[x_dis]) color_out <= 24'h000000;		
                         else color_out <=24'hdb6b5a;
                8'd2: if(char_line02[x_dis])  color_out <= 24'h000000;		
                         else color_out <=24'hdb6b5a;
                8'd3:  if(char_line03[x_dis]) color_out <= 24'h000000;		
                         else color_out <=24'hdb6b5a;
                8'd4:  if(char_line04[x_dis]) color_out <= 24'h000000;		
                         else color_out <=24'hdb6b5a; 
                8'd5:  if(char_line05[x_dis]) color_out <= 24'h000000;		
                         else color_out <=24'hdb6b5a; 
                8'd6: if(char_line06[x_dis]) color_out <= 24'h000000;		
                         else color_out <=24'hdb6b5a;  
                8'd7: if(char_line07[x_dis]) color_out <= 24'h000000;		
                         else color_out <=24'hdb6b5a;
                8'd8: if(char_line08[x_dis]) color_out <= 24'h000000;		
                         else color_out <=24'hdb6b5a;    
                8'd9: if(char_line09[x_dis]) color_out <= 24'h000000;		
                         else color_out <=24'hdb6b5a;   
                8'd10: if(char_line010[x_dis])color_out <= 24'h000000;		
                         else color_out <=24'hdb6b5a;
                8'd11: if(char_line011[x_dis]) color_out <= 24'h000000;		
                         else color_out <=24'hdb6b5a; 		
                8'd12: if(char_line012[x_dis])color_out <= 24'h000000;		
                         else color_out <=24'hdb6b5a;	
                8'd13: if(char_line013[x_dis]) color_out <= 24'h000000;		
                         else color_out <=24'hdb6b5a;
            default: color_out <=24'hdb6b5a;
            endcase
            end
        else color_out <=24'hdb6b5a;
		end		
				2'b01:   
				begin
				
						 if(x_pos>=12'd256&&x_pos<12'd1664&&y_pos>=12'd320&&y_pos<12'd408) begin
            x_dis =(x_pos - 10'd256)>>3;
	        y_dis =(y_pos - 10'd320)>>3;
            case(y_dis)
                8'd0: if(char_line0[x_dis]) color_out <= 24'h000000;		
                         else color_out <=24'hdb6b5a;	
                8'd1:  if(char_line1[x_dis]) color_out <= 24'h000000;		
                         else color_out <=24'hdb6b5a;
                8'd2: if(char_line2[x_dis]) color_out <= 24'h000000;		
                         else color_out <=24'hdb6b5a; 
                8'd3:  if(char_line3[x_dis]) color_out <= 24'h000000;		
                         else color_out <=24'hdb6b5a;
                8'd4:  if(char_line4[x_dis]) color_out <= 24'h000000;		
                         else color_out <=24'hdb6b5a; 
                8'd5:  if(char_line5[x_dis]) color_out <= 24'h000000;		
                         else color_out <=24'hdb6b5a;  
                8'd6: if(char_line6[x_dis]) color_out <= 24'h000000;		
                         else color_out <=24'hdb6b5a;   
                8'd7: if(char_line7[x_dis]) color_out <= 24'h000000;		
                         else color_out <=24'hdb6b5a;  
                8'd8: if(char_line8[x_dis]) color_out <= 24'h000000;		
                         else color_out <=24'hdb6b5a;     
                8'd9: if(char_line9[x_dis]) color_out <= 24'h000000;		
                         else color_out <=24'hdb6b5a;    
                8'd10: if(char_line10[x_dis])color_out <= 24'h000000;		
                         else color_out <=24'hdb6b5a;		
                		
            default: color_out <=24'hdb6b5a;
            endcase
        end
        else if(x_pos>=12'd256&&x_pos<12'd1664&&y_pos>=12'd576&&y_pos<12'd688) begin
            x_dis =(x_pos - 10'd320)>>3;
	        y_dis =(y_pos - 10'd576)>>3;
            case(y_dis)
                8'd0: if(char_line00[x_dis]) color_out <= 24'hffffff;		
                         else color_out <=24'hc95637;
                8'd1:  if(char_line01[x_dis])color_out <= 24'hffffff;		
                         else color_out <=24'hc95637;
                8'd2: if(char_line02[x_dis]) color_out <= 24'hffffff;		
                         else color_out <=24'hc95637;
                8'd3:  if(char_line03[x_dis]) color_out <= 24'hffffff;		
                         else color_out <=24'hc95637;
                8'd4:  if(char_line04[x_dis]) color_out <= 24'hffffff;		
                         else color_out <=24'hc95637;
                8'd5:  if(char_line05[x_dis]) color_out <= 24'hffffff;		
                         else color_out <=24'hc95637;
                8'd6: if(char_line06[x_dis]) color_out <= 24'hffffff;		
                         else color_out <=24'hc95637;
                8'd7: if(char_line07[x_dis]) color_out <= 24'hffffff;		
                         else color_out <=24'hc95637;
                8'd8: if(char_line08[x_dis]) color_out <= 24'hffffff;		
                         else color_out <=24'hc95637;  
                8'd9: if(char_line09[x_dis]) color_out <= 24'hffffff;		
                         else color_out <=24'hc95637; 
                8'd10: if(char_line010[x_dis])color_out <= 24'hffffff;		
                         else color_out <=24'hc95637;
                8'd11: if(char_line011[x_dis])color_out <= 24'hffffff;		
                         else color_out <=24'hc95637;	
                8'd12: if(char_line012[x_dis])color_out <= 24'hffffff;		
                         else color_out <=24'hc95637;
                8'd13: if(char_line013[x_dis])color_out <= 24'hffffff;		
                         else color_out <=24'hc95637;
            default: color_out <=24'hdb6b5a;
            endcase
         end
        else color_out <=24'hdb6b5a;
		end		

			endcase	
end






else if(status==1)
begin
x_dis2 =(x_pos[10:8] > 5) ? 5 :x_pos[10:8];
y_dis2 =(y_pos [10:8] > 3) ? 3 :y_pos[10:8];

			case(ready_flash)			
				8'b000:
				 begin
	             if(x_dis2==0 && y_dis2== 0)
                  color_out <= 24'hf870df;
                 else color_out <= 24'hdb6b5a;
				end
				8'b001:
				begin
	             if(x_dis2==0 && y_dis2== 0)
                  color_out <= 24'h8c69c2;
                 else if((x_dis2+y_dis2)<=2)color_out <= 24'hf870df;
                 else color_out <= 24'hdb6b5a;
				end
				8'b010:
				begin
				if(x_dis2==0 && y_dis2== 0)
                  color_out <= 24'hbaccd9;
                 else if((x_dis2+y_dis2)<=2)color_out <= 24'h8c69c2;
                 else if((x_dis2+y_dis2)<=4)color_out <= 24'hf870df;
                 else color_out <= 24'hdb6b5a;
				end
				8'b011:				
				begin
				if(x_dis2==0 && y_dis2== 0)
                  color_out <= 24'hffffff;
                 else if((x_dis2+y_dis2)<=2)color_out <= 24'hbaccd9;
                 else if((x_dis2+y_dis2)<=4)color_out <= 24'h8c69c2;
                 else if((x_dis2+y_dis2)<=6)color_out <= 24'hf870df;
                 else color_out <= 24'hdb6b5a;
				end
				8'b100:
				begin
				if((x_dis2+y_dis2)<=2)
                  color_out <= 24'hffffff;
                 else if((x_dis2+y_dis2)<=4)color_out <= 24'hbaccd9;
                 else if((x_dis2+y_dis2)<=6)color_out <= 24'h8c69c2;
                 else if((x_dis2+y_dis2)<=8)color_out <= 24'hf870df;
                 else color_out <= 24'hdb6b5a;
				end				
				8'b101:
				begin
				if((x_dis2+y_dis2)<=4)
                  color_out <= 24'hffffff;
                 else if((x_dis2+y_dis2)<=6)color_out <= 24'hbaccd9;
                 else if((x_dis2+y_dis2)<=8)color_out <= 24'h8c69c2;
                 else color_out <= 24'hdb6b5a;
				end	
				8'b110:
				begin
				if((x_dis2+y_dis2)<=6)
                  color_out = 24'hffffff;
                 else if((x_dis2+y_dis2)<=8)color_out <= 24'hbaccd9;
                 else color_out <= 24'hdb6b5a;
				end	
				8'b111:color_out <= 24'hffffff;
			endcase	
end
else  
 color_out <=24'hffffff;
end



     apple_R R_ROM (
             .clka(clk),    // input wire clka
             .ena(1),      // input wire ena
             .addra(Address),  // input wire [13 : 0] addra
             .douta(R_apple)  // output wire [7 : 0] douta
           );
     apple_B B_ROM (
            .clka(clk),    // input wire clka
            .ena(1),      // input wire ena
            .addra(Address),  // input wire [13 : 0] addra
            .douta(B_apple)  // output wire [7 : 0] douta
                      );
      apple_G G_ROM (
              .clka(clk),    // input wire clka
              .ena(1),      // input wire ena
              .addra(Address),  // input wire [13 : 0] addra
              .douta(G_apple)  // output wire [7 : 0] douta
                        );
                        
      snake_R R_ROM2 (
             .clka(clk),    // input wire clka
             .ena(1),      // input wire ena
             .addra(Address),  // input wire [13 : 0] addra
             .douta(R_snake)  // output wire [7 : 0] douta
                   );
      snake_B B_ROM2 (
             .clka(clk),    // input wire clka
             .ena(1),      // input wire ena
             .addra(Address),  // input wire [13 : 0] addra
             .douta(B_snake)  // output wire [7 : 0] douta
                       );
      snake_G G_ROM2 (
              .clka(clk),    // input wire clka
              .ena(1),      // input wire ena
              .addra(Address),  // input wire [13 : 0] addra
              .douta(G_snake)  // output wire [7 : 0] douta
                        );
       body_R R_ROM3 (
                .clka(clk),    // input wire clka
                .ena(1),      // input wire ena
                .addra(Address),  // input wire [13 : 0] addra
                .douta(R_body)  // output wire [7 : 0] douta
                      );
         body_B B_ROM3 (
                .clka(clk),    // input wire clka
                .ena(1),      // input wire ena
                .addra(Address),  // input wire [13 : 0] addra
                .douta(B_body)  // output wire [7 : 0] douta
                          );
         body_G G_ROM3 (
                 .clka(clk),    // input wire clka
                 .ena(1),      // input wire ena
                 .addra(Address),  // input wire [13 : 0] addra
                 .douta(G_body)  // output wire [7 : 0] douta
                           );

endmodule
