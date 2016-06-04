#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char **argv) {
	char *ptr;
	char tmp[128];
	int len, i;
//	fprintf(stdout, "Hello World\n");

	write(0, "Hello World\n", 12);
//	do_test();
//	do_test2();
	write(0, "Hello World\n", 12);
	write(0, "Hello World 1\n", 14);
	ptr = (char *)malloc(16);
	sprintf(tmp, "Hello sprintf %p\n", ptr);
	write(0, tmp, strlen(tmp));
	ptr = (char *)malloc(256);
	sprintf(tmp, "Hello sprintf %p\n", ptr);
	write(0, tmp, strlen(tmp));
	write(0, "Hello World 2\n", 14);

	while (1) { }

	return 0;
}
