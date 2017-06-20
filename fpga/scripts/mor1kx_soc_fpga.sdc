
create_clock -period 20 [get_ports fpga_clk_50]
create_generated_clock -name clk -source [get_ports {fpga_clk_50}] -divide_by 2 [get_registers {u_soc|clk_r}]

derive_pll_clocks

derive_clock_uncertainty

