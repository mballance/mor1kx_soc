
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
	
MOR1KX_VMON_MAIN_DPI = mor1kx_vmon_main_dpi.o
LIBMOR1KX_VMON_MAIN = libmor1kx_vmon_main.o

LIBMOR1KX_VMON_MAIN_SRC = $(notdir $(wildcard $(MOR1KX_SOC_SW_FW_DIR)/*.c))
	
#CFLAGS += -I$(MOR1KX_SOC_SW_FW_DIR)
#ASFLAGS += -I$(MOR1KX_SOC_SW_FW_DIR)

SRC_DIRS += $(MOR1KX_SOC_SW_FW_DIR) $(MOR1KX_SOC_SW_FW_DIR)/sv

else # Rules

libmor1kx_vmon_main.o : $(LIBMOR1KX_VMON_MAIN_SRC:.c=.o)
	$(Q)rm -f $@
	$(Q)$(LD) -r -o $@ $(LIBMOR1KX_VMON_MAIN_SRC:.c=.o)

mor1kx_soc_boot.elf : \
	$(MOR1KX_SOC_SW_FW_SRC_S:.S=.o) \
	$(MOR1KX_SOC_SW_FW_SRC_C:.c=.o) \
	libvmon_monitor.o \
    mor1kx_boot.lds
	$(LD) -o $@ $(filter-out %.lds,$^) -T mor1kx_boot.lds

%.elf.syms : %.elf
	$(NM) $^ | egrep -w -e 'B|T' | grep -v -e '(B|T) _' | \
		sed -e 's/\([0-9a-f][0-9a-f]*\) [BT] \([_a-zA-Z0-9][_a-zA-Z0-9]*\)/\2 = 0x\1;/g' > $@

	
#%.o : $(MOR1KX_SOC_SW_FW_DIR)/%.S
#	$(Q)$(AS) -c -o $@ $(ASFLAGS) $^
	
#%.o : $(MOR1KX_SOC_SW_FW_DIR)/%.c
#	$(Q)$(CC) -c -o $@ $(CFLAGS) $^

%.lds : $(MOR1KX_SOC_SW_FW_DIR)/%.lds.h
	$(Q)$(CC) -E -x c $(CFLAGS) $^ | grep -v '^#' > $@

	
endif
