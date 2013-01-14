/*
 * A unit fraction contains 1 in the numerator. The decimal representation of the
 * unit fractions with denominators 2 to 10 are given:
 *
 *   1/2  = 0.5
 *   1/3  = 0.(3)
 *   1/4  = 0.25
 *   1/5  = 0.2
 *   1/6  = 0.1(6)
 *   1/7  = 0.(142857)
 *   1/8  = 0.125
 *   1/9  = 0.(1)
 *   1/10 = 0.1
 *
 * Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle. It can be
 * seen that 1/7 has a 6-digit recurring cycle.
 *
 * Find the value of d < 1000 for which 1/d contains the longest recurring cycle
 * in its decimal fraction part.
 */

#include <err.h>
#include <stdio.h>

#define TARGET_MAX	1000

static int recurring(int);

int
main(int argc, char *argv[])
{
	int max_recurring, max_val;
	int i, r;

	max_recurring = max_val = -1;  /* initial value */
	for (i = 2; i < TARGET_MAX; i++) {
		r = recurring(i);
		if (r < 0)
			errx(1, "fail recurring(%d)", i);
		if (r > max_recurring) {
			max_recurring = r;
			max_val = i;
		}
	}
	printf("%d\n", max_val);
	return 0;
}

/*
 * recurring cycle value of 1/n
 * XXX - use static buffer size. it may overflow...
 */
#define MAXBUFFER	1000
static int
recurring(int n)
{
	int mod[MAXBUFFER];
	int i, j;
	for (mod[0] = 10, i = 1; i < MAXBUFFER; i++) {
		mod[i] = (mod[i-1] % n) * 10;
		if (mod[i] == 0)
			/* no cycle */
			return 0;
		/* search cycle */
		for (j = 0; j < i; j++)
			if (mod[j] == mod[i])
				return (i-j);
	}
	/* buffer overflow */
	return -1;
}
