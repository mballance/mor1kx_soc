
class or1k_subsys_uvm_vmon_test_base extends or1k_subsys_uvm_test_base;
	
	`uvm_component_utils(or1k_subsys_uvm_vmon_test_base)
	
	/****************************************************************
	 * Data Fields
	 ****************************************************************/
	mor1kx_uvm_vmon_uart_h2m		m_uart_h2m;
	mor1kx_uvm_vmon_uart_m2h		m_uart_m2h;
	
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
		
		m_uart_h2m = new();
		m_uart_m2h = new();		
	endfunction

	/****************************************************************
	 * connect_phase()
	 ****************************************************************/
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		m_uart_h2m.m_uart_agent = m_env.m_uart_agent;
		m_uart_m2h.m_uart_agent = m_env.m_uart_agent;
		m_env.m_vmon_client.add_h2m_if(m_uart_h2m);
		m_env.m_vmon_client.add_m2h_if(m_uart_m2h);		
	endfunction

	/****************************************************************
	 * run_phase()
	 ****************************************************************/
	task run_phase(uvm_phase phase);
		bit ok;
		
		phase.raise_objection(this, "Main");
		
		fork 
			mor1kx_vmon_main_pkg::mor1kx_vmon_main();
		join_none

		$display("--> client.connect");
		m_env.m_vmon_client.connect(ok);
		$display("<-- client.connect");
		
		$display("OK: %0d", ok);
		
		phase.drop_objection(this, "Main");
	endtask
	
endclass



