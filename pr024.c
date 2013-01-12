/*
 * A permutation is an ordered arrangement of objects. For example, 3124 is one
 * possible permutation of the digits 1, 2, 3 and 4. If all of the permutations
 * are listed numerically or alphabetically, we call it lexicographic order.
 * The lexicographic permutations of 0, 1 and 2 are:
 *
 *   012   021   102   120   201   210
 *
 * What is the millionth lexicographic permutation of the
 * digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?
 */

#include <stdio.h>

static int permutations(int);
static int pickupnum(int *, int);

#define TARGET		1000000
#define NDIGIT		10

int
main(int argc, char *argv[])
{
	int order = TARGET - 1;
	int digits[NDIGIT];
	int n, val;
	long answer;

	/* initialize digits array */
	for (n = 0; n < NDIGIT; n++)
		digits[n] = 1;

	answer = 0;
	for (n = 9; n >= 0; n--) {
		val = permutations(n);
		answer = answer * 10 + pickupnum(digits, order / val);
		order = order % val;
	}
	printf("%ld\n", answer);

	return 0;
}

static int
permutations(int n)
{
	int p = 1, i;
	for (i = 1; i <= n; i++)
		p *= i;
	return p;
}

static int
pickupnum(int *nums, int idx)
{
	int i;
	for (i = 0; i < NDIGIT; i++) {
		if (nums[i]) {
			if (idx == 0) {
				nums[i] = 0;
				break;
			}
			idx--;
		}
	}
	return i;
}
