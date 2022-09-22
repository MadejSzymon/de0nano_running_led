create_clock -name i_board_clk -period 20.000 [get_ports {i_board_clk}]
derive_clock_uncertainty
derive_pll_clocks -create_base_clocks
set_false_path -from [get_ports {i_sw[*] i_rst_n i_dir}]
set_false_path -to [get_ports {o_led[*]}]