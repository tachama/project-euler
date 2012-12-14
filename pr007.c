/*
 * Problem 7
 * By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13,
 * we can see that the 6th prime is 13.
 *
 * What is the 10,001st prime number?
 */

#include <stdio.h>

static unsigned long nth_prime(int);

#define TARGET_INDEX	10001
#define FIRST_PRIME	2

int
main(int argc, char *argv[])
{
	printf("%ld\n", nth_prime(TARGET_INDEX));
	return 0;
}

static unsigned long
nth_prime(int idx)
{
	int n = 1, i;
	unsigned long val = 1;

	while (n < idx + 1) {
		val++;
		for (i = FIRST_PRIME; i < val; i++) {
			if (val % i == 0)
				break;
		}
		if (i == val)
			/* found prime, increment index */
			n++;
	}
	return val;
}

