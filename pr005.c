/*
 * Problem 5
 * 2520 is the smallest number that can be divided by each of the numbers
 * from 1 to 10 without any remainder.
 *
 * What is the smallest positive number that is evenly divisible by all of
 * the numbers from 1 to 20?
 */

#include <stdio.h>

int
main(int argc, char *argv[])
{
	int num, mod, i;

	num = 1;
	while (1) {
		for (i = 1; i < 20; i++) {
			mod = num % i;
			if (mod)
				break;
		}
		if (!mod)
			break;
		num++;
	}
	printf("%d\n", num);
	return 0;
}

