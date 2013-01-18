/*
 * prime number module
 *
 * for test this module, compile with PRIMES_TEST macro.
 *   ex $ gcc -DPRIMES_TEST prime.c
 */

#include <stdlib.h>
#include <string.h>

/* for use primes_under() */
#define CLEAR(p,i,b)	p[(i)/(b)] &= ~(1<<((i)%(b)))
#define ISSET(p,i,b)	(p[(i)/(b)] & (1<<((i)%(b))))

/*
 * get array of primes under *max*. not contain *max*
 * *out* and *len* is out argument.
 * *out* is array of primes.
 * *len* is length of *out* array.
 *
 * NOTE: don't forget free(*out*)
 */
static int
primes_under(int max, int **out, int *len)
{
	size_t sz, bits;
	int *tmp, *outp, i, j, cnt, idx;

	/* get size of int type */
	bits = sizeof(int) * 8;  /* bits in a integer */
	sz = (max + bits -1) / bits;

	/* allocate work field */
	tmp = (int *)malloc(sizeof(int) * sz);
	if (!tmp)
		/* fail malloc. maybe max is too large */
		return 1;
	memset(tmp, 0xff, sizeof(int) * sz);

	cnt = 0;
	CLEAR(tmp, 0, bits);
	CLEAR(tmp, 1, bits);
	for (i = 2; i < max; i++) {
		if (ISSET(tmp, i, bits)) {
			cnt++;
			for (j = 2 * i; j < max; j += i)
				CLEAR(tmp, j, bits);
		}
	}

	/* get memory for out */
	outp = (int *)malloc(sizeof(int) * cnt);
	if (!outp) {
		free(tmp);
		return 1;
	}
	idx = 0;
	for (i = 0; i < max; i++) {
		if (ISSET(tmp, i, bits))
			outp[idx++] = i;
	}

	free(tmp);
	*out = outp;
	*len = cnt;
	return 0;  /* success create prime */
}
#undef CLEAR
#undef ISSET

/* ------------------------------------------------------------ */

#ifdef PRIMES_TEST
/* main function for testing this file */
#include <err.h>
#include <stdio.h>
#define TEST_PRIME_MAX	1024
int
main(int argc, char *argv[])
{
	int *pr, len, i;
	/* found primes under TEST_PRIME_MAX */
	if (primes_under(TEST_PRIME_MAX, &pr, &len))
		errx(1, "fail primes_under()");
	printf("primes under %d (%d): ", TEST_PRIME_MAX, len);
	for (i = 0; i < len; i++)
		printf("%d ", pr[i]);
	putchar('\n');
	free(pr);
	return 0;
}
#endif	/* PRIMES_TEST */
