
TOP_MODULE=mor1kx_soc_fpga

FAMILY:="Cyclone V"
DEVICE:=5CSXFC6D6F31C8ES

# QPF_FLAGS += +define+ALTERA_DEVICE_FAMILY=\"Cyclone V\"

# DATAFILES += $(BUILD_DIR)/rom.hex
PRE_QPF_TARGETS += rom.hex
# PRE_QPF_TARGETS += hps_AC_ROM.hex hps_inst_ROM.hex

# SIM_PRE_TARGETS += mk_rom

include $(SYNTHSCRIPTS_DIR)/mkfiles/common_synth.mk

# $(BUILD_DIR)/rom.img : mk_rom
#

%.hex : $(SYNTH_DIR)/hps/submodules/%.hex
	cp $^ $@

.phony: mk_rom
rom.hex :
	$(MAKE) -f $(SYNTH_DIR)/scripts/embedded_sw.mk $@




