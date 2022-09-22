
module led_driver(i_clk, i_rst_n, i_next_led, o_led, i_tick);
	
	input i_clk;
	input i_tick;
	input i_next_led;
	input i_rst_n;
	
	logic r_dir = 1'b0;
	
	output logic [7:0] o_led = 8'b00000001;
	
	integer i;
//	always@(posedge i_clk) begin
//		if(i_next_led) begin
//			if(i_dir)
//				o_led <= o_led << 1;
//			else
//				o_led <= o_led >> 1;
//		end
//	end
	
	always@(posedge i_clk) begin
		if(i_tick)
			r_dir <= !r_dir;
		
		if(i_rst_n) begin
			if(i_next_led) begin
				if(r_dir) begin
					o_led[0] <= o_led[7];
					for(i=1;i<8;i++) begin
						o_led[i] <= o_led[i-1];
					end
				end
				else begin
					o_led[7] <= o_led[0];
					for(i=0;i<7;i++) begin
						o_led[i] <= o_led[i+1];
					end
				end
			end
		end
		else begin
			o_led <= 8'b00000001;
			r_dir <= 1'b0;
		end
	end	
endmodule 