/*
 * The series, 1**1 + 2**2 + 3**3 + ... + 10**10 = 10405071317.
 *
 * Find the last ten digits of the series, 1**1 + 2**2 + 3**3 + ... + 1000**1000.
 */

#include <stdio.h>

static long mypow(int, int);

#define NUM_TARGET	1000
#define NUM_MASK	10000000000L

int
main(int argc, char *argv[])
{
	long answer = 0;
	int i;
	for (i = 1; i <= NUM_TARGET; i++) {
		answer += mypow(i, i);
	}
	answer %= NUM_MASK;  /* get last ten digit */
	printf("%ld\n", answer);
	return 0;
}


static long
mypow(int x, int y)
{
	long ans = 1;
	int i;
	for (i = 0; i < y; i++) {
		ans *= x;
		ans %= NUM_MASK;  /* only get last ten digit */
	}
	return ans;
}
