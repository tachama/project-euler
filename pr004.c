/*
 * Problem 4
 * A palindromic number reads the same both ways. The largest palindrome made
 * from the product of two 2-digit numbers is 9009 = 91  99.
 *
 * Find the largest palindrome made from the product of two 3-digit numbers.
 */

#include <stdio.h>

static int is_palindrome(int);

int
main(int argc, char *argv[])
{
	int max_palindrome = 0;
	int i, j, tmp;

	for (i = 100; i < 1000; i++) {
		for (j = 100; j < 1000; j++) {
			tmp = i * j;
			if (is_palindrome(tmp) && tmp > max_palindrome)
				max_palindrome = tmp;
		}
	}
	printf("%d\n", max_palindrome);

	return 0;
}

static int
is_palindrome(int num)
{
	int reverse = 0;
	int n = num;
	while (n > 0) {
		reverse = reverse * 10 + n % 10;
		n /= 10;
	}
	if (reverse == num)
		return 1;
	else
		return 0;
}
