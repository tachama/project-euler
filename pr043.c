/*
 * The number, 1406357289, is a 0 to 9 pandigital number because it is made up of
 * each of the digits 0 to 9 in some order, but it also has a rather interesting
 * sub-string divisibility property.
 *
 * Let d(1) be the 1st digit, d(2) be the 2nd digit, and so on. In this way, we
 * note the following:
 *
 *   d(2)d(3)d(4)=406 is divisible by 2
 *   d(3)d(4)d(5)=063 is divisible by 3
 *   d(4)d(5)d(6)=635 is divisible by 5
 *   d(5)d(6)d(7)=357 is divisible by 7
 *   d(6)d(7)d(8)=572 is divisible by 11
 *   d(7)d(8)d(9)=728 is divisible by 13
 *   d(8)d(9)d(10)=289 is divisible by 17
 *
 * Find the sum of all 0 to 9 pandigital numbers with this property.
 */

#include <err.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct digits {
#define NDIGIT		10
#define DIGIT_ON	1
#define DIGIT_OFF	0
	unsigned char	dig[NDIGIT];
} digits_t;

static int has_property(const char *);
static int threenum(const char *);
static void num2str(long, char *);

static int dig2longs(digits_t *, long **, int *);
static void dig2longs_sub(digits_t *, long *, int, int);
static int ndigit(digits_t *);



int
main(int argc, char *argv[])
{
	int nlen, i;
	long *n, sum = 0L;
	digits_t alldig = { {1,1,1,1,1,1,1,1,1,1} };
	char buf[NDIGIT+1];

	/* get all pandigital number of 0 to 9 */
	if (dig2longs(&alldig, &n, &nlen))
		errx(1, "fail dig2longs");
	for (i = 0; i < nlen; i++) {
		num2str(n[i], buf);
		if (has_property(buf))
			sum += n[i];
	}
	free(n);

	printf("%ld\n", sum);
	return 0;
}


/*
 * check num satisfy problem property
 */
static int
has_property(const char *num)
{
	static int primes[] = {2,3,5,7,11,13,17};
	int i;

	for (i = 0; i < 7; i++) {
		if (threenum(num+i+1) % primes[i])
			return 0;
	}
	return 1;
}

static int
threenum(const char *digs)
{
	int n = 0, i;
	for (i = 0; i < 3; i++)
		n = n * 10 + digs[i] - '0';
	return n;
}

static void
num2str(long n, char *c)
{
	int i;
	c[NDIGIT] = '\0';  /* null terminate */
	for (i = NDIGIT - 1; i >= 0; i--) {
		c[i] = n % 10 + '0';
		n = n / 10;
	}
}



/*
 * return array of number combinated by dig.
 * DON'T FORGET FREE OUT
 */
static int
dig2longs(digits_t *dig, long **out, int *len)
{
	int i, n, sz;
	long *longs;

	n = ndigit(dig);
	for (i = 1, sz = 1; i <= n; i++)
		sz *= i;
	longs = (long *)malloc(sizeof(long) * sz);
	if (!longs)
		return 1;
	memset(longs, 0, sizeof(long) * sz);

	dig2longs_sub(dig, longs, n, sz);

	*out = longs;
	*len = sz;
	return 0;
}

/*
 * subroutine for dig2longs
 */
static void
dig2longs_sub(digits_t *dig, long *nums, int n, int sz)
{
	digits_t d;
	long *np;
	int i, j;

	/* copy dig to d */
	memcpy(&d, dig, sizeof(digits_t));
	for (i = 0, np = nums; i < NDIGIT; i++) {
		if (d.dig[i]) {
			for (j = 0; j < sz / n; j++)
				np[j] = np[j] * 10 + i;
			d.dig[i] = 0;
			dig2longs_sub(&d, np, n-1, sz/n);
			d.dig[i] = 1;
			np += sz/n;
		}
	}
}

/*
 * number of digit at given digit_t
 */
static int
ndigit(digits_t *dig)
{
	int i, nd;
	for (i = 0, nd = 0; i < NDIGIT; i++)
		if (dig->dig[i])
			nd++;
	return nd;
}
