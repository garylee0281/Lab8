`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:42:08 08/13/2015 
// Design Name: 
// Module Name:    counter 
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
`define zero 1'b0
module count( clk,start_stop,out0,out1,out2,out3,rst
);
input clk ,start_stop,rst;
output [3:0]out0,out1,out2,out3;
reg [3:0]temp0,temp1,temp2,temp3;
reg [3:0]out0,out1,out2,out3;
//reg a,b,c,d;
//reg counter_flag;

always@(posedge clk or negedge rst)
begin
if(~rst)
begin
temp0<=4'd0;
temp1<=4'd0;
temp2<=4'd0;//m
temp3<=4'd0;//s
//counter_flag<=0;
end
	else
	begin
	if(start_stop==1)
		begin
			if(temp3>=4'd9)
			begin
			temp3<=4'd0;
			temp2<=temp2+4'd1;
				if(temp3>=4'd9&&temp2>=4'd5)
				begin
					temp3<=4'd0;
					temp2<=4'd0;
					temp1<=temp1+4'd1;
						if(temp3>=4'd9&&temp2>=4'd5&&temp1>=4'd9)
						begin
							temp3<=4'd0;
							temp2<=4'd0;
							temp1<=4'd0;
							temp0<=temp0+4'd1;
						end
						else
						begin
						end
				end
				else
				begin
				end
			end
			/*else if(temp3>=4'd9&&temp2>=4'd5)
			begin
			temp3<=4'd0;
			temp2<=4'd0;
			temp1<=temp1+4'd1;
			end*/
			/*else if(temp3>=4'd9&&temp2>=4'd5&&temp1>=4'd9)
			begin
			temp3<=4'd0;
			temp2<=4'd0;
			temp1<=4'd0;
			temp0<=temp0+4'd1;
			end*/
			else
			begin
			temp3<=temp3+4'd1;
			end
		end
	/*else if(sel_in==0&&counter_flag==0)
		begin
		temp3<=in3;
		temp2<=in2;
		temp1<=in1;
		temp0<=in0;
		end*/
	else if(start_stop==0)
		begin
		temp3<=temp3;
		temp2<=temp2;
		temp1<=temp1;
		temp0<=temp0;
		end
	else
		begin
		end
	end			
end

always@(posedge clk or negedge rst)
begin
	if(~rst)
	begin
	out0<=4'd0;
	out1<=4'd0;
	out2<=4'd0;
	out3<=4'd0;
	end
	else
	begin
	out0<=temp0;
	out1<=temp1;
	out2<=temp2;
	out3<=temp3;
	end
end
endmodule
