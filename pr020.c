/*
 * n! means n *(n  1) * ... * 3 * 2 * 1
 *
 * For example, 10! = 10 * 9 * ... * 3 * 2 * 1 = 3628800,
 * and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.
 *
 * Find the sum of the digits in the number 100!
 */

#include <stdio.h>

#define TARGET_MAX	100
#define NDIGIT		300  /* 100! is under 100 ** 100 */

int
main(int argc, char *argv[])
{
	char val[NDIGIT];
	int i, j;
	int carry, value;
	int sum;

	/* initialize val */
	for (i = 0; i < NDIGIT; i++)
		val[i] = 0;
	val[0] = 1;

	/* calculate value */
	for (i = 1; i <= TARGET_MAX; i++) {
		carry = 0;
		for (j = 0; j < NDIGIT; j++) {
			value = carry + val[j] * i;
			val[j] = value % 10;
			carry = value / 10;
		}
	}

	/* sum of digit */
	sum = 0;
	for (i = 0; i < NDIGIT; i++)
		sum += val[i];
	printf("%d\n", sum);

	return 0;
}

