
class mor1kx_uvm_asm_test extends mor1kx_uvm_test_base;
	
	`uvm_component_utils(mor1kx_uvm_asm_test)
	
	uvm_phase								m_run_phase;
	mor1kx_uvm_vmon_uart_h2m				m_uart_h2m;
	mor1kx_uvm_vmon_uart_m2h				m_uart_m2h;
	
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
		
//		m_env.m_uart_agent.m_mon_out_ap.connect(m_line_listener.analysis_export);
	endfunction

	/****************************************************************
	 * run_phase()
	 ****************************************************************/
	task run_phase(uvm_phase phase);
		bit[7:0] data;
		bit valid;
		byte unsigned tdata[] = new [2048];
		
		phase.raise_objection(this, "Main");
		
`ifdef UNDEFINED
		string sw_image;
		chandle drv;
		sv_bfms_rw_api_if mem_if = m_env.m_u_rom_agent.get_api();
`endif
		m_run_phase = phase;
		
		$display("--> connect\n");
		m_env.m_vmon_client.connect(valid);
		$display("<-- connect %d\n", valid);
	

		for (int i=0; i<2048; i+=64) begin
			int read_len = ((2048-i)<64)?(2048-i):64;
			$display("--> read %0d", i);
			m_env.m_vmon_client.read(i, tdata, read_len);
			$display("<-- read %0d", i);
		end
		
//		// Connect to the software
//		do begin
//			m_env.m_uart_agent.putc('hEA);
//	
//			$display("--> getc %0t", $time);
//			m_env.m_uart_agent.getc(data, valid, 
//					2*10*16*20);
//			$display("<-- getc %0t data='h%02h valid=%0d", 
//					$time, data, valid);
//		end while (!valid || data != 'hE5);
//
//		$display("Connected! valid=%0d data='h%02h", valid, data);
//		
//		m_env.m_uart_agent.putc('hEA);
//		m_env.m_uart_agent.putc('h01);
//		m_env.m_uart_agent.getc(data, valid);
//		
//		$display("ACK: 'h%02h", data);
//		
//		m_env.m_uart_agent.putc('hEA);
//		m_env.m_uart_agent.putc('h01);
//		m_env.m_uart_agent.getc(data, valid);
//		
//		$display("ACK: 'h%02h", data);
	
`ifdef UNDEFINED	
		if ($value$plusargs("SW_IMAGE=%s", sw_image)) begin
			// Load up the image
			elf_loader loader = new(this, mem_if);
			loader.m_big_endian = 0;
			loader.load(sw_image);
		end else begin
			`uvm_fatal (get_type_name(), "No +SW_IMAGE specified");
		end
`endif
		
		phase.drop_objection(this, "Main");
	endtask

	virtual task test_end_signaled();
		m_run_phase.drop_objection(this, "Main");
	endtask
	
endclass



