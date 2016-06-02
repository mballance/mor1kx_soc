/****************************************************************************
 * mor1kx_uvm_tb.sv
 ****************************************************************************/

/**
 * Module: mor1kx_uvm_tb
 * 
 * TODO: Add module documentation
 */
`include "uvm_macros.svh"
module mor1kx_uvm_tb;
	import uvm_pkg::*;
	import mor1kx_uvm_tests_pkg::*;
	import generic_sram_byte_en_agent_pkg::*;
	import generic_rom_agent_pkg::*;
	import wb_uart_agent_pkg::*;
	
	reg[15:0]                       rst_cnt = 0;
	reg                             rstn = 0;

		reg clk_r = 0;
		assign clk = clk_r;

		initial begin
			forever begin
				#10ns;
				clk_r <= 1;
				#10ns;
				clk_r <= 0;
			end
		end

	always @(posedge clk) begin
		if (rst_cnt == 100) begin
			rstn <= 1;
		end else begin
			rst_cnt <= rst_cnt + 1;
		end
	end
	
	mor1kx_soc u_soc (
		.clk   (clk  ), 
		.rstn  (rstn ));
	
	typedef generic_sram_byte_en_config #(10, 32) 	u_ram_cfg_t;
	typedef generic_rom_config #(16, 32) 			u_rom_cfg_t;
	
	initial begin
		// Register the BFM virtual interfaces
		automatic u_ram_cfg_t u_ram_cfg = u_ram_cfg_t::type_id::create("u_ram_cfg");
		automatic u_rom_cfg_t u_rom_cfg = u_rom_cfg_t::type_id::create("u_rom_cfg");
		automatic wb_uart_config u_uart_cfg = wb_uart_config::type_id::create("u_uart_cfg");
		
		// Handle to the SRAM BFM
		u_ram_cfg.vif = u_soc.u_ram.u_sram.ram;
		uvm_config_db #(u_ram_cfg_t)::set(uvm_top, "*", 
				u_ram_cfg_t::report_id, u_ram_cfg);
		
		// Handle to ROM BFM
		u_rom_cfg.vif = u_soc.u_rom.u_rom.rom;
		uvm_config_db #(u_rom_cfg_t)::set(uvm_top, "*",
				u_rom_cfg_t::report_id, u_rom_cfg);
		
		u_uart_cfg.vif = u_soc.u_uart;
		u_uart_cfg.vif_path = $psprintf("%m.u_soc.u_uart");
		uvm_config_db #(wb_uart_config)::set(uvm_top, "*",
				wb_uart_config::report_id, u_uart_cfg);
			
	end
	
	initial begin
		run_test();
	end

endmodule

