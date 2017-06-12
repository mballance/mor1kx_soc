
# should find a way to accept the value from a higher-level script
if test "x$SIMSCRIPTS_PROJECT_ENV" = "xtrue"; then
 export MOR1KX_SOC=`dirname $SIMSCRIPTS_DIR`
fi

uname_o=`uname -o`

if test "$uname_o" = "Cygwin"; then
	MOR1KX_SOC=`cygpath -w $MOR1KX_SOC | sed -e 's%\\\\%/%g'`
fi

export UEX=${MOR1KX_SOC}/sw/uex
export FPIO=${MOR1KX_SOC}/rtl/fpio
export GOOGLETEST_UVM=${MOR1KX_SOC}/ve/googletest_uvm
export MOR1KX=${MOR1KX_SOC}/rtl/mor1kx_mod
export WB_SYS_IP=${MOR1KX_SOC}/rtl/wb_sys_ip
export OC_WB_IP=${MOR1KX_SOC}/rtl/oc_wb_ip
export MEMORY_PRIMITIVES=${MOR1KX_SOC}/rtl/memory_primitives
export SV_BFMS=${MOR1KX_SOC}/ve/sv_bfms
export STD_PROTOCOL_IF=${MOR1KX_SOC}/rtl/std_protocol_if
export VMON=${MOR1KX_SOC}/vmon

