
// Bring in dependencies
// -f ${MOR1KX_SOC}/rtl/std_protocol_if/rtl/wb/wb.f

-f ${STD_PROTOCOL_IF}/rtl/wb/wb.f
-f ${STD_PROTOCOL_IF}/rtl/memory/memory.f

-f ${MOR1KX_SOC}/rtl/memory_primitives/rtl/rtl.f

-f ${MOR1KX_SOC}/rtl/oc_wb_ip/rtl/rtl.f

-f ${FPIO}/rtl/rtl.f

// -f ${MOR1KX_SOC}/rtl/mor1kx_mod/rtl/rtl.f
-f ${MOR1KX_SOC}/rtl/or1200/or1200.f
-f ${MOR1KX_SOC}/rtl/wb_sys_ip/rtl/rtl.f

-f ${FPIO}/rtl/wb_rtl.f

// SoC RTL
${MOR1KX_SOC}/rtl/mor1kx_soc.sv
