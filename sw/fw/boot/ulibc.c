
#include <string.h>
#include <stdint.h>


void *memset(void *p, int v, uint32_t sz) {
	void *s = p;
	while (sz-- > 0) {
		*((uint8_t *)p) = v;
		p++;
	}
	return s;
}

size_t strlen(const char *s) {
	size_t ret = 0;
	while (*s) {
		ret++;
		s++;
	}
}
