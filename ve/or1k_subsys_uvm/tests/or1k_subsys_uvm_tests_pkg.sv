

`include "uvm_macros.svh"
package or1k_subsys_uvm_tests_pkg;
	import uvm_pkg::*;
	import or1k_subsys_uvm_env_pkg::*;
	import mor1kx_uvm_env_pkg::*;
	import mor1kx_uvm_tests_pkg::*;
	import wb_dma_fw_pkg::*;
	import sv_bfms_api_pkg::*;
	
	`include "or1k_subsys_uvm_test_base.svh"
	`include "or1k_subsys_uvm_dma_smoketest.svh"
	`include "or1k_subsys_uvm_dma_smoketest_c.svh"
	
endpackage
