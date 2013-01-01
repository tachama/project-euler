/*
 * 2 ** 15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
 *
 * What is the sum of the digits of the number 2 ** 1000?
 */

#include <stdio.h>

#define TARGET	1000

typedef unsigned char	byte;
byte digits[TARGET];

int
main(int argc, char *argv[])
{
	int i, j, sum;
	byte carry;

	/* initialize digits */
	for (i = 0; i < TARGET; i++)
		digits[i] = 0;
	digits[0] = 1;

	for (i = 0; i < TARGET; i++) {
		carry = 0;
		for (j = 0; j < TARGET; j++) {
			digits[j] = digits[j] * 2 + carry;
			if (digits[j] >= 10) {
				carry = digits[j] / 10;
				digits[j] = digits[j] % 10;
			} else {
				carry = 0;
			}
		}
	}

	/* sum of all digit */
	for (i = 0, sum = 0; i < TARGET; i++)
		sum += digits[i];
	printf("%d\n", sum);

	return 0;
}

