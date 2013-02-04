/*
 * The arithmetic sequence, 1487, 4817, 8147, in which each of the terms increases
 * by 3330, is unusual in two ways: (i) each of the three terms are prime, and,
 * (ii) each of the 4-digit numbers are permutations of one another.
 *
 * There are no arithmetic sequences made up of three 1-, 2-, or 3-digit primes,
 * exhibiting this property, but there is one other 4-digit increasing sequence.
 *
 * What 12-digit number do you form by concatenating the three terms in this
 * sequence?
 */

#include <err.h>
#include <stdio.h>
#include <string.h>

#include "prime.c"

static int search(int, int *, int);
static int same_digs(int, int);

int
main(int argc, char *argv[])
{
	int a, b, c;
	int *primes, nprime;
	int rv;

	/* get all primes under 10000 */
	rv = primes_under(10000, &primes, &nprime);
	if (rv)
		errx(1, "fail primes_under()");

	/* skip primes under 1000 */
	for (a = 0; primes[a] < 1000; a++);

	for (; a < nprime; a++) {
		for (b = a + 1; b < nprime; b++) {
			c = primes[b] + (primes[b] - primes[a]);
			if (search(c, primes, nprime) == -1) {
				/* if c is not prime, skip it */
				continue;
			}
			if (same_digs(primes[a], primes[b]) &&
			    same_digs(primes[b], c)) {
				if (primes[a] != 1487)
					/* found answer, go out */
					goto out;
			}
		}
	}
out:
	printf("%d%d%d\n", primes[a], primes[b], c);

	free(primes);  /* free prime array at heap */
	return 0;
}


static int
search(int target, int *array, int len)
{
	int idx1 = 0, idx2 = len - 1, idx;
	while (idx1 <= idx2) {
		idx = (idx1 + idx2) /2;
		if (array[idx] == target)
			/* found target num */
			return idx;
		if (array[idx] < target)
			idx1 = idx + 1;
		else
			idx2 = idx - 1;
	}
	/* not found number */
	return -1;
}


static int
same_digs(int n1, int n2)
{
	char dig1[10], dig2[10];
	int i;

	memset(dig1, 0, sizeof(dig1));
	memset(dig2, 0, sizeof(dig2));

	while (n1) {
		dig1[n1 % 10]++;
		n1 /= 10;
	}
	while (n2) {
		dig2[n2 % 10]++;
		n2 /= 10;
	}
	for (i = 0; i < 10; i++) {
		if (dig1[i] != dig2[i])
			/* different digit */
			return 0;
	}
	/* n1 and n2 has same digit */
	return 1;
}
