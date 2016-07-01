
class mor1kx_soc_gate_uvm_test_base extends uvm_test;
	
	`uvm_component_utils(mor1kx_soc_gate_uvm_test_base)
	
	mor1kx_soc_gate_uvm_env				m_env;
	uvm_phase							m_main_phase;
	
	function new(string name, uvm_component parent=null);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	
		m_env = mor1kx_soc_gate_uvm_env::type_id::create("m_env", this);
	endfunction
	


	/**
	 * Task: run_phase
	 *
	 * Override from class 
	 */
	virtual task run_phase(input uvm_phase phase);
		phase.raise_objection(this, "Main");
		
		m_main_phase = phase;
	endtask
	
	virtual task test_end_signaled();
		m_main_phase.drop_objection(this, "Main");
	endtask

	
	
endclass

