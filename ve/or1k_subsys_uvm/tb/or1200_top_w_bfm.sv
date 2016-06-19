/****************************************************************************
 * or1200_top_w_bfm.sv
 ****************************************************************************/

`ifndef OR1200_TOP_W_BFM_NAME
	`define OR1200_TOP_W_BFM_NAME or1200_top_w_bfm
`endif

/**
 * Module: or1200_top_w_bfm
 * 
 * TODO: Add module documentation
 */
`include "or1200_defines.v"
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


endmodule


