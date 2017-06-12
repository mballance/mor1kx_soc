#****************************************************************************
#* embedded_sw.mk
#*
#* Makefile for embedded software used by the testbench
#****************************************************************************

VERBOSE := true

SIM_SCRIPTS_DIR := $(dir $(lastword $(MAKEFILE_LIST)))
include $(SIMSCRIPTS_DIR)/mkfiles/plusargs.mk

MK_INCLUDES += $(MOR1KX_SOC)/rtl/mor1kx_mod/fw/mor1kx.mk
MK_INCLUDES += $(MOR1KX_SOC)/rtl/mor1kx_mod/fw/rules_defs.mk
MK_INCLUDES += $(MOR1KX_SOC)/sw/fw/rules_defs.mk
MK_INCLUDES += $(SIM_SCRIPTS_DIR)/../../tests/sw/rules_defs.mk
MK_INCLUDES += $(VMON)/src/monitor/rules_defs.mk
MK_INCLUDES += $(SIMSCRIPTS_DIR)/mkfiles/common_tool_gcc.mk

CFLAGS += -mcompat-delay -fomit-frame-pointer
CXXFLAGS += -mcompat-delay
CFLAGS += -g -DVMON_ARCH_32
CFLAGS += -fPIC

include $(MK_INCLUDES)


EXE_TARGETS += $(call get_plusarg,SW_IMAGE,$(PLUSARGS))
EXE_TARGETS += mor1kx_soc_boot.elf

RULES := 1

include $(MK_INCLUDES)

build : $(LIB_TARGETS) $(EXE_TARGETS)

	
