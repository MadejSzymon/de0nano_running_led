
module freq_divider(i_clk, i_rst_n, i_sw, o_next_led);
	
	input i_clk;
	input [3:0] i_sw;
	input i_rst_n;
	
	logic [25:0] r_counter = 0;
	logic [25:0] r_comp = 0;
	
	output logic o_next_led = 0;
	
	always@(posedge i_clk) begin
		if(i_rst_n) begin
			casez(i_sw) 
				4'b1???: r_comp <= {4'b0000,{22{1'b1}}};
				4'b01??: r_comp <= {3'b000,{23{1'b1}}};
				4'b001?: r_comp <= {2'b00,{24{1'b1}}};
				4'b0001: r_comp <= {1'b0,{25{1'b1}}};
				4'b0000: r_comp <= {26{1'b1}};
			endcase
			
			if (r_counter == r_comp) begin
				o_next_led <= 1'b1;
				r_counter <= 1'b0;
			end
			else begin
				r_counter <= r_counter + 1'b1;
				o_next_led <= 1'b0;
			end
		end
		else begin
			o_next_led <= 1'b0;
			r_counter <= 1'b0;
		end	
	end
	
endmodule 