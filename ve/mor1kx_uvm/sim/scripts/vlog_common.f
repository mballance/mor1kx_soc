
// Define the SRAM BFM name, such that we implement the generic SRAM devices
+define+GENERIC_SRAM_BYTE_EN_BFM_NAME=generic_sram_byte_en
+define+WB_UART_BFM_NAME=wb_uart

-f ${MOR1KX_SOC}/rtl/rtl.f
-f ${MEMORY_PRIMITIVES}/rtl/rtl_w.f

-f ${SV_BFMS}/api/sv/sv.f
-f ${SV_BFMS}/utils/sv/sv.f

// -f ${SV_BFMS}/generic_sram_byte_en/uvm/uvm.f
// -f ${SV_BFMS}/generic_sram_byte_en/sv.f
// -f ${SV_BFMS}/generic_rom/uvm/uvm.f
// -f ${SV_BFMS}/generic_rom/sv.f

-f ${SV_BFMS}/wb/wb.f
-f ${SV_BFMS}/wb/uvm/uvm.f
-f ${SV_BFMS}/utils/sv/sv.f
-f ${SV_BFMS}/uart/uvm/uvm.f
-f ${SV_BFMS}/uart/sv.f

-F ${VMON}/src/client/sv/vmon_client.F

-F ${FPIO}/ve/bfms/fpio_fifo_in_client/uvm/sve.F
${FPIO}/ve/bfms/fpio_fifo_in_client/fpio_fifo_in_client_bfm.sv

-F ${FPIO}/ve/bfms/fpio_fifo_out_client/uvm/sve.F
${FPIO}/ve/bfms/fpio_fifo_out_client/fpio_fifo_out_client_bfm.sv

// -f ${MOR1KX_SOC}/rtl/memory_primitives/rtl/sim/sim.f

-f ${MOR1KX_SOC}/ve/mor1kx_uvm/tb/mor1kx_uvm_env.f

-f ${MOR1KX_SOC}/ve/mor1kx_uvm/tests/mor1kx_uvm_tests.f

-f ${MOR1KX_SOC}/ve/mor1kx_uvm/tb/mor1kx_uvm_env_tb.f

