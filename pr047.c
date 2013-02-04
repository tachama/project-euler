/*
 * The first two consecutive numbers to have two distinct prime factors are:
 *
 *   14 = 2 * 7
 *   15 = 3 * 5
 *
 * The first three consecutive numbers to have three distinct prime factors are:
 *
 *   644 = (2 ** 2) * 7 * 23
 *   645 = 3 * 5 * 43
 *   646 = 2 * 17 * 19
 *
 * Find the first four consecutive integers to have four distinct primes factors.
 * What is the first of these numbers?
 */

#include <err.h>
#include <stdio.h>

#include "prime.c"

#define PRIME_IDX_INIT	0

static int n_distinct_prime_factor(int);
static int next_prime(int, int *);

#define TARGET_NUM	4

int
main(int argc, char *argv[])
{
	int n, cont;

	for (n = 2, cont = 0; cont < TARGET_NUM; n++) {
		if (n_distinct_prime_factor(n) == TARGET_NUM)
			cont++;
		else
			cont = 0;
	}
	printf("%d\n", n - TARGET_NUM);
	return 0;
}


/*
 * return number of distinct prime factor of n
 */
static int
n_distinct_prime_factor(int n)
{
	int pr = 1, npr = 0;
	int idx = PRIME_IDX_INIT;

	while (n > 1) {
		idx = next_prime(idx, &pr);
		if (n % pr == 0) {
			npr++;
			while (n % pr == 0)
				n /= pr;
		}
	}
	return npr;
}


/* ------------------------------------------------------------ */

static int *primes = NULL;
static int nprime = -1;
static int primes_max = 1;

/*
 * return next prime.
 *   idx : index of current prime.
 *   out : next prime number [OUT]
 * return index of next prime.
 */
static int
next_prime(int idx, int *out)
{
	int rv;

	while (idx >= nprime) {
		/* requested prime is out of current */
		if (primes) free(primes);  /* free old primes array */
		primes_max *= 10;
		rv = primes_under(primes_max, &primes, &nprime);
		if (rv)
			errx(1, "fail primes_under(%d)", primes_max);
	}
	*out = primes[idx];
	return (idx + 1);
}

