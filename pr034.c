/*
 * 145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.
 *
 * Find the sum of all numbers which are equal to the sum of the
 * factorial of their digits.
 *
 * Note: as 1! = 1 and 2! = 2 are not sums they are not included.
 */

#include <stdio.h>

static int is_curious(int);
static int factorial(int);

int
main(int argc, char *argv[])
{
	int sum, f9, end, i;

	/* get factorial(9) for end check */
	f9 = factorial(9);
	for (i = 1, end = 10; ;i++, end *= 10) {
		if (end > f9 * i)
			break;
	}

	sum = 0;
	/* not contain 1=1! and 2=2!, so start from 3 */
	for (i = 3; i < end;i++) {
		if (is_curious(i))
			sum += i;
	}
	printf("%d\n", sum);

	return 0;
}


static int
is_curious(int num)
{
	int sum = 0, n = num;
	while (n) {
		sum += factorial(n % 10);
		n /= 10;
	}
	return (num == sum) ? 1 : 0;
}


static int
factorial(int n)
{
	int f = 1, i;
	for (i = 1; i <=n; i++)
		f *= i;
	return f;
}
