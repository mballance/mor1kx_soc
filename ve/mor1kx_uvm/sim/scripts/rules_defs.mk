
ifneq (1,$(RULES))

CFLAGS += -DUSE_SV_BFMS_RW_API
include $(OC_WB_IP)/rtl/wb_dma/fw/rules_defs.mk
include $(SV_BFMS)/api/rules_defs.mk

DPI_OBJS_LIBS += $(LIBWB_DMA_FW) $(LIBSV_BFMS_DPI)

CFLAGS += \
-I$(SV_BFMS)/utils/c

else # Rules

include $(OC_WB_IP)/rtl/wb_dma/fw/rules_defs.mk
include $(SV_BFMS)/api/rules_defs.mk

endif
