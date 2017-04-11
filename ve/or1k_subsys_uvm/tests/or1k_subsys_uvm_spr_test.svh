
class or1k_subsys_uvm_spr_test extends or1k_subsys_uvm_test_base;
	
	`uvm_component_utils(or1k_subsys_uvm_spr_test)
	
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
		sv_bfms_rw_api_if api;
		bit[31:0] dat;
		phase.raise_objection(this, "Main");
		
		api = m_env.m_spr_agent.get_api();
	
		api.write32((10 << 11)+0, 'ha0000080); // SPR_TTMR <= 'hffff
		api.write32((10 << 11)+1, 'h0); // SPR_TTCR <= 0
			
		for (int i=0; i<32; i++) begin
			api.read32((10<<11)+1, dat);
			
			$display("READ: 'h%08h", dat);
		end
		
		phase.drop_objection(this, "Main");
	endtask
	
endclass



