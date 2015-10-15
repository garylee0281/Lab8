`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:30:44 09/05/2015 
// Design Name: 
// Module Name:    lap_function 
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
module lap_function(clk,lap,rst_n,in0,in1,in2,in3,out0,out1,out2,out3
    );
input clk,rst_n,lap;
input [3:0]in0,in1,in2,in3;
output [3:0]out0,out1,out2,out3;
reg [3:0] tmp0,tmp1,tmp2,tmp3;
reg [3:0]out0,out1,out2,out3;
always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
		begin
			tmp0<=4'd0;
			tmp1<=4'd0;
			tmp2<=4'd0;
			tmp3<=4'd0;
		end
	else
		begin//ÅÜ°Ê­È
			tmp0<=in0;
			tmp1<=in1;
			tmp2<=in2;
			tmp3<=in3;
		end
end
always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
		begin
			out0<=4'd0;
			out1<=4'd0;
			out2<=4'd0;
			out3<=4'd0;
		end
	else
		begin//©T©w
			if(lap==1)
			begin
			out0<=out0;
			out1<=out1;
			out2<=out2;
			out3<=out3;
			end
			else
			begin
			out0<=tmp0;
			out1<=tmp1;
			out2<=tmp2;
			out3<=tmp3;	
			end
		end
end

endmodule
