
include $(SIMSCRIPTS_DIR)/mkfiles/plusargs.mk


TIMEOUT := 2ms

XPROP := $(call have_plusarg,xprop,$(PLUSARGS))

ifneq (,$(XPROP))
VOPT_FLAGS += -xprop
endif



MK_INCLUDES += $(MOR1KX_SOC)/ve/mor1kx_uvm/sim/scripts/rules_defs.mk

TB=mor1kx_uvm_tb

# VOPT_FLAGS += -xprop


# Must build DPI libraries
# DPI_LIBRARIES += $(call get_plusarg,DPI_LIBRARY,$(PLUSARGS))
#LIB_TARGETS += $(foreach lib,$(call get_plusarg,DPI_LIBRARY,$(PLUSARGS)),$(lib)$(DLLEXT))
# LIB_TARGETS += $(foreach lib,$(DPI_LIBRARIES),$(lib)$(DPIEXT))

CFLAGS += \
  -I$(UVM_SDV)/c/common 	\
  -I$(UVM_SDV)/dpi			\
  
CFLAGS += -g
ASFLAGS += -G
  
BUILD_TARGETS += build_embedded_sw  

include $(SIMSCRIPTS_DIR)/mkfiles/common_sim.mk

.phony: build_emedded_sw
build_embedded_sw :
	echo "PLUSARGS=$(PLUSARGS)"
	echo "XPROP=$(XPROP) PLUSARGS=$(PLUSARGS)"
	$(Q)$(MAKE) -f $(SIM_DIR)/scripts/embedded_sw.mk build

SIM_DATAFILES += $(call get_plusarg,SW_IMAGE,$(PLUSARGS))
# UVM_TESTNAME := $(call get_plusarg,UVM_TESTNAME,$(PLUSARGS))


	
