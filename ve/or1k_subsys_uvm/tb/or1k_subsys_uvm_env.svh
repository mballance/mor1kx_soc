
class or1k_subsys_uvm_env_tick_listener extends uvm_subscriber #(irq_seq_item);
	`uvm_component_utils(or1k_subsys_uvm_env_tick_listener)
	
	semaphore			m_irq = new(0);
	
	function new(string name, uvm_component parent=null);
		super.new(name, parent);
	endfunction


	/**
	 * Function: write
	 *
	 * Override from class 
	 */
	function void write(irq_seq_item t);
		m_irq.put(1);
	endfunction
	
endclass

class or1k_subsys_uvm_env_rw_api extends sv_bfms_rw_api_if;
	sv_bfms_rw_api_if			dflt;
	sv_bfms_rw_api_if			spr;
	

	function sv_bfms_rw_api_if get_api(inout bit[31:0] addr);
		$display("get_api 'h%08h", addr);
		if (addr[31:28] == 'hf) begin
			addr[31:28] = 0;
			return spr;
		end else begin
			return dflt;
		end
	endfunction

	/**
	 * Task: read32
	 *
	 * Override from class 
	 */
	virtual task read32(input bit[31:0] addr, output bit[31:0] data);
		sv_bfms_rw_api_if api = get_api(addr);
		api.read32(addr, data);
	endtask

	/**
	 * Task: read8
	 *
	 * Override from class 
	 */
	virtual task read8(input bit[31:0] addr, output bit[7:0] data);
		sv_bfms_rw_api_if api = get_api(addr);
		api.read8(addr, data);
	endtask

	/**
	 * Task: write32
	 *
	 * Override from class 
	 */
	virtual task write32(input bit[31:0] addr, input bit[31:0] data);
		sv_bfms_rw_api_if api = get_api(addr);
		api.write32(addr, data);
	endtask

	/**
	 * Task: write8
	 *
	 * Override from class 
	 */
	virtual task write8(input bit[31:0] addr, input bit[7:0] data);
		sv_bfms_rw_api_if api = get_api(addr);
		api.write8(addr, data);
	endtask

endclass

class or1k_subsys_uvm_env extends mor1kx_uvm_env;
	`uvm_component_utils(or1k_subsys_uvm_env)
	
	typedef wb_master_agent #(32, 32) wb_master_agent_t;

	wb_master_agent_t					m_iwb_agent;
	wb_master_agent_t					m_dwb_agent;
	wb_master_agent_t					m_spr_agent;
	irq_agent							m_irq_agent;
	irq_agent							m_tick_agent;
	or1k_subsys_uvm_env_rw_api			m_api;
	or1k_subsys_uvm_env_tick_listener	m_uex_tick_listener;
	
	function new(string name, uvm_component parent=null);
		super.new(name, parent);
	endfunction
	
	/**
	 * Function: build_phase
	 *
	 * Override from class uvm_component
	 */
	virtual function void build_phase(input uvm_phase phase);
		super.build_phase(phase);
		
		m_iwb_agent = wb_master_agent_t::type_id::create("m_iwb_agent", this);
		m_dwb_agent = wb_master_agent_t::type_id::create("m_dwb_agent", this);
		m_spr_agent = wb_master_agent_t::type_id::create("m_spr_agent", this);
		m_irq_agent = irq_agent::type_id::create("m_irq_agent", this);
		m_tick_agent = irq_agent::type_id::create("m_tick_agent", this);
		m_api = new();
		
		m_uex_tick_listener = or1k_subsys_uvm_env_tick_listener::type_id::create(
				"m_uex_tick_listener", this);
	endfunction

	/**
	 * Function: connect_phase
	 *
	 * Override from class uvm_component
	 */
	virtual function void connect_phase(input uvm_phase phase);
		super.connect_phase(phase);

		m_api.dflt = m_dwb_agent.get_api();
		m_api.spr  = m_spr_agent.get_api();
		
		sv_bfms_rw_api_dpi::set_default(m_api);
		
		m_tick_agent.m_drv_out_ap.connect(m_uex_tick_listener.analysis_export);
	endfunction



	/**
	 * Task: run_phase
	 *
	 * Override from class 
	 */
	virtual task run_phase(input uvm_phase phase);
		
		fork
			begin
				while (1) begin
					m_uex_tick_listener.m_irq.get(1);
					uex_pkg::uex_irq(0);
				end
			end
		join_none

	endtask

	
	
endclass
