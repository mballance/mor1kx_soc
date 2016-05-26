/****************************************************************************
 * mor1kx_soc.sv
 ****************************************************************************/

/**
 * Module: mor1kx_soc
 * 
 * TODO: Add module documentation
 */
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

	mor1kx_w #(
//		.FEATURE_DATACACHE                ("YES"               ), 
		.FEATURE_DATACACHE                ("NONE"              ), 
		/*
		.OPTION_DCACHE_BLOCK_WIDTH        (OPTION_DCACHE_BLOCK_WIDTH       ), 
		.OPTION_DCACHE_SET_WIDTH          (OPTION_DCACHE_SET_WIDTH         ), 
		.OPTION_DCACHE_WAYS               (OPTION_DCACHE_WAYS              ), 
		.OPTION_DCACHE_LIMIT_WIDTH        (OPTION_DCACHE_LIMIT_WIDTH       ), 
		 */
//		.OPTION_DCACHE_SNOOP              ("YES"             ), 
		/** TODO:
		.FEATURE_DMMU                     ("YES"                    ), 
		.FEATURE_DMMU_HW_TLB_RELOAD       ("YES"      ), 
		 */
		/*
		.OPTION_DMMU_SET_WIDTH            (OPTION_DMMU_SET_WIDTH           ), 
		.OPTION_DMMU_WAYS                 (OPTION_DMMU_WAYS                ), 
		 */
//		.FEATURE_INSTRUCTIONCACHE         ("YES"        ), 
		.FEATURE_INSTRUCTIONCACHE         ("NONE"        ), 
		/*
		.OPTION_ICACHE_BLOCK_WIDTH        (OPTION_ICACHE_BLOCK_WIDTH       ), 
		.OPTION_ICACHE_SET_WIDTH          (OPTION_ICACHE_SET_WIDTH         ), 
		.OPTION_ICACHE_WAYS               (OPTION_ICACHE_WAYS              ), 
		.OPTION_ICACHE_LIMIT_WIDTH        (OPTION_ICACHE_LIMIT_WIDTH       ), 
		 */
		/** TODO:
		.FEATURE_IMMU                     ("YES"                    ), 
		.FEATURE_IMMU_HW_TLB_RELOAD       ("YES"      ), 
		 */
		/*
		.OPTION_IMMU_SET_WIDTH            (OPTION_IMMU_SET_WIDTH           ), 
		.OPTION_IMMU_WAYS                 (OPTION_IMMU_WAYS                ), 
		 */
		/*
		.FEATURE_TIMER                    (FEATURE_TIMER                   ), 
		.FEATURE_DEBUGUNIT                (FEATURE_DEBUGUNIT               ), 
		.FEATURE_PERFCOUNTERS             (FEATURE_PERFCOUNTERS            ), 
		.FEATURE_MAC                      (FEATURE_MAC                     ), 
		.FEATURE_SYSCALL                  (FEATURE_SYSCALL                 ), 
		.FEATURE_TRAP                     (FEATURE_TRAP                    ), 
		.FEATURE_RANGE                    (FEATURE_RANGE                   ), 
		.FEATURE_PIC                      (FEATURE_PIC                     ), 
		.OPTION_PIC_TRIGGER               (OPTION_PIC_TRIGGER              ), 
		.OPTION_PIC_NMI_WIDTH             (OPTION_PIC_NMI_WIDTH            ), 
		.FEATURE_DSX                      (FEATURE_DSX                     ), 
		.FEATURE_OVERFLOW                 (FEATURE_OVERFLOW                ), 
		.FEATURE_CARRY_FLAG               (FEATURE_CARRY_FLAG              ), 
		.FEATURE_FASTCONTEXTS             (FEATURE_FASTCONTEXTS            ), 
		.OPTION_RF_CLEAR_ON_INIT          (OPTION_RF_CLEAR_ON_INIT         ), 
		.OPTION_RF_NUM_SHADOW_GPR         (OPTION_RF_NUM_SHADOW_GPR        ), 
		.OPTION_RF_ADDR_WIDTH             (OPTION_RF_ADDR_WIDTH            ), 
		.OPTION_RF_WORDS                  (OPTION_RF_WORDS                 ), 
		.OPTION_RESET_PC                  (OPTION_RESET_PC                 ), 
		.FEATURE_MULTIPLIER               (FEATURE_MULTIPLIER              ), 
		.FEATURE_DIVIDER                  (FEATURE_DIVIDER                 ), 
		.FEATURE_ADDC                     (FEATURE_ADDC                    ), 
		.FEATURE_SRA                      (FEATURE_SRA                     ), 
		.FEATURE_ROR                      (FEATURE_ROR                     ), 
		.FEATURE_EXT                      (FEATURE_EXT                     ), 
		.FEATURE_CMOV                     (FEATURE_CMOV                    ), 
		.FEATURE_FFL1                     (FEATURE_FFL1                    ), 
		.FEATURE_ATOMIC                   (FEATURE_ATOMIC                  ), 
		.FEATURE_CUST1                    (FEATURE_CUST1                   ), 
		.FEATURE_CUST2                    (FEATURE_CUST2                   ), 
		.FEATURE_CUST3                    (FEATURE_CUST3                   ), 
		.FEATURE_CUST4                    (FEATURE_CUST4                   ), 
		.FEATURE_CUST5                    (FEATURE_CUST5                   ), 
		.FEATURE_CUST6                    (FEATURE_CUST6                   ), 
		.FEATURE_CUST7                    (FEATURE_CUST7                   ), 
		.FEATURE_CUST8                    (FEATURE_CUST8                   ), 
		.FEATURE_FPU                      (FEATURE_FPU                     ), 
		.OPTION_SHIFTER                   (OPTION_SHIFTER                  ), 
		.FEATURE_STORE_BUFFER             (FEATURE_STORE_BUFFER            ), 
		.OPTION_STORE_BUFFER_DEPTH_WIDTH  (OPTION_STORE_BUFFER_DEPTH_WIDTH ), 
		.FEATURE_MULTICORE                (FEATURE_MULTICORE               ), 
		.FEATURE_TRACEPORT_EXEC           (FEATURE_TRACEPORT_EXEC          ), 
		 */
		.BUS_IF_TYPE                      ("WISHBONE32"                     )
		/*
		.IBUS_WB_TYPE                     (IBUS_WB_TYPE                    ), 
		.DBUS_WB_TYPE                     (DBUS_WB_TYPE                    )
		 */
		) u_cpu (
		.clk                              (clk                             ), 
		.rstn                             (rstn                            ), 
		.iwbm                             (iwbm.master                     ), 
		.dwbm                             (dwbm.master                     ),
		.irq_i                            (irq                             ),
		.snoop_adr_i                      (snoop_adr_i                     ),
		.snoop_en_i                       (snoop_en_i                      ));
	
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
	
	
	wb_interconnect_2x3 #(
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
		.s1                 (ic2ram.master     ),
		.s2					(ic2uart.master    ));
	
	wb_rom #(
		.MEM_ADDR_BITS     (10    ), 
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
		
	wb_uart wb_uart (
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
	
endmodule


