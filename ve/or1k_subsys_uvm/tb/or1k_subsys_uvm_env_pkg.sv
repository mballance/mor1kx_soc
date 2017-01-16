
`include "uvm_macros.svh"

package or1k_subsys_uvm_env_pkg;
	import uvm_pkg::*;
	import mor1kx_uvm_env_pkg::*;
	import wb_dma_fw_pkg::*;
	import wb_master_agent_pkg::*;
	import sv_bfms_api_pkg::*;
	import sv_bfms_api_dpi_pkg::*;
	import irq_agent_pkg::*;

	`include "or1k_subsys_uvm_env.svh"
	
endpackage
