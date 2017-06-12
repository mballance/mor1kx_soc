
include $(SIMSCRIPTS_DIR)/mkfiles/plusargs.mk

TB=or1k_subsys_uvm_tb

MK_INCLUDES += $(MOR1KX_SOC)/ve/mor1kx_uvm/sim/scripts/rules_defs.mk
MK_INCLUDES += $(MOR1KX_SOC)/sw/fw/rules_defs.mk
MK_INCLUDES += $(UEX)/rules_defs.mk
MK_INCLUDES += $(UEX)/impl/sv/rules_defs.mk
MK_INCLUDES += $(GOOGLETEST_UVM)/src/rules_defs.mk

MK_INCLUDES += $(SIM_DIR)/../tests/sw/rules_defs.mk

MK_INCLUDES += $(VMON)/src/client/rules_defs.mk
MK_INCLUDES += $(VMON)/src/client/sv/rules_defs.mk
MK_INCLUDES += $(VMON)/src/monitor/rules_defs.mk

MK_INCLUDES += $(SV_BFMS)/api/rules_defs.mk

# MK_INCLUDES += $(OC_WB_IP)/rtl/wb_dma/fw/rules_defs.mk
# MK_INCLUDES += $(OC_WB_IP)/rtl/simple_pic/fw/rules_defs.mk

CXXFLAGS += -fexceptions
CFLAGS += -fexceptions

DPI_OBJS_LIBS += libuex.o 
DPI_OBJS_LIBS += libvmon_client.o libvmon_client_dpi.o
DPI_OBJS_LIBS += libvmon_monitor.o
DPI_OBJS_LIBS += $(LIBWB_DMA_FW) $(LIBWB_DMA_UEX_FW)
DPI_OBJS_LIBS += $(LIBSIMPLE_PIC_FW) 
DPI_OBJS_LIBS += $(MOR1KX_VMON_MAIN_DPI)
DPI_OBJS_LIBS += libmor1kx_vmon_main.o
DPI_OBJS_LIBS += $(LIBWB_UART_UEX_FW)
DPI_OBJS_LIBS += libfpio_uex_drv.o

INFACT_SRC_PROJECTS += $(SIM_DIR)/../tests/infact_or1k_subsys

#DPI_OBJS_LIBS += $(foreach swtest,$(call get_plusarg,SWTEST,$(PLUSARGS)),$(BUILD_DIR)/$(swtest).o)

# VSIM_FLAGS += -trace_dpi 1

RUN_PRE_TARGETS += rom.hex ram.hex

# Stub out initialization files
%.hex :
	$(Q)echo "@00000000" > $@
	$(Q)echo "00000000" >> $@

include $(SIMSCRIPTS_DIR)/mkfiles/common_sim.mk


