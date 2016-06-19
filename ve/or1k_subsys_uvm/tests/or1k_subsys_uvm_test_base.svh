
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

	
	
	
endclass

