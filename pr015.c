/*
 * Problem 15
 * Starting in the top left corner of a 2 x 2 grid,
 * there are 6 routes (without backtracking) to the bottom right corner.
 *
 * How many routes are there through a 20 x 20 grid?
 */

#include <sys/types.h>
#include <stdio.h>

static u_long combination(int, int);

int
main(int argc, char *argv[])
{
	u_long nroute;
	nroute = combination(40, 20);
	printf("%ld\n", nroute);
	return 0;
}

/*
 * calculate combination with attention overflow.
 * XXX - this is not perfect routine...
 */
static u_long
combination(int n, int m)
{
	u_long c = 1;
	int n_end = n - m;
	for (; n > n_end; n--) {
		c *= n;
		while ((m > 1) && ((c % m) == 0)) {
			c /= m;
			m--;
		}
	}
	for (; m > 1; m--)
		c /= m;
	return c;
}
