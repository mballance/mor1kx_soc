#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "baremetal_defs.h"
#include <stdint.h>

int main(int argc, char **argv) {
//	char *ptr;
//	char tmp[128];
//	int len, i;
	int x;
	volatile uint32_t *ptr = (uint32_t *)0x80002000;

	for (x=4; x<8; x++) {
		*ptr = x;
	}
//	fprintf(stdout, "Hello World\n");

/*
	fprintf(stdout, "Hello World\n");
	fflush(stdout);
	fprintf(stdout, "Hello World\n");
	fflush(stdout);

	ptr = (char *)malloc(4);
	fprintf(stdout, "Hello sprintf %d\n", (int)ptr);
	fflush(stdout);
	for (i=0; i<16; i++) {
		fprintf(stdout, "Hello sprintf %d\n", i);
	}
	fflush(stdout);
 */

	// End the test
//	BAREMETAL_TEST_PASS;

//	while (1) { }

	return 0;
}
