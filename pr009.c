/*
 * Problem 9
 * A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,
 *
 * a ** 2 + b ** 2 = c ** 2
 * For example, 3 ** 2 + 4 ** 2 = 9 + 16 = 25 = 52.
 *
 * There exists exactly one Pythagorean triplet for which a + b + c = 1000.
 * Find the product a*b*c.
 */

#include <stdio.h>

int
main(int argc, char *argv[])
{
	int a, b, c;
	for (a = 1; a < 1000; a++)
		for (b = a + 1; b < 1000; b++)
			for (c = b + 1; c < 1000; c++)
				if ((a * a + b * b == c * c)
				    && (a + b + c == 1000)) {
					printf("%d\n", a * b * c);
					return 0;
				}
	return 1;	/* NOTREACHED */
}
