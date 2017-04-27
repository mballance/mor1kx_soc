
// Define the SRAM BFM name, such that we implement the generic SRAM devices
+define+GENERIC_SRAM_BYTE_EN_BFM_NAME=generic_sram_byte_en
+define+WB_UART_BFM_NAME=wb_uart

-f ${SV_BFMS}/generic_sram_byte_en/uvm/uvm.f
-f ${SV_BFMS}/generic_sram_byte_en/sv.f
-f ${SV_BFMS}/generic_rom/uvm/uvm.f
-f ${SV_BFMS}/generic_rom/sv.f

