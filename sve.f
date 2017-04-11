
+define+GENERIC_SRAM_BYTE_EN_BFM_NAME=generic_sram_byte_en_bfm
+incdir+${UVM_HOME}/src
${UVM_HOME}/src/uvm_pkg.sv

-f ${MOR1KX_SOC}/rtl/std_protocol_if/rtl/rtl.f
-f ${MOR1KX_SOC}/rtl/rtl.f

-f ${SV_BFMS}/sve.f

-F ${MOR1KX_SOC}/ve/or1k_subsys_uvm/sve.F
-f ${MOR1KX_SOC}/ve/mor1kx_uvm/tb/mor1kx_uvm_env.f
-f ${MOR1KX_SOC}/ve/mor1kx_uvm/tests/mor1kx_uvm_tests.f

-F ${MOR1KX_SOC}/sw/uex/ve/googletest_uvm/sve.F



