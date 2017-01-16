
import "DPI-C" context task dma_smoketest_test_main(int argc, string argv[]);

class or1k_subsys_uvm_dma_smoketest_c extends or1k_subsys_uvm_test_base;
	
	`uvm_component_utils(or1k_subsys_uvm_dma_smoketest_c)
	
	/****************************************************************
	 * Data Fields
	 ****************************************************************/
	
	/****************************************************************
	 * new()
	 ****************************************************************/
	function new(string name, uvm_component parent=null);
		super.new(name, parent);
	endfunction

	/****************************************************************
	 * build_phase()
	 ****************************************************************/
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	/****************************************************************
	 * connect_phase()
	 ****************************************************************/
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
	endfunction

	/****************************************************************
	 * run_phase()
	 ****************************************************************/
	task run_phase(uvm_phase phase);
		string argv[$];
		phase.raise_objection(this, "Main");
		
		argv.push_back("A");
		argv.push_back("B");
		argv.push_back("C");
		argv.push_back("D");
		
		dma_smoketest_test_main(argv.size(), argv);
		
		phase.drop_objection(this, "Main");		
	endtask
	
endclass



