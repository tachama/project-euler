/*
 * The nth term of the sequence of triangle numbers is given by,
 * t(n) = 1/2 * n(n+1);
 * so the first ten triangle numbers are:
 *
 *   1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
 *
 * By converting each letter in a word to a number corresponding to its alphabetical
 * position and adding these values we form a word value. For example, the word
 * value for SKY is 19 + 11 + 25 = 55 = t10. If the word value is a triangle number
 * then we shall call the word a triangle word.
 *
 * Using words.txt (right click and 'Save Link/Target As...'), a 16K text file
 * containing nearly two-thousand common English words, how many are triangle words?
 */

#include <sys/types.h>
#include <sys/stat.h>
#include <err.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

static char *read_file(const char *);
static char *get_word(char *, char **);
static int word2int(const char *);
static int is_triangle(int);

/* problem input file name */
static const char *infile_name = "pr042_words.txt";

int
main(int argc, char *argv[])
{
	char *words, *w, *buf;
	int ntriangle;

	buf = read_file(infile_name);
	if (!buf)
		errx(1, "cannot read file:%s", infile_name);

	/* get word */
	ntriangle = 0;
	words = buf;
	while ((words = get_word(words, &w)) != NULL) {
		if (is_triangle(word2int(w)))
			ntriangle++;
	}
	printf("%d\n", ntriangle);
	free(buf);
	return 0;
}


static char *
read_file(const char *fname)
{
	struct stat sb;
	FILE *fp;
	char *buf;
	int rv;

	/* get file size */
	rv = stat(fname, &sb);
	if (rv)
		return NULL;
	/* get file data buffer */
	buf = (char *)malloc(sb.st_size + 1);
	if (!buf)
		return NULL;
	/* read data from file */
	fp = fopen(fname, "r");
	if (!fp)
		goto fail;
	rv = fread(buf, 1, sb.st_size, fp);
	if (rv != sb.st_size)
		goto fail;
	buf[sb.st_size] = '\0';  /* nul terminate at buf */
	fclose(fp);
	return buf;

fail:
	free(buf);
	return NULL;
}

static char *
get_word(char *buf, char **np)
{
	char *c = buf, *start;
	while (*c == '"' || *c == ',')
		c++;
	if (*c == '\0')
		/* return NULL if no name contains */
		return NULL;
	start = c;
	while (isalpha(*c))
		c++;
	*c = '\0';  /* terminate name */
	*np = start;
	return (++c);
}

static int
word2int(const char *w)
{
	int v = 0;
	while (*w) {
		v += *w - 'A' + 1;
		w++;
	}
	return v;
}

static int
is_triangle(int num)
{
	int n, t = 0;
	for (n = 1; t < num; n++) {
		t = n * (n+1) / 2;
		if (num == t)
			/* is triangle number */
			return 1;
	}
	return 0;  /* not triangle number */
}

