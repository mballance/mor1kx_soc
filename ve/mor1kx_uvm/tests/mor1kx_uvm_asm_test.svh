
class mor1kx_uvm_asm_test extends mor1kx_uvm_test_base;
	
	`uvm_component_utils(mor1kx_uvm_asm_test)
	
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
		string sw_image;
		sv_bfms_rw_api_if mem_if = m_env.m_u_rom_agent.get_api();
		
		if ($value$plusargs("SW_IMAGE=%s", sw_image)) begin
			// Load up the image
			elf_loader loader = new(this, mem_if);
			loader.m_big_endian = 0;
			loader.load(sw_image);
		end else begin
			`uvm_fatal (get_type_name(), "No +SW_IMAGE specified");
		end
		
		// TODO: Launch any local behavior
		phase.raise_objection(this, "Main");
	endtask
	
endclass


