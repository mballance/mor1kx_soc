/****************************************************************************
 * mor1kx_uvm_vmon_h2m.svh
 ****************************************************************************/

/**
 * Class: mor1kx_uvm_vmon_h2m
 * 
 * TODO: Add class documentation
 */
class mor1kx_uvm_vmon_uart_m2h extends vmon_m2h_if;
	uart_serial_agent				m_uart_agent;

	virtual task recv(
		output byte unsigned 	data[64],
		input int				size,
		input int				timeout,
		output int				ret);
		byte unsigned tmp_d;
		bit valid;
		m_uart_agent.getc(tmp_d, valid, 
				(timeout>0)?(2*10*16*20):-1);
		
		if (valid) begin
			ret = 1;
			data[0] = tmp_d;
		end else begin
			ret = 0;
		end
	endtask	

endclass


