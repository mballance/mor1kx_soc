
+incdir+${SIM_DIR_A}/../tb
+incdir+${SIM_DIR_A}/../tests

-f ${SV_BFMS}/api/sv/sv.f
-f ${SV_BFMS}/wb/wb.f
-f ${SV_BFMS}/wb/uvm/uvm.f

// Build the core design and testbench
-f ${MOR1KX_SOC}/ve/mor1kx_uvm/sim/scripts/vlog_common.f

// Replace the or1200 top module with a BFM
+define+OR1200_TOP_W_BFM_NAME=or1200_top_w
${MOR1KX_SOC}/ve/or1k_subsys_uvm/tb/or1200_top_w_bfm.sv

${SIM_DIR_A}/../tb/or1k_subsys_uvm_env_pkg.sv

${SIM_DIR_A}/../tests/or1k_subsys_uvm_tests_pkg.sv

${SIM_DIR_A}/../tb/or1k_subsys_uvm_tb.sv


