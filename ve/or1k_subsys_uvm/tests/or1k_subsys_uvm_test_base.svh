
class or1k_subsys_uvm_test_base extends mor1kx_uvm_test_base;
	
	`uvm_component_utils(or1k_subsys_uvm_test_base)
	
	or1k_subsys_uvm_env				m_env;
	
	function new(string name, uvm_component parent=null);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		set_type_override_by_type(
				mor1kx_uvm_env::get_type(), 
				or1k_subsys_uvm_env::get_type());
		super.build_phase(phase);
	endfunction
	
	/**
	 * Function: connect_phase
	 *
	 * Override from class 
	 */
	virtual function void connect_phase(input uvm_phase phase);
		super.connect_phase(phase);
		
		$cast(m_env, super.m_env);
	endfunction


	/**
	 * Task: run_phase
	 *
	 * Override from class 
	 */
	virtual task run_phase(input uvm_phase phase);

	endtask



	/**
	 * Function: report_phase
	 *
	 * Override from class 
	 */
	virtual function void report_phase(input uvm_phase phase);
		uvm_report_server s = uvm_top.get_report_server();
		int n_errors = s.get_severity_count(UVM_ERROR);
		int n_fatal = s.get_severity_count(UVM_FATAL);
		string testname;
		
		if (!$value$plusargs("TESTNAME=%s", testname)) begin
			`uvm_fatal(get_name(), "No TESTNAME specified");
		end
	
		if (n_errors == 0 && n_fatal == 0) begin
			`uvm_info(get_name(), $psprintf("PASS: %0s", testname), UVM_LOW);
		end else begin
			`uvm_info(get_name(), $psprintf("FAIL: %0s", testname), UVM_LOW);
		end
	endfunction

	
	
	
	
endclass

