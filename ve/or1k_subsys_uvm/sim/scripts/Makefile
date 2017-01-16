
include $(SIMSCRIPTS_DIR)/mkfiles/plusargs.mk

TB=or1k_subsys_uvm_tb

MK_INCLUDES += $(MOR1KX_SOC)/ve/mor1kx_uvm/sim/scripts/rules_defs.mk
MK_INCLUDES += $(SIM_DIR)/../tests/sw/rules_defs.mk
MK_INCLUDES += $(SV_BFMS)/api/rules_defs.mk
MK_INCLUDES += $(OC_WB_IP)/rtl/wb_dma/fw/rules_defs.mk

DPI_OBJS_LIBS += $(foreach swtest,$(call get_plusarg,SWTEST,$(PLUSARGS)),$(BUILD_DIR)/$(swtest).o)

include $(SIMSCRIPTS_DIR)/mkfiles/common_sim.mk


