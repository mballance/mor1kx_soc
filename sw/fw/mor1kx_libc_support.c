
#include <stdlib.h>
#include <sys/types.h>
#include <reent.h>
#include <stdint.h>
#include <string.h>

static int _initialized = 0;
static struct _reent *__ATTRIBUTE_IMPURE_PTR__ _or1k_current_impure_ptr;
static struct _reent __ATTRIBUTE_IMPURE_PTR__ _or1k_current_impure_data;
static struct _reent *__ATTRIBUTE_IMPURE_PTR__ _or1k_exception_impure_ptr;

extern char __init_array_start;
extern char __init_array_end;

void pre_main(void) {
	char *ptr = &__init_array_start;

	while (ptr != &__init_array_end) {
		void (*f)(void) = (void (*)(void))ptr;
		f();
	}
}

struct _reent *_or1k_libc_getreent(void) {
//	return 0;
//	return _impure_ptr;

//	return 0;
	if (!_initialized) {
		_REENT_INIT_PTR(_impure_ptr);
////		_REENT_INIT_PTR(_or1k_exception_impure_ptr);
		_or1k_current_impure_ptr = _impure_ptr;
//
//		_REENT_INIT_PTR(&_or1k_current_impure_data);
//		memset(&_or1k_current_impure_data, 0, sizeof(_or1k_current_impure_data));
		_initialized = 1;
	}
//	return _or1k_current_impure_ptr;
	return _impure_ptr;
//	return &_or1k_current_impure_data;
}

extern unsigned char heap;
static void *heap_ptr = 0;

static char tmp[256];
void *_sbrk_r(struct _reent *reent, ptrdiff_t incr) {

	// lock/disable interrupts

	unsigned char *prev_heap;

	if (heap_ptr == 0) {
		// initialize
		heap_ptr = &heap;
	}
	prev_heap = heap_ptr;

	heap_ptr += incr;

//	sprintf(tmp, "prev_heap: %p\n", prev_heap);
//	write(0, tmp, strlen(tmp));

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
	// TODO: use UART device for output
	if (fd == 1 || fd == 2) {
		int i;
		// write to the UART
		const char *p = (const char *)buf;
		for (i=0; i<cnt; i++) {
			*((volatile unsigned int *)0x80000000) = p[i];
		}
		return cnt;
	} else {
		return 0;
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

