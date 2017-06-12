

`include "uvm_macros.svh"
package or1k_subsys_uvm_tests_pkg;
	import uvm_pkg::*;
	import or1k_subsys_uvm_env_pkg::*;
	import mor1kx_uvm_env_pkg::*;
	import mor1kx_uvm_tests_pkg::*;
	import sv_bfms_api_pkg::*;
	import uex_pkg::*;
	import irq_agent_pkg::*;
	import vmon_client_pkg::*;
	
	`include "sequences/or1k_memcheck_c.svh"
	`include "sequences/or1k_cpu_vseq.svh"
	`include "sequences/or1k_memcheck_vseq.svh"
	
`ifdef INFACT
	`include "infact_or1k_subsys/or1k_subsys_regtest_seq/or1k_subsys_regtest_seq.svh"
	`include "infact_or1k_subsys/or1k_subsys_b2b_regtest_seq/or1k_subsys_b2b_regtest_seq.svh"
`endif
	
	`include "or1k_subsys_uvm_test_base.svh"
	`include "or1k_subsys_uvm_cpu_vseq_test.svh"
	`include "or1k_subsys_uvm_dma_smoketest.svh"
	`include "or1k_subsys_uvm_dma_smoketest_c.svh"
	`include "or1k_subsys_uvm_sw_test.svh"
	`include "or1k_subsys_uvm_spr_test.svh"
	`include "or1k_subsys_uvm_tick_test.svh"
	`include "or1k_subsys_uvm_vmon_base_test.svh"
	
endpackage
