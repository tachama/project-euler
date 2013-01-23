/*
 * An irrational decimal fraction is created by concatenating the positive
 * integers:
 *
 *   0.12345678910 1 112131415161718192021...
 *
 * It can be seen that the 12-th digit of the fractional part is 1.
 *
 * If d(n) represents the n-th digit of the fractional part, find the value of
 * the following expression.
 *
 *   d(1) * d(10) * d(100) * d(1000) * d(10000) * d(100000) * d(1000000)
 */

#include <err.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define NARRAY(a)	(sizeof(a)/sizeof(a[0]))
#define MARGIN		100

int
main(int argc, char *argv[])
{
	const int targets[] = {1, 10, 100, 1000, 10000, 100000, 1000000};
	char *cp, *ep, *c;
	int n, product, i;
	size_t sz;

	/* length of char buffer */
	sz = targets[NARRAY(targets) - 1] + MARGIN;
	cp = (char *)malloc(sz);
	if (!cp)
		err(1, "fail malloc");
	memset(cp, 0, sz + 1);
	c = cp;
	ep = cp + sz - 1;

	n = 1;
	while (c < ep) {
		c += snprintf(c, ep - c, "%d", n++);
	}

	product = 1;
	for (i = 0; i < NARRAY(targets); i++)
		product *= cp[targets[i] - 1] - '0';
	printf("%d\n", product);
	return 0;
}
