
#include <stdlib.h>
#include <sys/types.h>
#include <reent.h>
#include <stdint.h>

struct _reent *__ATTRIBUTE_IMPURE_PTR__ _or1k_current_impure_ptr = 0;

struct _reent *_or1k_libc_getreent(void) {
	return _or1k_current_impure_ptr;
}

static void *heap = 0;

extern unsigned char end;

void *_sbrk_r(struct _reent *reent, ptrdiff_t incr) {

	// lock/disable interrupts

	unsigned char *prev_heap;

	if (heap == 0) {
		// initialize
		heap = &end;
	}
	prev_heap = heap;

	heap += incr;

	// unlock/disable interrupts
	return prev_heap;
}

void _ir1k_init() {

}

uint32_t or1k_critical_begin(void) {
	uint32_t iee = 0; // interrupts_disable();
	uint32_t tee = 0; // timer_disable

	return (iee << 1) | tee;
}

void or1k_critical_end(uint32_t restore) {
//	or1k_timer_restore(restore & 0x1);
//	or1k_interrupts_restore((restore >> 1) & 0x1);
}

// Locking primitive
uint32_t or1k_sync_cas(void *address, uint32_t compare, uint32_t swap) {
	return 0; // TODO:
}

_ssize_t _read_r(struct _reent *ptr, int fd, void *buf, size_t cnt) {
	return cnt;
}

_ssize_t _write_r(struct _reent *ptr, int fd, const void *buf, size_t cnt) {
	if (fd == 0) {
		// write to the UART
	}
}

int _close_r(struct _reent *ptr, int fd) {
	return 0;
}

int _isatty_r(struct _reent  *ptr, int fd) {
	return 0;
}

int _fstat_r(struct _reent *ptr, int fd, struct stat *sbuf) {
	return 0;
}

_off_t _lseek_r(struct _reent *ptr, int fd, _off_t off, int flags) {
	return 0;
}

