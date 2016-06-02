

ifneq (1,$(RULES))

SW_SRC_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

LIBGCC:=$(shell $(CC) -print-libgcc-file-name)
LIBC:=$(dir $(LIBGCC))/../../../../or1k-elf/lib/libc.a
LIBCXX:=$(dir $(LIBGCC))/../../../../or1k-elf/lib/libstdc++.a
LIBOR1K:=$(dir $(LIBGCC))/../../../../or1k-elf/lib/libor1k.a

else # Rules

#********************************************************************
#* Bare-metal C tests
#********************************************************************

BAREMETAL_OBJ=\
	baremetal/start.o \
	baremetal/libc_support.o

$(BUILD_DIR_A)/baremetal/%.elf : baremetal/%.o $(BAREMETAL_OBJ)
	$(Q)$(LD) -o $@ $^ -T $(SW_SRC_DIR)/baremetal/baremetal.lds \
		$(LIBC) $(LIBGCC) # $(LIBOR1K)

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