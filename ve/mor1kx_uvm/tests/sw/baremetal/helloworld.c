#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "baremetal_defs.h"

int main(int argc, char **argv) {
	char *ptr;
	char tmp[128];
	int len, i;
//	fprintf(stdout, "Hello World\n");

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

	// End the test
	BAREMETAL_TEST_PASS;

	while (1) { }

	return 0;
}
