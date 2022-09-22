
module edge_detector(i_clk, i_level, o_tick);

//INPUTS:
input wire i_clk; 
input wire i_level; 
//i_clk - WIRE FROM (PLL) 
//i_level - WIRE FROM (PUSH BUTTON) 

//OUTPUTS:
output reg o_tick;
//o_tick - REGISTER THAT STORES VALUE OF TICK (IMPULSE THAT INFORMS THE REST OF THE CIRCUIT ABOUT INTERACTION)

//OTHER NETS AND VARIABLES:
logic r_state_reg;
logic r_state_next;
//r_state_reg - REGISTER THAT STORES VALUE OF CURRENT STATE
//r_state_next - REGISTER THAT STORES VALUE OF AFTER-CLK-CYCLE STATE

//////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
initial 
begin
	o_tick <= 0;
	r_state_reg <= 0;
	r_state_next <= 0;
end
	
localparam  
    zero = 1'b0,
    one =  1'b1;



always @(posedge i_clk)
begin
        r_state_reg <= r_state_next;
end

always @(r_state_reg, i_level)
begin
    // store current state as next
    r_state_next = r_state_reg; // required: when no case statement is satisfied
    
    o_tick = 1'b0; // set o_tick to zero (so that 'o_tick = 1' is available for 1 cycle only)
    case(r_state_reg)
        zero: // set 'o_tick = 1' if state = zero and i_level = '1'
            if(i_level)  
                begin // if i_level is 1, then go to state one,
                    r_state_next = one; // otherwise remain in same state.
                    o_tick = 1'b1;
                end
        one: 
            if(~i_level) // if i_level is 0, then go to zero state,
                r_state_next = zero; // otherwise remain in one state.
				
    endcase
end
endmodule 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////