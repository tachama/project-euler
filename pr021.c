/*
 * Let d(n) be defined as the sum of proper divisors of n (numbers less than n
 * which divide evenly into n).
 * If d(a) = b and d(b) = a, where a != b, then a and b are an amicable pair and
 * each of a and b are called amicable numbers.
 *
 * For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44,
 * 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4,
 * 71 and 142; so d(284) = 220.
 *
 * Evaluate the sum of all the amicable numbers under 10000.
 */

#include <stdio.h>

#define TARGET_MAX	10000

static int d(int);

int
main(int argc, char *argv[])
{
	int i, j;
	int sum_amicable = 0;
	for (i = 1; i <= TARGET_MAX; i++) {
		j = d(i);
		if (j != i && d(j) == i)
			sum_amicable += i;
	}
	printf("%d\n", sum_amicable);
	return 0;
}

/* function d(n) at this problem */
static int
d(int n)
{
	int sum_divisor = 0,  i;
	for (i = 1; i < n; i++) {
		if (n % i == 0)
			sum_divisor += i;
	}
	return sum_divisor;
}
