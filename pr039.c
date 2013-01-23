/*
 * If p is the perimeter of a right angle triangle with integral length sides,
 * {a,b,c}, there are exactly three solutions for p = 120.
 *
 *   {20,48,52}, {24,45,51}, {30,40,50}
 *
 * For which value of p < 1000, is the number of solutions maximised?
 */

#include <stdio.h>

#define P_MAX	1000

int
main(int argc, char *argv[])
{
	int n, max_n, max, tmp;
	int a, b, c;

	max_n = max = 0;
	for (n = 1; n < P_MAX; n++) {
		tmp = 0;
		/* search right triangle at "a+b+c=n" */
		for (a = 1; a < n / 3; a++) {
			for (b = a; b < (n - a) / 2; b++) {
				c = n - a - b;
				if (c < b)
					break;
				if (c * c == a * a + b * b) {
					/* is right trianble */
					tmp++;
					break;
				}
			}
		}
		if (tmp > max) {
			max = tmp;
			max_n = n;
		}
	}
	printf("%d\n", max_n);
	return 0;
}

