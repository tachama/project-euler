/*
 * We shall say that an n-digit number is pandigital if it makes use of all the
 * digits 1 to n exactly once; for example, the 5-digit number, 15234, is 1
 * through 5 pandigital.

 * The product 7254 is unusual, as the identity, 39 * 186 = 7254, containing
 * multiplicand, multiplier, and product is 1 through 9 pandigital.
 *
 * Find the sum of all products whose multiplicand/multiplier/product identity can
 * be written as a 1 through 9 pandigital.
 *
 * HINT: Some products can be obtained in more than one way so be sure to only
 * include it once in your sum.
 */

#include <err.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* typedef digit choice seed as "seed_t" */
typedef int seed_t;
#define SEED_START	1
#define SEED_END	0

typedef struct digits {
#define NDIGIT		9
#define DIGIT_ON	1
#define DIGIT_OFF	0
	unsigned char	dig[NDIGIT];
} digits_t;
static const digits_t alldig = { {1,1,1,1,1,1,1,1,1} };

static int ndigit(digits_t *);
static void get_digits(digits_t *, seed_t *, const digits_t *, int);
static void rev_digits(digits_t *, digits_t *, const digits_t *);
static int dig2ints(digits_t *, int **, int *);
static void dig2ints_sub(digits_t *, int *, int, int);
static int can_mult(digits_t *, int);

int
main(int argc, char *argv[])
{
	digits_t dig_c, dig_ab;
	seed_t sd = SEED_START;
	int *cs, cslen, i, sum;

	memset(&dig_c, 0, sizeof(digits_t));
	while (sd != SEED_END) {
		/* get digit pattern of c */
		get_digits(&dig_c, &sd, &alldig, NDIGIT);
		rev_digits(&dig_c, &dig_ab, &alldig);

		/* only 4-digit c is satisfy problem condition */
		if (ndigit(&dig_c) != 4)
			continue;

		/* get number-c array with given pattern */
		if (dig2ints(&dig_c, &cs, &cslen))
			errx(1, "fail dig2ints");
		for (i = 0; i < cslen; i++) {
			if (can_mult(&dig_ab, cs[i]))
				sum += cs[i];
		}
		free(cs);
	}

	printf("%d\n", sum);
	return 0;
}

static int
ndigit(digits_t *dig)
{
	int i, nd;
	for (i = 0, nd = 0; i < NDIGIT; i++)
		if (dig->dig[i])
			nd++;
	return nd;
}

static void
get_digits(digits_t *dig, seed_t *seed, const digits_t *mask, int nd)
{
	seed_t s = *seed;
	int i;

	for (i = 0; i < NDIGIT; i++) {
		if (mask->dig[i]) {
			dig->dig[i] = (s & 1) ? 1 : 0;
			s = s >> 1;
		}
	}
	*seed = (*seed + 1) % ((1<<nd) - 1);
}

static void
rev_digits(digits_t *src, digits_t *rev, const digits_t *mask)
{
	int i;
	for (i = 0; i < NDIGIT; i++) {
		if (mask->dig[i])
			rev->dig[i] = src->dig[i] ? 0 : 1;
		else
			rev->dig[i] = 0;
	}
}

/*
 * return array of number combinated by dig.
 * DON'T FORGET FREE OUT
 */
static int
dig2ints(digits_t *dig, int **out, int *len)
{
	int i, n, sz;
	int *ints;

	n = ndigit(dig);
	for (i = 1, sz = 1; i <= n; i++)
		sz *= i;
	ints = (int *)malloc(sizeof(int) * sz);
	if (!ints)
		return 1;
	memset(ints, 0, sizeof(int) * sz);

	dig2ints_sub(dig, ints, n, sz);

	*out = ints;
	*len = sz;
	return 0;
}

static void
dig2ints_sub(digits_t *dig, int *nums, int n, int sz)
{
	digits_t d;
	int *np;
	int i, j;

	/* copy dig to d */
	memcpy(&d, dig, sizeof(digits_t));
	for (i = 0, np = nums; i < NDIGIT; i++) {
		if (d.dig[i]) {
			for (j = 0; j < sz / n; j++)
				np[j] = np[j] * 10 + (i+1);
			d.dig[i] = 0;
			dig2ints_sub(&d, np, n-1, sz/n);
			d.dig[i] = 1;
			np += sz/n;
		}
	}
}


static int
can_mult(digits_t *dig_ab, int c)
{
	digits_t dig_a, dig_b;
	seed_t sd = SEED_START;
	int *as, *bs, aslen, bslen;
	int i, j, found = 0, nd, nd_a;

	/* found number of available digits in dig_ab */
	nd = ndigit(dig_ab);

	memset(&dig_a, 0, sizeof(digits_t));
	memset(&dig_b, 0, sizeof(digits_t));
	while ((sd != SEED_END) && (!found)) {
		get_digits(&dig_a, &sd, dig_ab, nd);
		rev_digits(&dig_a, &dig_b, dig_ab);

		/* only 1 or 2-digit number satisfy a (a < b) */
		nd_a = ndigit(&dig_a);
		if (nd_a != 1 && nd_a != 2)
			continue;

		dig2ints(&dig_a, &as, &aslen);
		dig2ints(&dig_b, &bs, &bslen);
		for (i = 0; i < aslen; i++) {
			if (as[i] > c)
				continue;
			for (j = 0; j < bslen; j++) {
				if (as[i] * bs[j] == c) {
					found = 1;
					goto out;
				}
			}
		}
	out:
		free(as);
		free(bs);
	}
	return found;
}


/*
 * 検討メモ
 *  C=A*B において、桁数(Dとする)の合計は9桁になる
 *  D(C)+D(A)+D(B)=9
 *
 * この条件を満たす値の桁数は、以下のパターンのみ
 *  D(C)=4: (D(A),D(B))->(1,4),(2,3)
 */
