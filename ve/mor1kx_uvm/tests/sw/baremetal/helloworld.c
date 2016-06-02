#include <stdio.h>

int main(int argc, char **argv) {
//	fprintf(stdout, "Hello World\n");

	*((volatile unsigned int *)0x80000000) = 'H';
	*((volatile unsigned int *)0x80000000) = 'e';
	*((volatile unsigned int *)0x80000000) = 'l';
	*((volatile unsigned int *)0x80000000) = 'l';
	*((volatile unsigned int *)0x80000000) = 'o';
	*((volatile unsigned int *)0x80000000) = '\n';

	while (1) { }

	return 0;
}
