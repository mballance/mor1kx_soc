/****************************************************************************
 * or1k-support.h
 *
 * Subsystem-level stub for the API exposed by or1k-support.h
 ****************************************************************************/
#ifndef INCLUDED_OR1K_SUPPORT_H
#define INCLUDED_OR1K_SUPPORT_H
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

void or1k_mtspr (uint32_t spr, uint32_t value);

uint32_t or1k_mfspr (uint32_t spr);

#ifdef __cplusplus
}
#endif

#endif /* INCLUDED_OR1K_SUPPORT_H */
