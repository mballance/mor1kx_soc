VERBOSE := true

MK_INCLUDES += $(MOR1KX_SOC)/rtl/mor1kx_mod/fw/mor1kx.mk
MK_INCLUDES += $(MOR1KX_SOC)/rtl/mor1kx_mod/fw/rules_defs.mk
MK_INCLUDES += $(MOR1KX_SOC)/sw/fw/rules_defs.mk
MK_INCLUDES += $(MOR1KX_SOC)/sw/fw/boot/rules_defs.mk
MK_INCLUDES += $(WB_SYS_IP)/rtl/wb_uart/fw/rules_defs.mk
MK_INCLUDES += $(OC_WB_IP)/rtl/wb_dma/fw/rules_defs.mk
MK_INCLUDES += $(OC_WB_IP)/rtl/simple_pic/fw/rules_defs.mk
MK_INCLUDES += $(UEX)/rules_defs.mk
MK_INCLUDES += $(UEX)/impl/threading/uth/rules_defs.mk
MK_INCLUDES += $(UEX)/impl/threading/uth/or1k/rules_defs.mk
MK_INCLUDES += $(UEX)/impl/mem/baremetal/rules_defs.mk
MK_INCLUDES += $(FPIO)/fw/rules_defs.mk
MK_INCLUDES += $(VMON)/src/monitor/rules_defs.mk
MK_INCLUDES += $(SIMSCRIPTS_DIR)/mkfiles/common_tool_gcc.mk

RULES := 0

include $(MK_INCLUDES)

RULES := 1

rom.ihex : mor1kx_soc_boot.elf
	$(Q)$(OBJCOPY) $^ -O ihex $@
#	echo "TODO: build rom.ihex"

%.hex : %.ihex
	$(Q)objcopy_ihex2quartus_filter.pl $^ $@
	
%.ihex : %.elf
	$(Q)$(OBJCOPY) $^ -O ihex $@

#$(BUILD_DIR)/%.elf : $(MOR1KX_SOC)/synth/rom.S
#	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
#	$(Q)$(AS) -c -o rom.o $(ASFLAGS) $^
#	$(Q)$(LD) -o $@ rom.o -T $(SYNTH_DIR)/rom.lds

include $(MK_INCLUDES)

	
