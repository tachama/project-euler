/*
 * Problem 14
 *
 * The following iterative sequence is defined for the set of positive integers:
 *
 *   n = n/2 (n is even)
 *   n = 3n + 1 (n is odd)
 *
 * Using the rule above and starting with 13, we generate the following sequence:
 *
 *   13  40  20  10  5  16  8  4  2  1
 *
 * It can be seen that this sequence (starting at 13 and finishing at 1) contains
 * 10 terms. Although it has not been proved yet (Collatz Problem), it is thought
 * that all starting numbers finish at 1.
 *
 * Which starting number, under one million, produces the longest chain?
 *
 * NOTE: Once the chain starts the terms are allowed to go above one million.
 */

#include <stdio.h>

#define ONEMILLION	1000000
#define UNKNOWN		(-1)

/* steps[i] means chain of i */
int steps[ONEMILLION];

static long step_to_one(long);

int
main(int argc, char *argv[])
{
	int i, max_chain, max_start;
	/* initialze steps array */
	for (i = 0; i < ONEMILLION; i++)
		steps[i] = UNKNOWN;
	steps[1] = 1;  /* initial */

	/* calculate all steps */
	for (i = 1; i < ONEMILLION; i++)
		step_to_one(i);
	/* found max chain */
	max_chain = -1;
	for (i = 1; i < ONEMILLION; i++) {
		if (max_chain < steps[i]) {
			max_chain = steps[i];
			max_start = i;
		}
	}
	printf("%d\n", max_start);
	return 0;
}

static long
step_to_one(long num)
{
	long next;

	if (num & 0x1)
		next = 3 * num + 1;  /* num is odd */
	else
		next = num / 2;  /* num is even */

	if (num >= ONEMILLION) {
		return step_to_one(next) + 1;
	} else {
		if (steps[num] == UNKNOWN) {
			/* target is not calculated */
			steps[num] = step_to_one(next) + 1;
		}
		return steps[num];
	}
}
