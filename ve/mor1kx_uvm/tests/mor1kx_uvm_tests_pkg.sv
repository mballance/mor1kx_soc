

`include "uvm_macros.svh"
package mor1kx_uvm_tests_pkg;
	import uvm_pkg::*;
	import mor1kx_uvm_env_pkg::*;
	import sv_bfms_api_pkg::*;
	import sv_bfms_utils_pkg::*;
	import wb_uart_agent_pkg::*;
	import wb_dma_fw_pkg::*;
	
	`include "mor1kx_uvm_test_base.svh"
	`include "mor1kx_uvm_backdoor_test.svh"
	`include "mor1kx_uvm_asm_test.svh"
	
endpackage
