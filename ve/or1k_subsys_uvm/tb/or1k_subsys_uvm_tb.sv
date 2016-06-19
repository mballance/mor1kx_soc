/****************************************************************************
 * or1k_subsys_uvm_tb.sv
 ****************************************************************************/

/**
 * Module: or1k_subsys_uvm_tb
 * 
 * TODO: Add module documentation
 */
`include "uvm_macros.svh"
module or1k_subsys_uvm_tb;
	import uvm_pkg::*;
	import or1k_subsys_uvm_tests_pkg::*;
	import wb_master_agent_pkg::*;

	// Instantiate the core testbench
	mor1kx_uvm_tb u_tb ();

	typedef wb_master_config #(32, 32) wb_cfg_t;

	// Need to register the BFMs for the I/D interfaces of the 
	// stub module that replaces the core
	initial begin
		automatic wb_cfg_t iwb_cfg = wb_cfg_t::type_id::create("iwb_cfg");
		automatic wb_cfg_t dwb_cfg = wb_cfg_t::type_id::create("dwb_cfg");
		
		iwb_cfg.vif = u_tb.u_soc.u_cpu.u_iwb;
		uvm_config_db #(wb_cfg_t)::set(uvm_top, "*m_iwb_agent*",
				wb_cfg_t::report_id, iwb_cfg);
		
		dwb_cfg.vif = u_tb.u_soc.u_cpu.u_dwb;
		uvm_config_db #(wb_cfg_t)::set(uvm_top, "*m_dwb_agent*",
				wb_cfg_t::report_id, dwb_cfg);
		
	end
	
endmodule
