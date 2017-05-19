/****************************************************************************
 * mor1kx_uvm_vmon_h2m.svh
 ****************************************************************************/

/**
 * Class: mor1kx_uvm_vmon_h2m
 * 
 * TODO: Add class documentation
 */
class mor1kx_uvm_vmon_uart_h2m extends vmon_h2m_if;
	uart_serial_agent				m_uart_agent;

	virtual task send(
		input byte unsigned 	data[64],
		input int				size,
		output int				ret);
		m_uart_agent.putc(data[0]);
		ret = 1;
	endtask	

endclass


