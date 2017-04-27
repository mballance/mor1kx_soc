
include $(SIMSCRIPTS_DIR)/mkfiles/plusargs.mk

TARG_OBJCOPY := or1k-elf-objcopy


TIMEOUT := 2ms

XPROP := $(call have_plusarg,xprop,$(PLUSARGS))

SW_IMAGE := $(call get_plusarg,SW_IMAGE,$(PLUSARGS))
SW_IMAGE_NAME := $(subst .elf,,$(notdir $(SW_IMAGE)))

ifneq (,$(XPROP))
VOPT_FLAGS += -xprop
endif

RUN_PRE_TARGETS += rom.hex ram.hex


MK_INCLUDES += $(SIM_DIR)/scripts/rules_defs.mk
MK_INCLUDES += $(MOR1KX_SOC)/sw/fw/rules_defs.mk

TB=mor1kx_uvm_tb

# VOPT_FLAGS += -xprop

USE_ALTLIB=true

VLOG_ARGS += -f $(SIM_DIR)/scripts/vlog.f

ifeq (true,$(USE_ALTLIB))
  VLOG_ARGS += -f $(SIM_DIR)/scripts/vlog_memalt.f
else
  VLOG_ARGS += -f $(SIM_DIR)/scripts/vlog_memsim.f
endif

VSIM_FLAGS += -suppress 3009


# Must build DPI libraries
# DPI_LIBRARIES += $(call get_plusarg,DPI_LIBRARY,$(PLUSARGS))
#LIB_TARGETS += $(foreach lib,$(call get_plusarg,DPI_LIBRARY,$(PLUSARGS)),$(lib)$(DLLEXT))
# LIB_TARGETS += $(foreach lib,$(DPI_LIBRARIES),$(lib)$(DPIEXT))

CFLAGS += \
  -I$(UVM_SDV)/c/common 	\
  -I$(UVM_SDV)/dpi			\
  
CFLAGS += -g
ASFLAGS += -G
  
BUILD_POSTCOMPILE_TARGETS += build_embedded_sw  

include $(SIMSCRIPTS_DIR)/mkfiles/common_sim.mk

.phony: build_emedded_sw
build_embedded_sw :
	echo "PLUSARGS=$(PLUSARGS)"
	echo "XPROP=$(XPROP) PLUSARGS=$(PLUSARGS)"
	$(Q)$(MAKE) -f $(SIM_DIR)/scripts/embedded_sw.mk build

SIM_DATAFILES += $(call get_plusarg,SW_IMAGE,$(PLUSARGS))


ifeq (true,$(USE_ALTLIB))

ram.hex : $(SW_IMAGE)
	$(Q)$(TARG_OBJCOPY) $^ -O ihex ram.ihex
	$(Q)perl $(MOR1KX_SOC)/synthscripts/bin/objcopy_ihex2quartus_filter.pl \
		-fill 0x1000 ram.ihex $@
	
rom.hex : $(BUILD_DIR)/mor1kx_soc_boot.elf
	$(Q)$(TARG_OBJCOPY) $^ -O ihex rom.ihex
	$(Q)perl $(MOR1KX_SOC)/synthscripts/bin/objcopy_ihex2quartus_filter.pl rom.ihex $@

else
ram.hex : $(SW_IMAGE)
	$(Q)$(TARG_OBJCOPY) -O verilog $^ ram.vlog
	$(Q)perl $(MEMORY_PRIMITIVES)/bin/objcopyvl2vl.pl -offset 0x10000000 ram.vlog $@
	
rom.hex : $(BUILD_DIR)/mor1kx_soc_boot.elf
	$(Q)$(TARG_OBJCOPY) -O verilog $^ rom.vlog
	$(Q)perl $(MEMORY_PRIMITIVES)/bin/objcopyvl2vl.pl rom.vlog $@

endif
	

# UVM_TESTNAME := $(call get_plusarg,UVM_TESTNAME,$(PLUSARGS))


	
