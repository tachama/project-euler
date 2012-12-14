/*
 * Problem 6
 * The sum of the squares of the first ten natural numbers is,
 *   1**2 + 2**2 + ... + 10**2 = 385
 * The square of the sum of the first ten natural numbers is,
 *   (1 + 2 + ... + 10) ** 2 = 55 ** 22 = 3025
 *
 * Hence the difference between the sum of the squares of the first ten natural
 * numbers and the square of the sum is 3025 - 385 = 2640.
 *
 * Find the difference between the sum of the squares of the first one hundred
 * natural numbers and the square of the sum.
 */

#include <stdio.h>

int
main(int argc, char *argv[])
{
	unsigned long v1, v2;
	int i;

	for (v1 = 0, i = 1; i <= 100; i++) {
		v1 += i * i;
	}
	for (v2 = 0, i = 1; i <= 100; i++) {
		v2 += i;
	}
	v2 = v2 * v2;
	printf("%ld\n", v2 - v1);

	return 0;
}

