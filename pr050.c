/*
 * The prime 41, can be written as the sum of six consecutive primes:
 *
 *   41 = 2 + 3 + 5 + 7 + 11 + 13
 *
 * This is the longest sum of consecutive primes that adds to a prime below
 * one-hundred.
 *
 * The longest sum of consecutive primes below one-thousand that adds to a prime,
 * contains 21 terms, and is equal to 953.
 *
 * Which prime, below one-million, can be written as the sum of the most
 * consecutive primes?
 */

#include <err.h>
#include <stdio.h>

#include "prime.c"

#define TARGET_MAX	1000000

int
main(int argc, char *argv[])
{
	int *pr_arr, pr_len;
	int i, j, sum, idx;
	int max_len, max_prime;

	/* TARGET_MAX以下の全てん素数を取得 */
	if (primes_under(TARGET_MAX, &pr_arr, &pr_len))
		errx(1, "fail primes_under(%d)", TARGET_MAX);

	max_len = max_prime = 0;
	for (i = 0; i < pr_len; i++) {
		for (j = 0; j < i; j++) {
			sum = 0;
			/*
			 * 不要な検索を避ける。
			 * 既に検索済みのmax_len個の素数の和を事前に求めておく
			 */
			for (idx = j; idx < j + max_len; idx++)
				sum += pr_arr[idx];
			/*
			 * jによるforループを抜ける。
			 * この時点で対象素数(pr_arr[i])より大きい場合、
			 * jの値を増やしても求める値はみつからに
			 */
			if (sum >= pr_arr[i])
				break;
			while (sum <= pr_arr[i]) {
				sum += pr_arr[idx];
				if (sum == pr_arr[i]) {
					if (idx - j + 1 > max_len) {
						max_len = idx - j + 1;
						max_prime = pr_arr[i];
					}
					break;
				}
				idx++;
			}
			if (sum == pr_arr[i])
				break;
		}
	}
	free(pr_arr);

	printf("%d\n", max_prime);

	return 0;
}


