/*
 * We shall say that an n-digit number is pandigital if it makes use ofall the
 * digits 1 to n exactly once. For example, 2143 is a 4-digit pandigital and is
 * also prime.
 *
 * What is the largest n-digit pandigital prime that exists?
 */

#include <err.h>
#include <stdio.h>

#include "prime.c"

/*
 * Memo
 * it is ok because less than INT_MAX is 2147483647 defined int <limits.h>
 */
#define NUM_MAX		1000000000

static int pandigital(int);

int
main(int argc, char *argv[])
{
	int *prs, pr_len;
	int i;

	/* get all primes under 10-digit */
	if (primes_under(NUM_MAX, &prs, &pr_len))
		errx(1, "fail primes_under()");

	/* find largest n-digit number */
	for (i = pr_len - 1; i >= 0; i--) {
		if (pandigital(prs[i]))
			break;
	}
	if (i < 0)
		errx(1, "oops, not found...");
	printf("%d\n", prs[i]);
	return 0;
}

static int
pandigital(int num)
{
	char dig[10] = {0,0,0,0,0,0,0,0,0,0};
	int mod, ndig, i;

	ndig = 0;
	while (num) {
		mod = num % 10;
		if (mod == 0)
			return 0;
		if (dig[mod])
			return 0;
		dig[mod] = 1;
		num /= 10;
		ndig++;
	}

	for (i = 1; i <= ndig; i++) {
		if (dig[i] == 0)
			return 0;
	}
	return 1;
}
