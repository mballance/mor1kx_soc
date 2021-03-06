

ifneq (1,$(RULES))

SW_SRC_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

LIBGCC:=$(shell $(CC) -print-libgcc-file-name -mcompat-delay)
LIBC:=$(dir $(LIBGCC))/../../../../../or1k-elf/lib/compat-delay/libc.a
LIBCXX:=$(dir $(LIBGCC))/../../../../../or1k-elf/lib/compat-delay/libstdc++.a
LIBOR1K:=$(dir $(LIBGCC))/../../../../../or1k-elf/lib/compat-delay/libor1k.a

else # Rules

#********************************************************************
#* Bare-metal C tests
#********************************************************************

BAREMETAL_OBJ=\
	mor1kx_crt0.o \
	baremetal/libc_support.o

$(BUILD_DIR_A)/baremetal/%.elf : \
	baremetal/%.o $(BAREMETAL_OBJ) \
	mor1kx_app.lds mor1kx_soc_boot.elf
	$(Q)$(LD) -o $@ $(filter-out %.lds %.elf,$^) -T mor1kx_app.lds \
		-R mor1kx_soc_boot.elf \
		$(LIBC) $(LIBGCC) # $(LIBOR1K)

#%.lds : $(SW_SRC_DIR)/baremetal/%.lds.h
#	$(Q)$(CC) -E -x c $(CFLAGS) $^ | grep -v '^#' > $@
	
baremetal/%.o : $(SW_SRC_DIR)/baremetal/%.S
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)$(AS) -c -o $@ $(ASFLAGS) -I$(SW_SRC_DIR)/baremetal $^
	
baremetal/%.o : $(SW_SRC_DIR)/baremetal/%.c
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)$(CC) -c -o $@ $(CFLAGS) -I$(SW_SRC_DIR)/baremetal $^
	
#********************************************************************
#* Assembly Tests
#********************************************************************
$(BUILD_DIR_A)/asm/%.elf : asm/%.o
	$(Q)$(LD) -o $@ $^ -T $(SW_SRC_DIR)/asm/asm.lds
	
$(BUILD_DIR)/asm/%.elf : asm/%.o
	$(Q)$(LD) -o $@ $^ -T $(SW_SRC_DIR)/asm/asm.lds

asm/%.o : $(SW_SRC_DIR)/asm/%.S
	echo "SW_SRC_DIR: $(SW_SRC_DIR)"
	$(Q)if test ! -d asm; then mkdir -p asm; fi
	$(Q)$(AS) -c -o $@ $(ASFLAGS) -I$(SW_SRC_DIR)/asm $^

endif
