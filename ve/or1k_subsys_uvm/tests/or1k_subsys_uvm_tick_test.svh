
class or1k_subsys_uvm_tick_test_listener extends uvm_subscriber #(irq_seq_item);
	`uvm_component_utils(or1k_subsys_uvm_tick_test_listener)
	
	semaphore			m_sem = new(0);

	function new(string name, uvm_component parent=null);
		super.new(name, parent);
	endfunction


	/**
	 * Function: write
	 *
	 * Override from class 
	 */
	function void write(irq_seq_item t);
		$display("IRQ: ");
		m_sem.put(1);
	endfunction
	
endclass

class or1k_subsys_uvm_tick_test extends or1k_subsys_uvm_test_base;
	
	`uvm_component_utils(or1k_subsys_uvm_tick_test)
	
	or1k_subsys_uvm_tick_test_listener			tick_l;
	
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
		tick_l = or1k_subsys_uvm_tick_test_listener::type_id::create("tick_l", this);
	endfunction

	/****************************************************************
	 * connect_phase()
	 ****************************************************************/
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		m_env.m_tick_agent.m_drv_out_ap.connect(tick_l.analysis_export);
	endfunction
	
	int						tick_count = 0;

	/****************************************************************
	 * run_phase()
	 ****************************************************************/
	task run_phase(uvm_phase phase);
		sv_bfms_rw_api_if api;
		bit[31:0] dat;
		phase.raise_objection(this, "Main");
		
		api = sv_bfms_api_dpi_pkg::m_dpi_mgr.m_default;

		// Configure to restart
		api.write32('hf000_0000+(10 << 11)+0, 'h60000080); // SPR_TTMR <= 'hffff
		api.write32('hf000_0000+(10 << 11)+1, 'h0); // SPR_TTCR <= 0
		
		for (int i=0; i<16; i++) begin
			$display("--> GET");
			tick_l.m_sem.get(1);
			$display("<-- GET");
		
			$display("--> UPDATE");
			api.read32('hf000_0000+(10 << 11)+0, dat);
			dat[28] = 0;
			api.write32('hf000_0000+(10 << 11)+0, dat);
			$display("<-- UPDATE");
			tick_count++;
		end
		
		phase.drop_objection(this, "Main");
	endtask
	
	/**
	 * Function: report_phase
	 *
	 * Override from class 
	 */
	virtual function void report_phase(input uvm_phase phase);
		
		if (tick_count != 16) begin
			`uvm_error (get_name(), 
					$psprintf("Expected 16 ticks, received %0d", tick_count));
		end

		super.report_phase(phase);
	endfunction

	
	
endclass



