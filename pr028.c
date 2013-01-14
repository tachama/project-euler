/*
 * Starting with the number 1 and moving to the right in a clockwise direction
 * a 5 by 5 spiral is formed as follows:
 *
 *   21 22 23 24 25
 *   20  7  8  9 10
 *   19  6  1  2 11
 *   18  5  4  3 12
 *   17 16 15 14 13
 *
 * It can be verified that the sum of the numbers on the diagonals is 101.
 *
 * What is the sum of the numbers on the diagonals in a 1001 by 1001 spiral formed
 * in the same way?
 */

#include <stdio.h>

#define TARGET_N	1001

int
main(int argc, char *argv[])
{
	int i;
	long sum = 1;
	for (i = 1; i <= (TARGET_N - 1) / 2; i++) {
		sum += 16 * i * i + 4 * i + 4;
	}
	printf("%ld\n", sum);
	return 0;
}

/*
 * N段目の開始は、(N=1,2,..)
 *  S(N) = 1 + (2*4) + (4*4) + (6*4) + .. * (2*N*4) + 1
 *       = 8 * (1 + 2 + .. + N) + 2
 *       = 8 * (N * (N-1) / 2) + 2
 *       = 4 * N * (N-1) + 2
 *  => S(1) = 2, S(2) = 10, S(3) = 26, S(4) = 50
 *
 *  これを元に、N段目の4隅の和は、
 *  D(N) = S(N)+(2N - 1) + S(N)+(2N-1)+2N + S(N)+(2N-1)+4N + S(N)+(2N-1)+6N
 *       = 4*S(N) + 20N - 4
 *       = 4*(4*N*(N-1)+2) + 20N - 4
 *       = 16*N*(N-1) + 8 + 20N - 4
 *       = 16*N*N + 4N + 4
 *
 *  1001 * 1001の場合、合計500段必要になる。以上より、解答は
 *  1 + D(1) + D(2) + .. + D(500)
 */
