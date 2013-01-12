/*
 * The Fibonacci sequence is defined by the recurrence relation:
 *   F(n) = F(n-1) + F(n-2), where F(1) = 1 and F(2) = 1.
 * Hence the first 12 terms will be:
 *   F(1) = 1
 *   F(2) = 1
 *   F(3) = 2
 *   F(4) = 3
 *   F(5) = 5
 *   F(6) = 8
 *   F(7) = 13
 *   F(8) = 21
 *   F(9) = 34
 *   F(10) = 55
 *   F(11) = 89
 *   F(12) = 144
 * The 12th term, F(12), is the first term to contain three digits.
 * What is the first term in the Fibonacci sequence to contain 1000 digits?
 */

#include <stdio.h>
#include <string.h>

#define TARGET_DIGIT	1000
typedef unsigned char digit;
static int add_bufs(digit *, digit *, digit *, int);

int
main(int argc, char *argv[])
{
	digit buf1[TARGET_DIGIT], buf2[TARGET_DIGIT], buf3[TARGET_DIGIT];
	digit *fib1, *fib2, *next, *tmp;
	int ndigit, index;

	/* initialize local variables */
	memset(buf1, 0, sizeof(buf1));
	memset(buf2, 0, sizeof(buf2));
	memset(buf3, 0, sizeof(buf3));
	fib1 = buf1;
	fib2 = buf2;
	next = buf3;

	/* set F(1) and F(2) */
	fib1[0] = 1;
	fib2[0] = 1;
	index = 2;

	do {
		index++;
		ndigit = add_bufs(fib1, fib2, next, TARGET_DIGIT);
		/* rotate variable buffers for next loop */
		tmp = fib1;
		fib1 = fib2;
		fib2 = next;
		next = tmp;
	} while (ndigit < TARGET_DIGIT);
	printf("%d\n", index);

	return 0;
}


/*
 * add two digit array. return digits of add
 */
static int
add_bufs(digit *n1, digit *n2, digit *add, int len)
{
	int d = 0, i;
	digit tmp, carry;
	for (carry = 0, i = 0; i < len; i++) {
		tmp = n1[i] + n2[i] + carry;
		add[i] = tmp % 10;
		if (add[i])
			d = i;  /* remember digit index of non-zero */
		carry = tmp / 10;
	}
	return (d+1);
}
