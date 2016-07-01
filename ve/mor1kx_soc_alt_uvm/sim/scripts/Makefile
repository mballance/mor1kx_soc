
include $(SIMSCRIPTS_DIR)/mkfiles/plusargs.mk

TB=mor1kx_soc_alt_uvm_tb

BUILD_TARGETS += $(BUILD_DIR)/rom.hex

# MK_INCLUDES += ${MOR1KX_SOC}/ve/mor1kx_soc_alt_uvm/

RUN_DATAFILES := $(BUILD_DIR)/rom.hex

include $(SIMSCRIPTS_DIR)/mkfiles/common_sim.mk

VSIM_FLAGS += -suppress 3009


.phony: mk_rom
$(BUILD_DIR)/%.hex:
	$(MAKE) -f $(SIM_DIR)/scripts/embedded_sw.mk $@


	