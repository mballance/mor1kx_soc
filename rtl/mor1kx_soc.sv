/****************************************************************************
 * mor1kx_soc.sv
 ****************************************************************************/

`define HAVE_UART

/**
 * Module: mor1kx_soc
 * 
 * TODO: Add module documentation
 */
`include "or1200_defines.v"
module mor1kx_soc(
		input			clk,
		input			rstn);

	wb_if #(
		.WB_ADDR_WIDTH  (32 ), 
		.WB_DATA_WIDTH  (32 )
		) iwbm ();
	
	wb_if #(
		.WB_ADDR_WIDTH  (32 ), 
		.WB_DATA_WIDTH  (32 )
		) dwbm ();
	
	wire[31:0]						snoop_adr_i = 0;
	wire							snoop_en_i = 0;
	wire[31:0]						irq = 0;
	
	wire[`OR1200_PIC_INTS-1:0]		pic_ints_i = 0;

	or1200_top_w #(.WB_CLMODE(0)) u_cpu (
		.clk_i       (clk      ), 
		.rstn_i      (rstn     ), 
		.pic_ints_i  (pic_ints_i ), 
		.iwb         (iwbm.master        ), 
		.iwb_clk_i   (clk  ), 
		.dwb         (dwbm.master        ), 
		.dwb_clk_i   (clk  ));
	
	wb_if #(
		.WB_ADDR_WIDTH  (32 ), 
		.WB_DATA_WIDTH  (32 )
		) ic2rom ();
	
	wb_if #(
		.WB_ADDR_WIDTH  (32 ), 
		.WB_DATA_WIDTH  (32 )
		) ic2ram ();
	
	wb_if #(
		.WB_ADDR_WIDTH  (32 ), 
		.WB_DATA_WIDTH  (32 )
		) ic2uart ();
	

`ifdef HAVE_UART
	wb_interconnect_2x3 #(
		.WB_ADDR_WIDTH      (32     ), 
		.WB_DATA_WIDTH      (32     ), 
		.SLAVE0_ADDR_BASE   (32'h0000_0000  ), 
		.SLAVE0_ADDR_LIMIT  (32'h0003_FFFF  ), 
		.SLAVE1_ADDR_BASE   (32'h1000_0000  ), 
		.SLAVE1_ADDR_LIMIT  (32'h1000_FFFF  ),
		.SLAVE2_ADDR_BASE	(32'h8000_0000  ),
		.SLAVE2_ADDR_LIMIT	(32'h8000_1000  )
		) u_ic (
		.clk                (clk               ), 
		.rstn               (rstn              ), 
		.m0                 (iwbm.slave        ), 
		.m1                 (dwbm.slave        ), 
		.s0                 (ic2rom.master     ), 
		.s1                 (ic2ram.master     ),
		.s2					(ic2uart.master    ));
`else
		wb_interconnect_2x2 #(
				.WB_ADDR_WIDTH      (32     ), 
				.WB_DATA_WIDTH      (32     ), 
				.SLAVE0_ADDR_BASE   (32'h0000_0000  ), 
				.SLAVE0_ADDR_LIMIT  (32'h0000_FFFF  ), 
				.SLAVE1_ADDR_BASE   (32'h1000_0000  ), 
				.SLAVE1_ADDR_LIMIT  (32'h1000_FFFF  )
			) u_ic (
				.clk                (clk               ), 
				.rstn               (rstn              ), 
				.m0                 (iwbm.slave        ), 
				.m1                 (dwbm.slave        ), 
				.s0                 (ic2rom.master     ), 
				.s1                 (ic2ram.master     ));
`endif
	
	wb_rom #(
		.MEM_ADDR_BITS     (16    ), 
		.WB_ADDRESS_WIDTH  (32 ), 
		.WB_DATA_WIDTH     (32    ), 
		.INIT_FILE         (""        )
		) u_rom (
		.clk               (clk              ), 
		.rstn              (rstn             ), 
		.s                 (ic2rom.slave     ));

	wb_sram #(
		.MEM_ADDR_BITS     (10    ), 
		.WB_ADDRESS_WIDTH  (32 ), 
		.WB_DATA_WIDTH     (32    )
		) u_ram (
		.clk               (clk              ), 
		.rstn              (rstn             ), 
		.s                 (ic2ram.slave     ));

	// TODO:
	wire int_o, stx_pad_o, srx_pad_i, rts_pad_o,
		cts_pad_i, dtr_pad_o, dsr_pad_i, ri_pad_i, dcd_pad_i;
	assign srx_pad_i = 0;
	assign cts_pad_i = 1;
	assign dsr_pad_i = 0;
	assign ri_pad_i = 0;
	assign dcd_pad_i = 1;

`ifdef HAVE_UART
	wb_uart u_uart (
		.clk        (clk       ), 
		.rstn       (rstn      ), 
		.s          (ic2uart.slave         ), 
		.int_o      (int_o     ), 
		.stx_pad_o  (stx_pad_o ), 
		.srx_pad_i  (srx_pad_i ), 
		.rts_pad_o  (rts_pad_o ), 
		.cts_pad_i  (cts_pad_i ), 
		.dtr_pad_o  (dtr_pad_o ), 
		.dsr_pad_i  (dsr_pad_i ), 
		.ri_pad_i   (ri_pad_i  ), 
		.dcd_pad_i  (dcd_pad_i ));
`endif	
	
endmodule


