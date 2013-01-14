/*
 * Euler published the remarkable quadratic formula:
 *
 *   n ** 2 + n + 41
 *
 * It turns out that the formula will produce 40 primes for the consecutive
 * values n = 0 to 39. However, when n = 40, 40 ** 2 + 40 + 41 = 40(40 + 1) + 41
 * is divisible by 41, and certainly when n = 41, 41 ** 2 + 41 + 41 is clearly
 * divisible by 41.
 *
 * Using computers, the incredible formula  n ** 2 - 79 * n + 1601 was discovered,
 * which produces 80 primes for the consecutive values n = 0 to 79. The product
 * of the coefficients, -79 and 1601, is -126479.
 *
 * Considering quadratics of the form:
 *
 *   n ** 2 + a * n + b, where |a| < 1000 and |b| < 1000
 *
 *   where |n| is the modulus/absolute value of n
 *   e.g. |11| = 11 and |4| = 4
 *
 * Find the product of the coefficients, a and b, for the quadratic expression
 * that produces the maximum number of primes for consecutive values of n,
 * starting with n = 0.
 */

#include <stdio.h>

#define MAX_ABS_A	1000
#define MAX_ABS_B	1000

static int produce_primes(int, int);
static int is_prime(int);

int
main(int argc, char *argv[])
{
	int a, b, max_primes, coefficients, m;
	max_primes = -1;  /* initial value */
	for (a = (-1) * MAX_ABS_A + 1; a < MAX_ABS_A; a++) {
		for (b = (-1) * MAX_ABS_B + 1; b < MAX_ABS_B; b++) {
			m = produce_primes(a, b);
			if (m > max_primes) {
				max_primes = m;
				coefficients = a * b;
			}
		}
	}
	printf("%d\n", coefficients);
	return 0;
}

static int
produce_primes(int a, int b)
{
	int n, loop;

	n = -1;  /* initial value */
	loop = 1;
	while (loop) {
		n++;
		loop = is_prime(n * n + a * n + b);
	}
	return n;
}

static int
is_prime(int num)
{
	int i;
	if (num < 2)
		/* negative value is non-prime */
		return 0;
	for (i = 2; i < num; i++) {
		if (num % i == 0)
			/* not prime */
			return 0;
	}
	return 1;
}
