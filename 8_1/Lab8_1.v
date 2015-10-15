`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:09:11 09/05/2015 
// Design Name: 
// Module Name:    Lab8_1 
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
module Lab8_1( clk,button_start_stop,display,display_ctl,button_lap,start_stop,lap,reset
    );
input clk,button_start_stop,button_lap;
output [14:0]display;
output [3:0]display_ctl;
output start_stop,lap,reset;
wire clk_out,clk_150;
wire [1:0]clk_ctl;
wire reset;
//start
wire pb_start;
wire fsm_start_in;
wire start_stop;
//lap
wire pb_lap;
wire fsm_lap_in;
wire lap;
//count
wire [4:0]cnt_h;
wire [3:0]tmp0,tmp1,tmp2,tmp3;
wire [3:0]scan_ctl_in0,scan_ctl_in1,scan_ctl_in2,scan_ctl_in3;
//display
wire [3:0]bcd;








freq_divider fd(
   .clk_out(clk_out), // divided clock output
	.clk_ctl(clk_ctl), // divided clock output for scan freq
	.clk_150(clk_150),
	.clk(clk), // global clock input
	.rst_n(1'b1), // active low reset
	.cnt_h(cnt_h)
	);
//start/stop	
debounce_start ds(
.clk(clk_150), // clock control
.rst_n(1'b1), // reset
.pb_in(button_start_stop), //push button input
.pb_debounced(pb_start) // debounced push button output
);
one_pluse_start ops(
.clk(clk), // clock input
.rst_n(reset), //active low reset
.in_trig(pb_start), // input trigger
.out_pulse(fsm_start_in) // output one pulse
);
fsm_start fsl(
  .rst(reset),
  .clk(clk),
  .sel_out(start_stop),
  .in(fsm_start_in)
    );
//lap
debounce_lap dl(
.clk(clk_150), // clock control
.rst_n(1'b1), // reset
.pb_in(button_lap), //push button input
.pb_debounced(pb_lap) // debounced push button output
);	
one_pluse_lap opl(
.clk(clk), // clock input
.rst_n(reset), //active low reset
.in_trig(pb_lap), // input trigger
.out_pulse(fsm_lap_in) // output one pulse
); 
fsm_lap fl(
  .rst(reset),
  .clk(clk),
  .sel_out(lap),
  .in(fsm_lap_in)
    );
reset( 
.clk(clk_out),
.in_trigger(~button_lap),
.reset_out(reset)
    );
//count
count( 
.clk(clk_out),
.start_stop(start_stop),
.out0(tmp0),
.out1(tmp1),
.out2(tmp2),
.out3(tmp3),
.rst(reset)
);
//display
scanf(
   .ftsd_ctl(display_ctl), // ftsd display control signal 
	.ftsd_in(bcd), // output to ftsd display
	.in0(scan_ctl_in0), // 1st input
	.in1(scan_ctl_in1), // 2nd input
	.in2(scan_ctl_in2), // 3rd input
	.in3(scan_ctl_in3), // 4th input
	.ftsd_ctl_en(clk_ctl) // divided clock for scan control
	);
bcd_d(
   .display(display), // 14-segment display output
	.bcd(bcd) // BCD input
	);
lap_function(
.clk(clk),
.lap(lap),
.rst_n(reset),
.in0(tmp0),
.in1(tmp1),
.in2(tmp2),
.in3(tmp3),
.out0(scan_ctl_in0),
.out1(scan_ctl_in1),
.out2(scan_ctl_in2),
.out3(scan_ctl_in3)
    );	
endmodule
