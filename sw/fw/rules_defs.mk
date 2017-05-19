
ifneq (1,$(RULES))
ARCH:=or1k-elf-
OBJCOPY := $(ARCH)objcopy
OBJDUMP := $(ARCH)objdump
NM := $(ARCH)nm

MOR1KX_SOC_SW_FW_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

MOR1KX_SOC_SW_FW_SRC_S = \
	mor1kx_fw_boot.S
	
#	mor1kx_libc_support.c \

MOR1KX_SOC_SW_FW_SRC_C = \
	mor1kx_fw.c \
	ulibc.c 
	
#CFLAGS += -I$(MOR1KX_SOC_SW_FW_DIR)
#ASFLAGS += -I$(MOR1KX_SOC_SW_FW_DIR)

SRC_DIRS += $(MOR1KX_SOC_SW_FW_DIR)

else # Rules


mor1kx_soc_boot.elf : \
	$(MOR1KX_SOC_SW_FW_SRC_S:.S=.o) \
	$(MOR1KX_SOC_SW_FW_SRC_C:.c=.o) \
	libvmon_monitor.o \
    mor1kx_boot.lds
	$(LD) -o $@ $(filter-out %.lds,$^) -T mor1kx_boot.lds
	$(NM) $@ | grep -w T | grep -v 'T _' | \
		sed -e 's/\([0-9a-f][0-9a-f]*\) T \([_a-zA-Z0-9][_a-zA-Z0-9]*\)/\2 = \1;/g' > $@.syms
	
#%.o : $(MOR1KX_SOC_SW_FW_DIR)/%.S
#	$(Q)$(AS) -c -o $@ $(ASFLAGS) $^
	
#%.o : $(MOR1KX_SOC_SW_FW_DIR)/%.c
#	$(Q)$(CC) -c -o $@ $(CFLAGS) $^

%.lds : $(MOR1KX_SOC_SW_FW_DIR)/%.lds.h
	$(Q)$(CC) -E -x c $(CFLAGS) $^ | grep -v '^#' > $@

	
endif
