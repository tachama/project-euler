/*
 * A perfect number is a number for which the sum of its proper divisors is
 * exactly equal to the number. For example, the sum of the proper divisors
 * of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.
 *
 * A number n is called deficient if the sum of its proper divisors is less than
 * n and it is called abundant if this sum exceeds n.
 *
 * As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest
 * number that can be written as the sum of two abundant numbers is 24.
 * By mathematical analysis, it can be shown that all integers greater than 28123
 * can be written as the sum of two abundant numbers. However, this upper limit
 * cannot be reduced any further by analysis even though it is known that the
 * greatest number that cannot be expressed as the sum of two abundant numbers is
 * less than this limit.
 *
 * Find the sum of all the positive integers which cannot be written as the sum of
 * two abundant numbers.
 */

#include <err.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static int is_abundant(int);

#define TARGET_MAX	28123

int
main(int argc, char *argv[])
{
	int n_abunant, *abundants, idx;
	char *chk_arr;
	int sum, i, j, tmp;

	/* step1: found number of abundant <= 28123 */
	for (n_abunant = 0, i = 1; i <= TARGET_MAX; i++) {
		if (is_abundant(i))
			n_abunant++;
	}

	/* step2: get integer field for abundants */
	abundants = (int *)malloc(sizeof(int) * n_abunant);
	if (!abundants)
		err(1, "fail malloc");

	/* step3: create abundant array */
	for (idx = 0, i = 0; i <= TARGET_MAX; i++) {
		if (is_abundant(i))
			abundants[idx++] = i;
	}

	/* step4: get check arrays */
	chk_arr = (char *)malloc(sizeof(char) * TARGET_MAX);
	if (!chk_arr)
		err(1, "fail malloc");
	memset(chk_arr, 0, sizeof(sizeof(char) * TARGET_MAX));

	/* step5: filtering */
	for (i = 0; i < n_abunant; i++) {
		for (j = 0; j < n_abunant; j++) {
			tmp = abundants[i] + abundants[j];
			if (tmp <= TARGET_MAX)
				chk_arr[tmp - 1] = 1;
		}
	}

	/* step6: calculate sum */
	sum = 0;
	for (i = 0; i < TARGET_MAX; i++) {
		if (chk_arr[i] == 0)
			sum += (i+1);
	}
	printf("%d\n", sum);

	free(chk_arr);
	free(abundants);
	return 0;
}

static int
is_abundant(int num)
{
	int sum_divisor = 0, i;
	for (i = 1; i < num; i++)
		if (num % i == 0)
			sum_divisor += i;
	return (num < sum_divisor);
}



