/****************************************************************************
 * or1k_uex_support.h
 ****************************************************************************/
#ifndef INCLUDED_OR1K_UEX_SUPPORT_H
#define INCLUDED_OR1K_UEX_SUPPORT_H

typedef void (*main_f)(void);

void or1k_uex_init(void);

void or1k_uex_exit(void);

void or1k_uex_entry(main_f f);

#endif /* INCLUDED_OR1K_UEX_SUPPORT_H */
