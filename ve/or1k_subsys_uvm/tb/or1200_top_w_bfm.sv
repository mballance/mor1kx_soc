/****************************************************************************
 * or1200_top_w_bfm.sv
 ****************************************************************************/

`ifndef OR1200_TOP_W_BFM_NAME
	`define OR1200_TOP_W_BFM_NAME or1200_top_w_bfm
`endif

`define SPRGROUP_PIC (9 << 11)
`define SPRGROUP_TT  (10 << 11)
`define SPRGROUP_FP  (11 << 11)

`include "or1200_defines.v"

module wb2spr_shim(
		input			clk,
		input			rstn,
		wb_if.slave		s,
		output			spr_cs,
		output			spr_write,
		output [31:0]	spr_addr,
		output [31:0]	spr_dat_i,
		input [31:0]	spr_dat_o
		);
	
	reg spr_ack = 0;
	assign spr_cs = (s.STB && s.CYC && !spr_ack);
	always @(posedge clk) begin
		if (!rstn) begin
			spr_ack <= 0;
		end else begin
			spr_ack <= spr_cs;
		end
	end
	assign s.ACK = spr_ack;
	assign s.ERR = 0;
	
	assign spr_addr = s.ADR;
	assign spr_write = s.WE;
	assign spr_dat_i = s.DAT_W;
	assign s.DAT_R = spr_dat_o;
	
endmodule

/**
 * Module: or1200_top_w_bfm
 * 
 * TODO: Add module documentation
 */
module `OR1200_TOP_W_BFM_NAME #(parameter int WB_CLMODE=0) (
		input							clk_i,
		input							rstn_i,
		wire[`OR1200_PIC_INTS-1:0]		pic_ints_i,
		wb_if.master					iwb,
		input							iwb_clk_i,
		wb_if.master					dwb,
		input							dwb_clk_i
		);
	
	initial begin
		$display("or1200 BFM instantiated");
	end

	wb_master_bfm #(
		.WB_ADDR_WIDTH  (32 ), 
		.WB_DATA_WIDTH  (32 )
		) u_iwb (
		.clk            (clk_i      ), 
		.rstn           (rstn_i     ), 
		.master         (iwb        ));
	
	wb_master_bfm #(
			.WB_ADDR_WIDTH  (32 ), 
			.WB_DATA_WIDTH  (32 )
		) u_dwb (
			.clk            (clk_i      ), 
			.rstn           (rstn_i     ), 
			.master         (dwb        ));
	
	wb_if #(
		.WB_ADDR_WIDTH  (32 ), 
		.WB_DATA_WIDTH  (32 )
		) spr_bfm2ic ();
	
	wb_if #(
		.WB_ADDR_WIDTH  (32 ), 
		.WB_DATA_WIDTH  (32 )
		) spr_ic2pic ();
	
	wb_if #(
		.WB_ADDR_WIDTH  (32 ), 
		.WB_DATA_WIDTH  (32 )
		) spr_ic2tt ();
	
	wb_master_bfm #(
			.WB_ADDR_WIDTH	(32),
			.WB_DATA_WIDTH	(32)
		) u_spr (
			.clk			(clk_i),
			.rstn			(rstn_i),
			.master			(spr_bfm2ic.master));
	
	wb_interconnect_1x2 #(
		.WB_ADDR_WIDTH      (32     ), 
		.WB_DATA_WIDTH      (32     ), 
		.SLAVE0_ADDR_BASE   (`SPRGROUP_PIC  ), 
		.SLAVE0_ADDR_LIMIT  (`SPRGROUP_TT-1 ), 
		.SLAVE1_ADDR_BASE   (`SPRGROUP_TT   ), 
		.SLAVE1_ADDR_LIMIT  (`SPRGROUP_FP-1 )
		) u_spr_ic (
		.clk                (clk_i             ), 
		.rstn               (rstn_i            ), 
		.m0                 (spr_bfm2ic.slave  ), 
		.s0                 (spr_ic2pic.master ), 
		.s1                 (spr_ic2tt.master  ));

	wire intr;
	
	wire pic_spr_cs, pic_spr_write;
	wire[31:0] pic_spr_addr, pic_spr_dat_i, pic_spr_dat_o;
	
	wb2spr_shim pic_shim (
		.clk        (clk_i       		),
		.rstn       (rstn_i      		),
		.s          (spr_ic2pic.slave	),
		.spr_cs     (pic_spr_cs    		),
		.spr_write  (pic_spr_write 		),
		.spr_addr   (pic_spr_addr  		),
		.spr_dat_i  (pic_spr_dat_i 		),
		.spr_dat_o  (pic_spr_dat_o 		));
	
	or1200_pic u_pic (
		.clk         (clk_i				),
		.rst         (~rstn_i    		),
		.spr_cs      (pic_spr_cs		),
		.spr_write   (pic_spr_write		),
		.spr_addr    (pic_spr_addr		),
		.spr_dat_i   (pic_spr_dat_i		),
		.spr_dat_o   (pic_spr_dat_o		),
		.pic_wakeup  (pic_wakeup		),
		.intr        (intr				),
		.pic_int     (pic_ints_i		));

	wire tt_spr_cs, tt_spr_write;
	wire[31:0] tt_spr_addr, tt_spr_dat_i, tt_spr_dat_o;
	
	wb2spr_shim tt_shim (
		.clk        (clk_i				), 
		.rstn       (rstn_i				), 
		.s          (spr_ic2tt.slave	), 
		.spr_cs     (tt_spr_cs			), 
		.spr_write  (tt_spr_write		), 
		.spr_addr   (tt_spr_addr		), 
		.spr_dat_i  (tt_spr_dat_i		), 
		.spr_dat_o  (tt_spr_dat_o		));

	wire tt_tick;
	wire tt_du_stall = 0; // ?
	or1200_tt u_tt (
		.clk        (clk_i       ), 
		.rst        (~rstn_i       ), 
		.du_stall   (tt_du_stall  ), 
		.spr_cs     (tt_spr_cs    ), 
		.spr_write  (tt_spr_write ), 
		.spr_addr   (tt_spr_addr  ), 
		.spr_dat_i  (tt_spr_dat_i ), 
		.spr_dat_o  (tt_spr_dat_o ), 
		.intr       (tt_tick      ));
	
	irq_bfm u_tick (
		.clk  (clk_i), 
		.rstn (rstn_i), 
		.irq  (tt_tick));
	
	irq_bfm u_irq (
		.clk  (clk_i), 
		.rstn (rstn_i), 
		.irq  (intr));
	
endmodule


