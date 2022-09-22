
module top(i_board_clk, i_rst_n, i_sw, i_dir, o_led);
	
	input i_board_clk;
	input i_rst_n;
	input [3:0] i_sw;
	input i_dir;
	
	logic w_clk;
	logic w_next_led;
	logic w_tick;
	
	output [7:0] o_led;
	
	pll	pll_inst (
	.inclk0 ( i_board_clk ),
	.c0 ( w_clk )
	);
	
	edge_detector edge_detector(
	.i_clk(w_clk),
	.i_level(i_dir),
	.o_tick(w_tick)
	);
	
	freq_divider fre_divider(
	.i_clk(w_clk),
	.i_rst_n(i_rst_n), 
	.i_sw(i_sw), 
	.o_next_led(w_next_led)
	);
	
	led_driver led_driver(
	.i_clk(w_clk),
	.i_rst_n(i_rst_n),
	.i_next_led(w_next_led),
	.i_tick(w_tick),
	.o_led(o_led)
	);
endmodule 