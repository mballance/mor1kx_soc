
ifneq (1,$(RULES))
MOR1KX_SOC_SW_FW_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

MOR1KX_SOC_SW_FW_SRC_S = \
	mor1kx_fw_boot.S
	
#	mor1kx_libc_support.c \

MOR1KX_SOC_SW_FW_SRC_C = \
	mor1kx_fw.c
	
CFLAGS += -I$(MOR1KX_SOC_SW_FW_DIR)
ASFLAGS += -I$(MOR1KX_SOC_SW_FW_DIR)


else # Rules

mor1kx_soc_fw.elf : \
	$(MOR1KX_SOC_SW_FW_SRC_S:.S=.o) \
	$(MOR1KX_SOC_SW_FW_SRC_C:.c=.o) mor1kx_fw.lds
	$(LD) -o $@ $(filter-out %.lds,$^) -T mor1kx_fw.lds
	
%.o : $(MOR1KX_SOC_SW_FW_DIR)/%.S
	$(Q)$(AS) -c -o $@ $(ASFLAGS) $^
	
%.o : $(MOR1KX_SOC_SW_FW_DIR)/%.c
	$(Q)$(CC) -c -o $@ $(CFLAGS) $^

%.lds : $(MOR1KX_SOC_SW_FW_DIR)/%.lds.h
	$(Q)$(CC) -E -x c $(CFLAGS) $^ | grep -v '^#' > $@
	
	
endif
