
-f ${MEMORY_PRIMITIVES}/rtl/fpga/altsyncram/rtl.f

-f ${MOR1KX_SOC}/rtl/rtl.f

${MOR1KX_SOC}/fpga/soc_system/synthesis/soc_system.qip

${MOR1KX_SOC}/fpga/ip/debounce/debounce.v
${MOR1KX_SOC}/fpga/ip/altsource_probe/hps_reset.qip
${MOR1KX_SOC}/fpga/ip/edge_detect/altera_edge_detector.v
${MOR1KX_SOC}/fpga/ip/reset_synchronizer/reset_sync_block.v


${MOR1KX_SOC}/fpga/mor1kx_soc_fpga.sv

-do ${MOR1KX_SOC}/fpga/soc_system/soc_system_pins.do

/**
 * Port mapping
-assign-pin clk_i PIN_K14
-assign-pin pad0_o PIN_AF10
-assign-pin pad1_o PIN_AD10
-assign-pin pad2_o PIN_AE11
-assign-pin pad3_o PIN_AD7
 */


/**
 * Voltage
-io-standard clk_i "3.3-V LVTTL"
-io-standard pad0_o "3.3-V LVTTL"
-io-standard pad1_o "3.3-V LVTTL"
-io-standard pad2_o "3.3-V LVTTL"
-io-standard pad3_o "3.3-V LVTTL"
 */





