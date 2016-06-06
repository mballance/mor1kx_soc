#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "baremetal_defs.h"

int main(int argc, char **argv) {
	char *ptr;
	char tmp[128];
	int len, i;
//	fprintf(stdout, "Hello World\n");

	write(0, "Hello World\n", 12);
//	do_test();
//	do_test2();
	write(0, "Hello World\n", 12);
	ptr = (char *)malloc(4);
	sprintf(tmp, "Hello sprintf %d\n", (int)ptr);
	write(0, tmp, strlen(tmp));
	write(0, "Hello World 1\n", 14);
	for (i=0; i<16; i++) {
		sprintf(tmp, "Hello sprintf %d\n", i);
		write(0, tmp, strlen(tmp));
	}

	write(0, tmp, strlen(tmp));
	ptr = (char *)malloc(256);
	sprintf(tmp, "Hello sprintf %p\n", ptr);
	write(0, tmp, strlen(tmp));
	write(0, "Hello World 2\n", 14);

	// End the test
	BAREMETAL_TEST_PASS;

	while (1) { }

	return 0;
}
