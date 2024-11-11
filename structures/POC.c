#include <stdlib.h>
#include <stdint.h>


int main() {
	uintptr_t a = (uintptr_t *)malloc(1);
	uintptr_t b = (uintptr_t *)malloc(2);
	uintptr_t c = a;
	c &= b;
	return 0;
}
