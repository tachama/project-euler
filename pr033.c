/*
 * The fraction 49/98 is a curious fraction, as an inexperienced mathematician
 * in attempting to simplify it may incorrectly believe that 49/98 = 4/8, which
 * is correct, is obtained by cancelling the 9s.
 *
 * We shall consider fractions like, 30/50 = 3/5, to be trivial examples.
 *
 * There are exactly four non-trivial examples of this type of fraction, less
 * than one in value, and containing two digits in the numerator and denominator.
 *
 * If the product of these four fractions is given in its lowest common terms,
 * find the value of the denominator.
 */

#include <stdio.h>

#define START_2DIGITS	10
#define END_2DIGITS	99

static int is_trivial(int, int);
static int is_curious(int, int);
static int common_val(int, int);
static int cancel_val(int, int);

int
main(int argc, char *argv[])
{
	int i, j;
	long numerator, denominator;

	/* find curious number */
	numerator = denominator = 1;
	for (i = START_2DIGITS; i <= END_2DIGITS; i++) {
		for (j = i+1; j <= END_2DIGITS; j++) {
			if (!is_trivial(i, j) && is_curious(i, j)) {
				numerator *= i;
				denominator *= j;
			}
		}
	}

	/* simplify numerator and denominator */
	for (i = 2; i <= numerator; i++) {
		while (numerator % i == 0 && denominator % i == 0) {
			numerator /= i;
			denominator /= i;
		}
	}
	printf("%ld\n", denominator);
	return 0;
}

static int
is_trivial(int num, int den)
{
	if (num % 10 || den % 10)
		return 0;
	else
		return 1;
}

static int
is_curious(int num, int den)
{
	int common, n, d;
	common = common_val(num, den);
	if (common < 0)
		return 0;
	n = cancel_val(num, common);
	d = cancel_val(den, common);
	if (n * den == num * d)
		return 1;
	else
		return 0;
}

/*
 * return n1 and n2 common digit.
 * if n1 and n2 has no common digit. return -1.
 * if n1 and n2 has multiple common digit. return first found digit.
 */
static int
common_val(int n1, int n2)
{
	int digits[10], i;
	for (i = 0; i < 10; i++)
		digits[i] = 0;
	while (n1) {
		digits[n1 % 10]++;
		n1 /= 10;
	}
	while (n2) {
		if (digits[n2 % 10])
			/* found common digit */
			return n2 % 10;
		n2 /= 10;
	}
	/* not found common digit */
	return -1;
}

/*
 * cancal 1 digit from num.
 * if num contain multiple cancael value.
 * only cancel one.
 */
static int
cancel_val(int num, int cancel)
{
	int n = 10;
	while (1) {
		if ((num % n)/(n/10) == cancel)
			return (num / n) * (n / 10) + (num % n) % (n / 10);
		n *= 10;
		if (n > num * 10)
			break;
	}
	/* oops. not found cancel in num */
	return -1;
}

