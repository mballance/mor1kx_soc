
TESTS_SW_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

ifneq (1,$(RULES))
DPI_OBJS_LIBS += or1k_subsys_uvm_tests.o

TESTS_SW_OBJ += $(patsubst %.c,%.o,$(notdir $(wildcard $(TESTS_SW_DIR)/*.c)))
TESTS_SW_OBJ += $(patsubst %.cpp,%.o,$(notdir $(wildcard $(TESTS_SW_DIR)/*.cpp)))

SRC_DIRS += $(TESTS_SW_DIR)

else

or1k_subsys_uvm_tests.o : $(TESTS_SW_OBJ)
	$(Q)$(LD) -r -o $@ $^


endif
