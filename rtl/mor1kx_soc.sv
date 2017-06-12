/****************************************************************************
 * mor1kx_soc.sv
 ****************************************************************************/

/**
 * Module: mor1kx_soc
 * 
 * TODO: Add module documentation
 */
`include "or1200_defines.v"
module mor1kx_soc(
		input					clk_i,
		output					pad0_o,
		output					pad1_o,
		output					pad2_o,
		output					pad3_o,
		output					stx_pad_o,
		input					srx_pad_i,
		fpio_fifo_if.fifo_out	dat_o,
		fpio_fifo_if.fifo_in	dat_i
		);
		
	reg					clk_r = 0;
	wire				clk;
	assign clk = clk_r;
	reg[4:0]			clk_cnt = 0;
	reg 				rstn = 0;
	reg[7:0]			rstn_cnt = 0;
	
	always @(posedge clk_i) begin
		clk_cnt <= clk_cnt + 5'b1;
		case (clk_cnt[0]) 
			0: clk_r <= 0;
			1: clk_r <= 1;
		endcase
	end
	
	always @(posedge clk) begin
		if (rstn_cnt == 255) begin
			rstn <= 1;
		end else begin
			rstn <= 0;
			rstn_cnt <= rstn_cnt + 1;
		end
	end

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

	wire[31:0]						irq_i;
	wire							int_o;
	wire[`OR1200_PIC_INTS-1:0]		pic_ints_i;
	
	assign pic_ints_i[`OR1200_PIC_INTS-1:1] = 0;
	assign pic_ints_i[0] = int_o;

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
	
	wb_if #(
		.WB_ADDR_WIDTH  (32 ), 
		.WB_DATA_WIDTH  (32 )
		) ic2err ();
	
	wb_if #(
		.WB_ADDR_WIDTH  (32 ), 
		.WB_DATA_WIDTH  (32 )
		) ic2dma ();
	
	wb_if #(
		.WB_ADDR_WIDTH  (32 ), 
		.WB_DATA_WIDTH  (32 )
		) dma2ic0 ();
	
	wb_if #(
		.WB_ADDR_WIDTH  (32 ), 
		.WB_DATA_WIDTH  (32 )
		) dma2ic1 ();
	
	wb_if #(
		.WB_ADDR_WIDTH  (32 ), 
		.WB_DATA_WIDTH  (32 )
		) ic2pad ();
	
	wb_if #(
		.WB_ADDR_WIDTH  (32 ), 
		.WB_DATA_WIDTH  (32 )
		) ic2scratchpad ();
	
	wb_if #(
		.WB_ADDR_WIDTH  (32 ), 
		.WB_DATA_WIDTH  (32 )
		) ic2intc ();
	
	wb_if #(
		.WB_ADDR_WIDTH  (32 ),
		.WB_DATA_WIDTH  (32 )
		) ic2fpio ();

	wb_interconnect_4x8 #(
		.WB_ADDR_WIDTH      (32     ), 
		.WB_DATA_WIDTH      (32     ), 
		.SLAVE0_ADDR_BASE   (32'h0000_0000  ), 
		.SLAVE0_ADDR_LIMIT  (32'h000F_FFFF  ), 
		.SLAVE1_ADDR_BASE   (32'h0200_0000  ), 
		.SLAVE1_ADDR_LIMIT  (32'h020F_FFFF  ),
		.SLAVE2_ADDR_BASE	(32'h8000_0000  ), // UART
		.SLAVE2_ADDR_LIMIT	(32'h8000_0FFF  ),
		.SLAVE3_ADDR_BASE	(32'h8000_1000  ),
		.SLAVE3_ADDR_LIMIT	(32'h8000_1FFF  ),
		.SLAVE4_ADDR_BASE	(32'h8000_2000  ),
		.SLAVE4_ADDR_LIMIT	(32'h8000_2FFF  ),
		.SLAVE5_ADDR_BASE   (32'h9000_0000  ),
		.SLAVE5_ADDR_LIMIT  (32'h9000_0FFF  ),
		.SLAVE6_ADDR_BASE   (32'h8000_3000  ),
		.SLAVE6_ADDR_LIMIT  (32'h8000_3FFF  ),
		.SLAVE7_ADDR_BASE   (32'h8000_4000  ), // FPIO
		.SLAVE7_ADDR_LIMIT  (32'h8000_4FFF  )
		
		) u_ic (
		.clk                (clk                  ),
		.rstn               (rstn                 ),
		.m0                 (iwbm.slave           ),
		.m1                 (dwbm.slave           ),
		.m2					(dma2ic0.slave        ),
		.m3					(dma2ic1.slave        ),
		.s0                 (ic2rom.master        ),
		.s1                 (ic2ram.master        ),
		.s2					(ic2uart.master       ), // 'h8000_0000
		.s3					(ic2dma.master        ), // 'h8000_1000
		.s4					(ic2pad.master        ),
		.s5					(ic2scratchpad.master ), // 'h9000_0000
		.s6					(ic2intc.master       ), // 'h8000_3000
		.s7					(ic2fpio.master       )  // 'h8000_4000
		);
	
	wb_rom #(
//		.MEM_ADDR_BITS     (18       ), 
		.MEM_ADDR_BITS     (14       ),  // 64k
		.WB_ADDRESS_WIDTH  (32       ), 
		.WB_DATA_WIDTH     (32       ),
		.INIT_FILE         ("rom.hex")
		) u_rom (
		.clk               (clk              ), 
		.rstn              (rstn             ), 
		.s                 (ic2rom.slave     ));

	wb_sram #(
//		.MEM_ADDR_BITS     (18    ), 
		.MEM_ADDR_BITS     (15    ), // 128k
		.WB_ADDRESS_WIDTH  (32 ), 
		.WB_DATA_WIDTH     (32    ),
		.INIT_FILE         ("ram.hex")
		) u_ram (
		.clk               (clk              ), 
		.rstn              (rstn             ), 
		.s                 (ic2ram.slave     ));

	// 4k scratchpad
	wb_sram #(
		.MEM_ADDR_BITS     (10    ), 
		.WB_ADDRESS_WIDTH  (32    ), 
		.WB_DATA_WIDTH     (32    )
		) u_scratchpad (
		.clk               (clk                ), 
		.rstn              (rstn               ), 
		.s                 (ic2scratchpad.slave));
	
	generic_sram_line_en_if #(
		.NUM_ADDR_BITS  (1 ), 
		.NUM_DATA_BITS  (32 )
		) bridge2pad (
		);
	
	wb_generic_line_en_sram_bridge #(
		.ADDRESS_WIDTH  (32 ), 
		.DATA_WIDTH     (32    )
		) u_pad_bridge (
		.clk            (clk                   ), 
		.rstn           (rstn          		   ), 
		.wb_s           (ic2pad.slave          ), 
		.sram_m         (bridge2pad.sram_client));


	
	assign bridge2pad.read_data[31:4] = 0;
//	assign bridge2pad.read_data[3:0] = pad_i;

	reg [3:0]		pad_o_reg = 0;
	always @(posedge clk) begin
		if (!rstn) begin
			pad_o_reg <= 0;
		end else begin
			if (bridge2pad.write_en) begin
				pad_o_reg <= bridge2pad.write_data[3:0];
			end
		end
	end
	assign pad0_o = pad_o_reg[0];
	assign pad1_o = pad_o_reg[1];
	assign pad2_o = pad_o_reg[2];
	assign pad3_o = pad_o_reg[3];

	wire			dma_inta_o, dma_intb_o;
	wire [30:0]		dma_req_i = 0;
	wire [30:0]		dma_nd_i = 0;
	wire [30:0]		dma_ack_o;
	wire [30:0]		dma_rest_i = 0;

	// We only need a single slave interface to DMA, but
	// the DMA has two to allow bus-bridge functionality.
	// We stub out the second slave interface
	wb_if #(
			.WB_ADDR_WIDTH  (32 ), 
			.WB_DATA_WIDTH  (32 )
		) stub2dma ();	

	wb_master_stub u_dma_stub (
			.m (stub2dma.master)
			);
	
	wb_dma_w #(.rf_addr(0), .ch_count(31)) u_dma0 (
		.clk         (clk            ), 
		.rst_i       (!rstn          ), 
		.wb0s        (ic2dma.slave   ), 
		.wb0m        (dma2ic0.master ), 
		.wb1s        (stub2dma.slave ), 
		.wb1m        (dma2ic1.master ), 
		.dma_req_i   (dma_req_i      ), 
		.dma_nd_i    (dma_nd_i       ), 
		.dma_ack_o   (dma_ack_o      ), 
		.dma_rest_i  (dma_rest_i     ), 
		.inta_o      (dma_inta_o     ), 
		.intb_o      (dma_intb_o     ));

	// TODO:
	wire uart_int_o, rts_pad_o, cts_pad_i, dtr_pad_o, 
		dsr_pad_i, ri_pad_i, dcd_pad_i;
//	assign srx_pad_i = 0;
	assign cts_pad_i = 1;
	assign dsr_pad_i = 0;
	assign ri_pad_i = 0;
	assign dcd_pad_i = 1;

	wb_uart u_uart (
		.clk        (clk           ), 
		.rstn       (rstn          ), 
		.s          (ic2uart.slave ), 
		.int_o      (uart_int_o    ), 
		.stx_pad_o  (stx_pad_o     ), 
		.srx_pad_i  (srx_pad_i     ), 
		.rts_pad_o  (rts_pad_o     ), 
		.cts_pad_i  (cts_pad_i     ), 
		.dtr_pad_o  (dtr_pad_o     ), 
		.dsr_pad_i  (dsr_pad_i     ), 
		.ri_pad_i   (ri_pad_i      ), 
		.dcd_pad_i  (dcd_pad_i     ));
	
	simple_pic_w #(
			.NUM_IRQ  (32 )
		) u_pic (
			.clk_i    (clk				), 
			.rstn_i   (rstn   			), 
			.s        (ic2intc.slave	), 
			.irq_i    (irq_i			), 
			.int_o    (int_o			));	
	
	
	// Connect interrupts
	wire fpio_irq;
	wb_fpio #(
		.FIFO_BITS  (8 )
		) u_fpio (
		.clk        (clk			), 
		.rstn       (rstn			), 
		.irq        (fpio_irq		), 
		.s          (ic2fpio.slave	), 
		.dat_o      (dat_o			), 
		.dat_i      (dat_i			));
	
	assign irq_i = {
			1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
			1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
			1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
			1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
			fpio_irq,
			uart_int_o, 
			dma_inta_o};
			
	
	
endmodule


