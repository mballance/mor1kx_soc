
include $(SIMSCRIPTS_DIR)/mkfiles/plusargs.mk

# UVM_SDV:=$(ROOTDIR)/../src/sdv
# include $(UVM_SDV)/c/rules_defs.mk
# include $(UVM_SDV)/dpi/rules_defs.mk

SCRIPTS_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

TB=mor1kx_uvm_tb

SRC_DIRS += $(SIMPLE_DPI)/tests/sw

# Must build DPI libraries
# DPI_LIBRARIES += $(call get_plusarg,DPI_LIBRARY,$(PLUSARGS))
#LIB_TARGETS += $(foreach lib,$(call get_plusarg,DPI_LIBRARY,$(PLUSARGS)),$(lib)$(DLLEXT))
# LIB_TARGETS += $(foreach lib,$(DPI_LIBRARIES),$(lib)$(DPIEXT))

CFLAGS += \
  -I$(SIMPLE_DPI)/tests/sw \
  -I$(UVM_SDV)/c/common \
  -I$(UVM_SDV)/dpi

	
include $(SIMSCRIPTS_DIR)/mkfiles/common_sim.mk

# SIM_DATAFILES += $(call get_plusarg,SW_IMAGE,$(PLUSARGS))
# UVM_TESTNAME := $(call get_plusarg,UVM_TESTNAME,$(PLUSARGS))


	