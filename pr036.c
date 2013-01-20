/*
 * The decimal number, 585 = 1001001001b (binary), is palindromic in both bases.
 *
 * Find the sum of all numbers, less than one million, which are palindromic in
 * base 10 and base 2.
 *
 * (Please note that the palindromic number, in either base, may not include
 * leading zeros.)
 */

#include <stdio.h>

#define NUMBER_MAX	1000000

static int palindromic(int, int);

int
main(int argc, char *argv[])
{
	int sum, i;

	sum = 0;
	for (i = 1; i < NUMBER_MAX; i++) {
		if (palindromic(2, i) && palindromic(10, i))
			sum += i;
	}
	printf("%d\n", sum);
	return 0;
}

static int
palindromic(int base, int num)
{
	int n = num, p = 0;

	while (n) {
		p *= base;
		p += n % base;
		n /= base;
	}
	return (num == p) ? 1 : 0;
}
