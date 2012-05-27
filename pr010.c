/*
 * pr010.c
 *
 *  Problem 10
 *    The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
 *
 *    Find the sum of all the primes below two million.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define INPUT_NUM 2000000

int main(int, char *[]);
int
main(int argc, char *argv[])
{
	u_char *table;
	int i, j;
	long sum;

	/* allocate eratoshenes table */
	table = (u_char *)malloc(sizeof(u_char) * INPUT_NUM);
	if (table == NULL)
		err(1, "fail malloc");

	/* initialize table to 1 */
	memset(table, 1, sizeof(u_char) * INPUT_NUM);
	table[0] = 0;
	table[1] = 0;

	/* eratoshenes sieve */
	for (i = 2; i < INPUT_NUM; i++) {
		if (!table[i])
			continue;
		for (j = i * 2; j < INPUT_NUM; j += i)
			table[j] = 0;
	}

	/* sum of all primes */
	for (sum = 0, i = 2; i < INPUT_NUM; i++) {
		if (table[i])
			sum += i;
	}
	printf("%ld\n", sum);

	return 0;
}
