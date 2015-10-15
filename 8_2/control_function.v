`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:51:21 09/05/2015 
// Design Name: 
// Module Name:    control_function 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module control_function(clk,reset,switch_setting,hr_control,min_control,out0,out1,out2,out3,fast_clk
    );
input fast_clk;
input clk,reset,switch_setting,hr_control,min_control;
output [3:0]out0,out1,out2,out3;
reg [3:0]out0,out1,out2,out3;
reg[3:0]hr_t,hr_s,min_t,min_s;
always@(posedge clk or negedge reset)
begin
	if(~reset)
	begin
		hr_t<=4'd0;
		hr_s<=4'd0;
		min_t<=4'd0;
		min_s<=4'd0;
	end
	else
	begin
		if(switch_setting==1)
			begin
				if(min_control==1&&hr_control==0)
					begin
						if(min_s>=4'd9)
						begin
							if(min_s>=4'd9&&min_t>=4'd5)
								begin
									if(min_s>=4'd9&&min_t>=4'd5&&hr_s>=4'd9)
										begin
											
												min_s<=4'd0;
												min_t<=4'd0;
												hr_s<=4'd0;
												hr_t<=hr_t+4'd1;
												
										end
									else
										begin
										if(min_s>=4'd9&&min_t>=4'd5&&hr_s>=4'd3&&hr_t>=4'd2)
												begin
												min_s<=4'd0;
												min_t<=4'd0;
												hr_s<=4'd0;
												hr_t<=4'd0;
												end
											else
												begin
												min_s<=4'd0;
												min_t<=4'd0;
												hr_s<=hr_s+4'd1;
												end
										end
								end
							else
								begin
									min_s<=4'd0;
									min_t<=min_t+4'd1;
								end
						end
						else
						begin
							min_s<=min_s+4'd1;
						end
					end
				else if(min_control==0&&hr_control==1)//control hr
					begin
						if(hr_s>=4'd9)
						begin
							
							
								hr_s<=4'd0;
								hr_t<=hr_t+4'd1;
						
						end
						else
						begin
							if(hr_s>=4'd3&&hr_t>=4'd2)
							begin
								hr_s<=4'd0;
								hr_t<=4'd0;
							end
							else
							begin
								hr_s<=hr_s+4'd1;
							end
						end
					end
				else
					begin
						hr_t<=hr_t;
						hr_s<=hr_s;
						min_t<=min_t;
						min_s<=min_s;
					end
			end
		else
			begin
				hr_t<=hr_t;
				hr_s<=hr_s;
				min_t<=min_t;
				min_s<=min_s;
			end
	end
end

always@(posedge fast_clk or negedge reset)
begin
	if(~reset)
	begin
		out0<=4'd0;
		out1<=4'd0;
		out2<=4'd0;
		out3<=4'd0;
	end
	else
	begin
		out0<=hr_t;
		out1<=hr_s;
		out2<=min_t;
		out3<=min_s;
	end
end




endmodule