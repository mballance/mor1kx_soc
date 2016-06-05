
class mor1kx_uvm_backdoor_test extends mor1kx_uvm_test_base;
	
	`uvm_component_utils(mor1kx_uvm_backdoor_test)
	
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
		mor1kx_uvm_env::u_rom_agent_t agent = m_env.m_u_rom_agent;
		sv_bfms_rw_api_if rom_if;
		sv_bfms_rw_api_if ram_if = m_env.m_u_ram_agent.get_api();
		bit[31:0] data;
		
		rom_if = agent.get_api();
			
		for (int i=0; i<16; i++) begin
			rom_if.write32(4*i, i+1);
		end
		
		for (int i=0; i<16; i++) begin
			ram_if.write32(4*i, i+4);
		end
		
		for (int i=0; i<16; i++) begin
			rom_if.read32(4*i, data);
			if (data != i+1) begin
				`uvm_error (get_type_name(), $psprintf("ROM Read %0d @ %0d ; expect %0d",
							data, 4*i, i+1));
			end
		end
		
		for (int i=0; i<16; i++) begin
			ram_if.read32(4*i, data);
			if (data != i+4) begin
				`uvm_error (get_type_name(), $psprintf("RAM Read %0d @ %0d ; expect %0d",
							data, 4*i, i+4));
			end
		end
		
		// TODO: Launch any local behavior
	endtask
	
	/**
	 * Function: report_phase
	 *
	 * Override from class 
	 */
	virtual function void report_phase(input uvm_phase phase);
		uvm_report_server svr = get_report_server();
		
		if (svr.get_severity_count(UVM_ERROR) > 0) begin
			$display("FAIL: %s", get_type_name());
		end else begin
			$display("PASS: %s", get_type_name());
		end
	endfunction

	
	
endclass



