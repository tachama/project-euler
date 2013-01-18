/*
 * The number, 197, is called a circular prime because all rotations of the
 * digits: 197, 971, and 719, are themselves prime.
 *
 * There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37, 71,
 * 73, 79, and 97.
 *
 * How many circular primes are there below one million?
 */

#include <err.h>
#include <stdio.h>

#include "prime.c"

#define TARGET_MAX	1000000

static int rotation(int);
static int search(int, int *, int, int);

int
main(int argc, char *argv[])
{
	int *prs, pr_len;
	int rv, i, num, is_cp;
	int ncircular;

	/* get primes below target */
	rv = primes_under(TARGET_MAX, &prs, &pr_len);
	if (rv)
		errx(1, "fail primes_under");

	/* find circular prime */
	ncircular = 0;
	for (i = 0; i < pr_len; i++) {
		is_cp = 1;
		num = rotation(prs[i]);
		while (num != prs[i]) {
			if (search(num, prs, 0, pr_len - 1) < 0) {
				/* rotation numbe is not prime */
				is_cp = 0;
				break;
			}
			num = rotation(num);
		}
		if (is_cp)
			ncircular++;
	}

	printf("%d\n", ncircular);
	return 0;
}

/*
 * rotation value
 */
static int
rotation(int num)
{
	int d, m;

	m = num % 10;
	num = num / 10;
	if (num == 0)
		/* num is single-digit value */
		return m;
	for (d = 10; num / d; d *= 10)
		/* found digits */
		;
	num += m * d;
	return num;
}


/*
 * binary search function.
 * return positive value as index if found.
 * return netative if not found.
 */
static int
search(int n, int *ns, int i1, int i2)
{
	int i;
	if (i1 > i2)
		/* not found */
		return -1;
	i = (i1+i2)/2;
	if (n > ns[i])
		return search(n, ns, i+1, i2);
	else if (n < ns[i])
		return search(n, ns, i1, i2-1);
	else
		/* n == ns[i]; found value */
		return i;
}

