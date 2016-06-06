
class mor1kx_uvm_test_base extends uvm_test;
	
	`uvm_component_utils(mor1kx_uvm_test_base)
	
	mor1kx_uvm_env				m_env;
	
	function new(string name, uvm_component parent=null);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	
		m_env = mor1kx_uvm_env::type_id::create("m_env", this);
	endfunction
	


	/**
	 * Task: pre_main_phase
	 *
	 * Override from class 
	 */
	virtual task pre_main_phase(input uvm_phase phase);

	endtask
	
	virtual task test_end_signaled();
		
	endtask
	

	
	
endclass

