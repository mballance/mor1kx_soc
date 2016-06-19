
class or1k_subsys_uvm_dma_smoketest extends or1k_subsys_uvm_test_base;
	
	`uvm_component_utils(or1k_subsys_uvm_dma_smoketest)
	
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
		wb_dma_drv_t drv;
		sv_bfms_rw_api_if ram;
		int chan;
		int unsigned status = 0;
		phase.raise_objection(this, "Main");
	
		wb_dma_drv_init(drv, 'h8000_1000, null);
		$display("drv: %0d", drv);

//		$display("m_env=%p", m_env);
//		$display("m_env.m_u_scratchpad_agent=%p", m_env.m_u_scratchpad_agent);
		ram = m_env.m_u_scratchpad_agent.get_api();
//		// First, initialize a block of memory
		for (int i=0; i<64; i++) begin
			ram.write32(4*i, i+1);
		end
		
		wb_dma_drv_begin_xfer(drv,
				'h9000_0000,
				'h9000_0100,
				64,
				null,
				chan);
		
		$display("chan: %0d", chan);
	
		do begin
			#1us;
			wb_dma_drv_check_status(drv, chan, status);
			$display("Current status: %0d", status);
		end while (status == 1);
		
		$display("status: %0d", status);
		
		phase.drop_objection(this, "Main");		
	endtask
	
endclass


