/*
 * Surprisingly there are only three numbers that can be written as the sum of
 * fourth powers of their digits:
 *
 *   1634 = 1**4 + 6**4 + 3**4 + 4**4
 *   8208 = 8**4 + 2**4 + 0**4 + 8**4
 *   9474 = 9**4 + 4**4 + 7**4 + 4**4
 *
 * As 1 = 1**4 is not a sum it is not included.
 *
 * The sum of these numbers is 1634 + 8208 + 9474 = 19316.
 *
 * Find the sum of all the numbers that can be written as the sum of fifth powers
 * of their digits.
 */

#include <stdio.h>

static int is_sum_of_fifth_powers(int);
static int powers(int, int);
static int may_last(int);

int
main(int argc, char *argv[])
{
	long sum = 0;
	int num = 1;

	while (1) {
		/* 1**5 is not included, so start num=2 */
		num++;
		if (is_sum_of_fifth_powers(num))
			sum += num;
		if (may_last(num))
			break;  /* break while-loop */
	}
	printf("%ld\n", sum);
	return 0;
}

static int
is_sum_of_fifth_powers(int num)
{
	int p = 0, n = num;
	while (n) {
		p += powers(n % 10, 5);
		n /= 10;
	}
	return (p == num);
}

static int
powers(int num, int power)
{
	int ans = 1, i;
	for (i = 0; i < power; i++)
		ans *= num;
	return ans;
}

static int
may_last(int num)
{
	int digits = 0, i;
	/* get digits of num */
	for (i = num; i > 0; i /= 10)
		digits++;
	/* only check 10...0 */
	if (num != powers(10, digits-1))
		return 0;
	return (num > powers(9, 5) * digits);
}
