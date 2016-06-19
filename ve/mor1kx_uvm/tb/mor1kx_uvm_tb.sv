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
	
	wire[3:0] pad_i = 0;
	wire[3:0] pad_o;
	
	mor1kx_soc u_soc (
		.clk   (clk  ), 
		.rstn  (rstn ),
		.pad_i (pad_i),
		.pad_o (pad_o));
	
	typedef generic_sram_byte_en_config #(18, 32) 	u_ram_cfg_t;
	typedef generic_rom_config #(18, 32) 			u_rom_cfg_t;
	typedef generic_sram_byte_en_config #(10, 32)	u_scratchpad_cfg_t;
	
	
	initial begin
		// Register the BFM virtual interfaces
		automatic u_ram_cfg_t u_ram_cfg = u_ram_cfg_t::type_id::create("u_ram_cfg");
		automatic u_rom_cfg_t u_rom_cfg = u_rom_cfg_t::type_id::create("u_rom_cfg");
		automatic u_scratchpad_cfg_t u_scratchpad_cfg = 
			u_scratchpad_cfg_t::type_id::create("u_scratchpad_cfg");
		automatic wb_uart_config u_uart_cfg = wb_uart_config::type_id::create("u_uart_cfg");
		
		// Handle to the SRAM BFM
		u_ram_cfg.vif = u_soc.u_ram.u_sram.ram;
		uvm_config_db #(u_ram_cfg_t)::set(uvm_top, "*m_u_ram_agent*", 
				u_ram_cfg_t::report_id, u_ram_cfg);
		
		// Handle to ROM BFM
		u_rom_cfg.vif = u_soc.u_rom.u_rom.rom;
		uvm_config_db #(u_rom_cfg_t)::set(uvm_top, "*",
				u_rom_cfg_t::report_id, u_rom_cfg);
		
		// Handle to the scratchpad BFM
		u_scratchpad_cfg.vif = u_soc.u_scratchpad.u_sram.ram;
		uvm_config_db #(u_scratchpad_cfg_t)::set(uvm_top, "*m_u_scratchpad_agent*", 
				u_scratchpad_cfg_t::report_id, u_scratchpad_cfg);
		
		
		u_uart_cfg.vif = u_soc.u_uart;
		u_uart_cfg.vif_path = $psprintf("%m.u_soc.u_uart");
		uvm_config_db #(wb_uart_config)::set(uvm_top, "*",
				wb_uart_config::report_id, u_uart_cfg);
			
	end
	
	initial begin
		run_test();
	end

	reg [3:0] test_end_state = 0;
	reg [3:0] last_pad_o = 0;
	always @(posedge clk) begin
		case (test_end_state)
			0: begin
				if (pad_o == 'hA) begin
					test_end_state <= 1;
				end
			end
			
			1: begin
				if (pad_o == 'h5) begin
					test_end_state <= 2;
				end
			end
			
			2: begin
				if (pad_o == 'hf)  begin
					string testname;
					
					if (!$value$plusargs("TESTNAME=%s", testname)) begin
						$display("Error: +TESTNAME not set");
					end
					
					$display("PASS: %s", testname);
					test_end_state <= 3;
				end else if (pad_o == 'h0) begin
					string testname;
					
					if (!$value$plusargs("TESTNAME=%s", testname)) begin
						$display("Error: +TESTNAME not set");
					end
					
					$display("FAIL: %s", testname);
					test_end_state <= 3;
				end
			end
			
			3: begin
				automatic uvm_component test_base = uvm_top.top_levels[0];
				automatic mor1kx_uvm_test_base test;
			
				$cast(test, test_base);
				test.test_end_signaled();	
				$display("End Test");				
			end
		endcase
	end

`ifdef ENABLE_OR1200_MON
	or1200_monitor		mon();
`endif

endmodule

