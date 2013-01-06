/*
 * If the numbers 1 to 5 are written out in words: one, two, three, four, five,
 * then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.
 *
 * If all the numbers from 1 to 1000 (one thousand) inclusive were written out
 * in words, how many letters would be used?
 *
 *
 * NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and
 * forty-two) contains 23 letters and 115 (one hundred and fifteen) contains
 * 20 letters. The use of "and" when writing out numbers is in compliance with
 * British usage.
 */

#include <err.h>
#include <stdio.h>
#include <string.h>

static int num2words(int, char *, int);
static int wordslen(char *);

#define TARGET_MAX	1000
#define BUFLEN		1000

int
main(int argc, char *argv[])
{
	int i, lensum, rv;
	char buf[BUFLEN];

	for (lensum = 0, i = 1; i <= TARGET_MAX; i++) {
		rv = num2words(i, buf, BUFLEN);
		if (rv)
			errx(1, "fail convert to word:%d\n", i);
		lensum += wordslen(buf);
	}
	printf("%d\n", lensum);
	return 0;
}

static const char *word_nums[] = {
	"", "one", "two", "three", "four", "five", "six", "seven",
	"eight", "nine",
	/* this array contains 10 - 19 */
	"ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen",
	"sixteen", "seventeen", "eighteen", "nineteen"
};
static const char *word_tens[] = {
	"", "", "twenty", "thirty", "forty", "fifty", "sixty",
	"seventy", "eighty", "ninety"
};


/*
 * conver number to words.
 * return 1 if buffer may overflow or number is unsuported.
 */
static int
num2words(int num, char *buf, int len)
{
	char *c, *e;
	int n;

	if (num < 1 || num > 1000)
		/* unsupported number */
		return 1;

	/* initialize local variable */
	c = buf;  /* buffer pointer for write */
	e = buf + len;  /* end of buffer */

	if (num >= 1000) {
		n = num / 1000;
		c += snprintf(c, e - c, "%s thousand", word_nums[n]);
		num %= 1000;
		if (num == 0)
			goto out;
		c += snprintf(c, e - c, " and ");
	}

	if (num >= 100) {
		n = num / 100;
		c += snprintf(c, e - c, "%s hundred", word_nums[n]);
		num %= 100;
		if (num == 0)
			goto out;
		c += snprintf(c, e - c, " and ");
	}

	if (num >= 20) {
		n = num / 10;
		c += snprintf(c, e - c, "%s", word_tens[n]);
		num %= 10;
		if (num == 0)
			goto out;
		c += snprintf(c, e - c, "-");
	}
	c += snprintf(c, e - c, "%s", word_nums[num]);

out:
	return (c == e);
}


/*
 * return count of letters of words,
 * not include space or hyphens
 */
static int
wordslen(char *words)
{
	char *w = words;
	int len = 0;
	while (*w) {
		if (*w != ' ' && *w != '-')
			len++;
		w++;
	}
	return len;
}
