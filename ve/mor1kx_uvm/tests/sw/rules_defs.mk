

ifneq (1,$(RULES))

SW_SRC_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

else # Rules

$(BUILD_DIR_A)/asm/%.elf : asm/%.o
	$(Q)$(LD) -o $@ $^ -T $(SW_SRC_DIR)/asm/asm.lds
	
$(BUILD_DIR)/asm/%.elf : asm/%.o
	$(Q)$(LD) -o $@ $^ -T $(SW_SRC_DIR)/asm/asm.lds

asm/%.o : $(SW_SRC_DIR)/asm/%.S
	echo "SW_SRC_DIR: $(SW_SRC_DIR)"
	$(Q)if test ! -d asm; then mkdir -p asm; fi
	$(Q)$(AS) -c -o $@ $(ASFLAGS) -I$(SW_SRC_DIR)/asm $^

endif