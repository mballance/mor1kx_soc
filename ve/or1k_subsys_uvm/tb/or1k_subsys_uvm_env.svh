
class or1k_subsys_uvm_env extends mor1kx_uvm_env;
	`uvm_component_utils(or1k_subsys_uvm_env)
	
	typedef wb_master_agent #(32, 32) wb_master_agent_t;

	wb_master_agent_t					m_iwb_agent;
	wb_master_agent_t					m_dwb_agent;
	irq_agent							m_irq_agent;
	
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
		m_irq_agent = irq_agent::type_id::create("m_irq_agent", this);
	endfunction

	/**
	 * Function: connect_phase
	 *
	 * Override from class uvm_component
	 */
	virtual function void connect_phase(input uvm_phase phase);
		super.connect_phase(phase);
	
		sv_bfms_rw_api_dpi::set_default(m_dwb_agent.get_api());
	endfunction
	
	
endclass
