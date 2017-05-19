
class or1k_subsys_uvm_cpu_vseq_test extends or1k_subsys_uvm_test_base;
	
	`uvm_component_utils(or1k_subsys_uvm_cpu_vseq_test)
	
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
		or1k_cpu_vseq seq;
		string test;
		sv_bfms_rw_api_if bfm;
		
		phase.raise_objection(this, "Main");
		
		bfm = m_env.m_dwb_agent.get_api();
		
		seq = or1k_cpu_vseq::type_id::create("seq");
		seq.m_bfm = bfm;
		seq.start(null);
		
		phase.drop_objection(this, "Main");
	endtask
	
endclass



