/*
 * Take the number 192 and multiply it by each of 1, 2, and 3:
 *
 *   192 * 1 = 192
 *   192 * 2 = 384
 *   192 * 3 = 576
 *
 * By concatenating each product we get the 1 to 9 pandigital, 192384576. We will
 * call 192384576 the concatenated product of 192 and (1,2,3)
 *
 * The same can be achieved by starting with 9 and multiplying by 1, 2, 3, 4, and
 * 5, giving the pandigital, 918273645, which is the concatenated product of 9 and
 * (1,2,3,4,5).
 *
 * What is the largest 1 to 9 pandigital 9-digit number that can be formed as the
 * concatenated product of an integer with (1,2, ... , n) where n > 1?
 */

#include <err.h>
#include <stdio.h>

/*
 * the first number decide 9-digit number order.
 * so, start 9876 and decrement the number is goot idea.
 */
#define NUM_START	9876

static int concatnum(int, int);
static int is_pandigital(int);
static int ndigit(int);
static int power(int, int);

int
main(int argc, char *argv[])
{
	int num, concat, i;
	int found = 0;

	for (num = NUM_START; num > 0; num--) {
		concat = 0;
		for (i = 1; ndigit(concat) < 9; i++) {
			concat = concatnum(concat, i * num);
			if (ndigit(concat) == 9 && is_pandigital(concat)) {
				found = 1;
				break;
			}
		}
		if (found)
			break;
	}
	if (!found)
		errx(1, "oops! not found...");
	printf("%d\n", concat);

	return 0;
}

static int
concatnum(int n1, int n2)
{
	return n1 * power(10, ndigit(n2)) + n2;
}

static int
is_pandigital(int num)
{
	unsigned char dig[10];
	int i, mod;
	for (i = 0; i < 10; i++)
		dig[i] = 0;
	while (num) {
		mod = num % 10;
		if (mod == 0)
			/* num is not pandigital */
			return 0;
		if (dig[mod])
			/* digit number is already used */
			return 0;
		dig[mod] = 1;
		num /= 10;
	}
	/* check all digit is used ? */
	for (i = 1; i < 10; i++) {  /* only check 1 to 9 */
		if (dig[i] == 0)
			return 0;
	}
	/* num is pandigital */
	return 1;
}

static int
ndigit(int num)
{
	int digit = 0;
	while (num) {
		digit++;
		num /= 10;
	}
	return digit;
}

static int
power(int base, int p)
{
	int val = 1, i;
	for (i = 0; i < p; i++)
		val *= base;
	return val;
}
