/*
 * It was proposed by Christian Goldbach that every odd composite number can
 * be written as the sum of a prime and twice a square.
 *
 * 9 = 7 + 2 * 1 ^ 2
 * 15 = 7 + 2 * 2 ^ 2
 * 21 = 3 + 2 * 3 ^ 2
 * 25 = 7 + 2 * 3 ^ 2
 * 27 = 19 + 2 * 2 ^ 2
 * 33 = 31 + 2 * 1 ^ 2
 *
 * It turns out that the conjecture was false.
 *
 * What is the smallest odd composite that cannot be written as the sum of a prime
 * and twice a square?
 */

#include <stdio.h>

static int is_prime(int);
static int next_prime(int);
static int can_express(int);

int
main(int argc, char *argv[])
{
	int num;

	for (num = 3; ; num += 2) {
		if (is_prime(num))
			/* skip prime number */
			continue;
		if (!can_express(num))
			/* found target */
			break;
	}
	printf("%d\n", num);
	return 0;
}

static int
is_prime(int n)
{
	int i;
	if (n != 2 && (n & 1) == 0)
		/* even number is not prime */
		return 0;
	for (i = 3; i < n; i += 2) {
		if (n % i == 0)
			return 0;
	}
	return 1;
}

static int
next_prime(int n)
{
	do {
		n++;
	} while (!is_prime(n));
	return n;
}

static int
can_express(int n)
{
	int x, p, i, t;
	for (p = next_prime(1); p < n; p = next_prime(p)) {
		x = n - p;
		for (i = 1; ; i++) {
			t = 2 * i * i;
			if (t > x)
				break;
			if (t == x)
				return 1;
		}
	}
	return 0;
}


