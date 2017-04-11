
class or1k_subsys_uvm_sw_test extends or1k_subsys_uvm_test_base;
	
	`uvm_component_utils(or1k_subsys_uvm_sw_test)
	
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
		string test;
		
		phase.raise_objection(this, "Main");
	
		if (!$value$plusargs("GTEST_FILTER=%s", test)) begin
			`uvm_fatal (get_name(), "+GTEST_FILTER not specified");
		end
		
		googletest_uvm_pkg::run_all_tests(test);
		
		phase.drop_objection(this, "Main");
	endtask
	
endclass



