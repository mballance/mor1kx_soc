/****************************************************************************
 * mor1kx_soc_alt_uvm_tb.sv
 ****************************************************************************/

/**
 * Module: mor1kx_soc_alt_uvm_tb
 * 
 * TODO: Add module documentation
 */
`include "uvm_macros.svh"
module mor1kx_soc_alt_uvm_tb;
	import uvm_pkg::*;
	import mor1kx_soc_alt_uvm_tests_pkg::*;

	reg clk_r = 0;
	assign clk = clk_r;

	initial begin
		forever begin
			#10ns;
			clk_r <= 1;
			#10ns;
			clk_r <= 0;
		end
	end

	wire[3:0] pad_i = 0;
	wire[3:0] pad_o;
	
	
	mor1kx_soc u_soc (
		.clk_i   (clk    ), 
		.pad0_o  (pad_o[0] ), 
		.pad1_o  (pad_o[1] ), 
		.pad2_o  (pad_o[2] ), 
		.pad3_o  (pad_o[3] ));
	
	initial begin
		run_test();
	end
	
	reg [3:0] test_end_state = 0;
	reg [3:0] last_pad_o = 0;
	always @(posedge clk) begin
		case (test_end_state)
			0: begin
				if (pad_o == 'hA) begin
					$display("Moving to state 'hA");
					test_end_state <= 1;
				end
			end
			
			1: begin
				if (pad_o == 'h5) begin
					$display("Moving to state 'h5");
					test_end_state <= 2;
				end else if (pad_o != 'hA) begin
					$display("Moving back to state 'h0");
					test_end_state <= 0;
				end
			end
			
			2: begin
				if (pad_o == 'hf)  begin
					string testname;
					
					if (!$value$plusargs("TESTNAME=%s", testname)) begin
						$display("Error: +TESTNAME not set");
					end
					
					$display("PASS: %s", testname);
					test_end_state <= 3;
				end else if (pad_o == 'h0) begin
					string testname;
					
					if (!$value$plusargs("TESTNAME=%s", testname)) begin
						$display("Error: +TESTNAME not set");
					end
					
					$display("FAIL: %s", testname);
					test_end_state <= 3;
				end else if (pad_o != 'h5) begin
					$display("State: %0d", pad_o);
					test_end_state <= 0;
				end
			end
			
			3: begin
				automatic uvm_component test_base = uvm_top.top_levels[0];
				automatic mor1kx_soc_alt_uvm_test_base test;
			
				$cast(test, test_base);
				test.test_end_signaled();	
				$display("End Test");				
			end
			
			default: begin
				test_end_state <= 0;
			end
		endcase
	end	

endmodule

