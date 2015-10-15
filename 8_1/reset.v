`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:41:15 08/26/2015 
// Design Name: 
// Module Name:    reset 
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
module reset( clk,in_trigger,reset_out
    );
input clk;
input in_trigger;
output reset_out;
reg in_trigger_delay;
reg reset_out;
wire rest_tmp;
always @(*)
begin
in_trigger_delay<=in_trigger;
end
assign rest_tmp= ~((in_trigger)&(in_trigger_delay));
always @(posedge clk)
begin
reset_out <= rest_tmp;
end
endmodule
