/*
 * Problem 3
 *
 * The prime factors of 13195 are 5, 7, 13 and 29.
 * What is the largest prime factor of the number 600851475143 ?
 */

#include <stdio.h>

#define TARGET_NUM	600851475143UL

static unsigned long next_prime(unsigned long);
static int is_prime(unsigned long);

int
main(int argc, char *argv[])
{
	unsigned long num = TARGET_NUM;
	unsigned long prime;

	prime = 1;
	while (num > 1) {
		prime = next_prime(prime);
		while (num % prime == 0)
			num /= prime;
	}
	printf("%ld\n", prime);

	return 0;
}

static unsigned long
next_prime(unsigned long p)
{
	unsigned long next = p;
	do {
		next += 1;
	} while (!is_prime(next));
	return next;
}

static int
is_prime(unsigned long n)
{
	unsigned long i;
	for (i = 2; i < n - 1; i++) {
		if (n % i == 0)
			return 0;  /* n is not prime */
	}
	return 1;  /* n is prime */
}
