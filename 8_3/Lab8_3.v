`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:34:35 09/06/2015 
// Design Name: 
// Module Name:    Lab8_3 
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
module Lab8_3(
   clk,reset,button_hr_min,button_start_stop,button_pause_resume,display,display_ctl,LED
    );
input clk,reset;
input button_hr_min;
input button_start_stop,button_pause_resume;
output [14:0]display;
output [3:0]display_ctl;
output [15:0]LED;
//output hr_control,min_control;
wire clk_out,clk_150;
wire [1:0]clk_ctl;
//wire [4:0]cnt_h;
//hr
wire pb_hr_min;
wire fsm_hr_min_in;
wire [1:0]hr_min_control;
//min
/*wire pb_min;
wire fsm_min_in;
wire min_control;*/
//start_stop
wire pb_start_stop;
wire fsm_start_stop_in;
wire [1:0]start_stop;//S0:setting
//pause_resume
wire pb_pause_resume;
wire fsm_pause_resume_in;
wire pause_resume;
//display
wire [3:0]hr_ttmp,hr_stmp,min_ttmp,min_stmp;
wire [3:0]bcd;
reg [3:0]out0,out1,out2,out3;
//countdown
wire [3:0]hr_t,hr_s,min_t,min_s;

always@(posedge clk or negedge reset)
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
		if(pause_resume==0&&start_stop!=2'b00)
		begin
			out0<=hr_t;
			out1<=hr_s;
			out2<=min_t;
			out3<=min_s;
		end
		else if (pause_resume==1&&start_stop!=2'b00)
		begin
			out0<=out0;
			out1<=out1;
			out2<=out2;
			out3<=out3;
		end
		else
		begin
			out0<=hr_ttmp;
			out1<=hr_stmp;
			out2<=min_ttmp;
			out3<=min_stmp;
		end
	end
end

freq_divider(
   .clk_out(clk_out), // divided clock output
	.clk_ctl(clk_ctl), // divided clock output for scan freq
	.clk_150(clk_150),
	.clk(clk), // global clock input
	.rst_n(reset)	// active low reset
	//.cnt_h(cnt_h)
	);
//hr
debounce_hr dh(
.clk(clk_150), // clock control
.rst_n(reset), // reset
.pb_in(button_hr_min), //push button input
.pb_debounced(pb_hr_min) // debounced push button output
);	
one_pluse_hr oph(
.clk(clk), // clock input
.rst_n(reset), //active low reset
.in_trig(pb_hr_min), // input trigger
.out_pulse(fsm_hr_min_in) // output one pulse
);
fsm_hr fh(
  .rst(reset),
  .clk(clk),
  .sel_out(hr_min_control),
  .in(fsm_hr_min_in)
    );
//min
/*debounce_min dm(
.clk(clk_150), // clock control
.rst_n(reset), // reset
.pb_in(button_min), //push button input
.pb_debounced(pb_min) // debounced push button output
); 
one_pluse_min opm(
.clk(clk), // clock input
.rst_n(reset), //active low reset
.in_trig(pb_min), // input trigger
.out_pulse(fsm_min_in) // output one pulse
);
fsm_min(
  .rst(reset),
  .clk(clk),
  .sel_out(min_control),
  .in(fsm_min_in)
    );*/
//control
control_function(
.clk(clk_out),
.reset(reset),
.switch_setting(start_stop),
.hr_control(hr_min_control),
//.min_control(min_control),
.out0(hr_ttmp),
.out1(hr_stmp),
.out2(min_ttmp),
.out3(min_stmp),
.fast_clk(clk)
    );
//start_stop
debounce_start_stop(
.clk(clk_150), // clock control
.rst_n(reset), // reset
.pb_in(button_start_stop), //push button input
.pb_debounced(pb_start_stop) // debounced push button output
);
one_pluse_start_stop(
.clk(clk), // clock input
.rst_n(reset), //active low reset
.in_trig(pb_start_stop), // input trigger
.out_pulse(fsm_start_stop_in) // output one pulse
);
fsm_start_stop(
   .rst(reset),
	.clk(clk),
	.sel_out(start_stop),
	.in(fsm_start_stop_in)
    );
//pause_resume
debounce_pause_resume(
.clk(clk_150), // clock control
.rst_n(reset), // reset
.pb_in(button_pause_resume), //push button input
.pb_debounced(pb_pause_resume) // debounced push button output
);	
one_pluse_pause_resume(
.clk(clk), // clock input
.rst_n(reset), //active low reset
.in_trig(pb_pause_resume), // input trigger
.out_pulse(fsm_pause_resume_in) // output one pulse
);
fsm_pause_resume(
   .rst(reset),
	.clk(clk),
	.sel_out(pause_resume),
	.in(fsm_pause_resume_in)
    ); 
//count down
count_down(
 //.switch_setting(switch_setting),
 .fast_clk(clk),
 .clk(clk_out), 
 .sel_in(start_stop), 
 .in0(hr_ttmp),
 .in1(hr_stmp),
 .in2(min_ttmp),
 .in3(min_stmp),
 .out0(hr_t),
 .out1(hr_s),
 .out2(min_t),
 .out3(min_s),
 .rst(reset),
 .LED(LED)
);	 
//display
scanf(
   .ftsd_ctl(display_ctl), // ftsd display control signal 
	.ftsd_in(bcd), // output to ftsd display
	.in0(out0), // 1st input
	.in1(out1), // 2nd input
	.in2(out2), // 3rd input
	.in3(out3), // 4th input
	.ftsd_ctl_en(clk_ctl) // divided clock for scan control
	);
bcd_d(
   .display(display), // 14-segment display output
	.bcd(bcd) // BCD input
	);	


endmodule
