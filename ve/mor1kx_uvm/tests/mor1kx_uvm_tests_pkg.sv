

`include "uvm_macros.svh"
package mor1kx_uvm_tests_pkg;
	import uvm_pkg::*;
	import mor1kx_uvm_env_pkg::*;
	import sv_bfms_api_pkg::*;
	import sv_bfms_utils_pkg::*;
	import uart_serial_agent_pkg::*;
	import vmon_client_pkg::*;
	
	`include "mor1kx_uvm_vmon_uart_h2m.svh"
	`include "mor1kx_uvm_vmon_uart_m2h.svh"
	
	`include "mor1kx_uvm_test_base.svh"
	`include "mor1kx_uvm_backdoor_test.svh"
	`include "mor1kx_uvm_asm_test.svh"
	
endpackage
