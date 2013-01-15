/*
 * In England the currency is made up of pound, P, and pence, p, and there are
 * eight coins in general circulation:
 *
 *   1p, 2p, 5p, 10p, 20p, 50p, 1P (100p) and 2P (200p).
 *
 * It is possible to make 2P in the following way:
 *
 *   1 * 1P + 1 * 50p + 2 * 20p + 1 * 5p + 1 * 2p + 3 * 1p
 *
 * How many different ways can 2P be made using any number of coins?
 */

#include <stdio.h>

/* coin pattern */
int coins[] = { 200, 100, 50, 20, 10, 5, 2, 1, 0 /*end*/ };

#define TARGET_VALUE	200	/* 200p = 2P */

static int npattern(int, int *);

int
main(int argc, char *argv[])
{
	printf("%d\n", npattern(200, coins));
	return 0;
}

/*
 * found number of pattern at satisfy val with given pattern
 */
static int
npattern(int val, int *patt)
{
	int np, nc;
	int coin = *patt;

	/* satisfy target value */
	if (val == 0)
		return 1;
	/* no-coins */
	if (val == 0 || coin == 0)
		return 0;
	np = 0;
	for (nc = 0; nc * coin <= val; nc++) {
		np += npattern(val - nc * coin, patt + 1);
	}
	return np;
}
