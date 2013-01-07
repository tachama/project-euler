/*
 * By starting at the top of the triangle below and moving to adjacent numbers
 * on the row below, the maximum total from top to bottom is 23.
 *
 *  3
 *  7 4
 *  2 4 6
 *  8 5 9 3
 *
 * That is, 3 + 7 + 4 + 9 = 23.
 *
 * Find the maximum total from top to bottom of the triangle below:
 *
 *  75
 *  95 64
 *  17 47 82
 *  18 35 87 10
 *  20 04 82 47 65
 *  19 01 23 75 03 34
 *  88 02 77 73 07 63 67
 *  99 65 04 28 06 16 70 92
 *  41 41 26 56 83 40 80 70 33
 *  41 48 72 33 47 32 37 16 94 29
 *  53 71 44 65 25 43 91 52 97 51 14
 *  70 11 33 28 77 73 17 78 39 68 17 57
 *  91 71 52 38 17 14 91 43 58 50 27 29 48
 *  63 66 04 68 89 53 67 30 73 16 69 87 40 31
 *  04 62 98 27 23 09 70 98 73 93 38 53 60 04 23
 *
 * NOTE: As there are only 16384 routes, it is possible to solve this problem
 * by trying every route. However, Problem 67, is the same challenge with a
 * triangle containing one-hundred rows; it cannot be solved by brute force,
 * and requires a clever method! ;o)
 */

#include <ctype.h>
#include <err.h>
#include <stdio.h>
#include <stdlib.h>

static const char *instr = \
	"75 " \
	"95 64 " \
	"17 47 82 " \
	"18 35 87 10 " \
	"20 04 82 47 65 " \
	"19 01 23 75 03 34 " \
	"88 02 77 73 07 63 67 " \
	"99 65 04 28 06 16 70 92 " \
	"41 41 26 56 83 40 80 70 33 " \
	"41 48 72 33 47 32 37 16 94 29 " \
	"53 71 44 65 25 43 91 52 97 51 14 " \
	"70 11 33 28 77 73 17 78 39 68 17 57 " \
	"91 71 52 38 17 14 91 43 58 50 27 29 48 " \
	"63 66 04 68 89 53 67 30 73 16 69 87 40 31 " \
	"04 62 98 27 23 09 70 98 73 93 38 53 60 04 23";

static const char * pickupnum(const char *, int *);
static int next_route(int *, int);
static int route_val(int *, int *, int);

int
main(int argc, char *argv[])
{
	const char *c;
	int num, i;
	int nelem, *elems, depth;
	int *routes;
	int sum = -1;

	/* found number of elems */
	c = instr;
	nelem = 0;
	while ((c = pickupnum(c, &num)) != NULL)
		nelem++;

	/* get elements */
	elems = (int *)malloc(sizeof(int) * nelem);
	if (!elems)
		err(1, "fail malloc()");
	c = instr;
	i = 0;
	while ((c = pickupnum(c, &num)) != NULL)
		elems[i++] = num;

	/* get tree depth from nelem */
	for (i = 1, num = 0; ; i++) {
		num += i;
		if (num >= nelem)
			break;
	}
	depth = i;

	/* allocate route space */
	routes = (int *)malloc(sizeof(int) * (depth - 1));
	if (!routes)
		err(1, "fail malloc()");

	/* find maximum route val */
	do {
		num = route_val(elems, routes, depth - 1);
		if (num > sum)
			sum = num;
	} while (next_route(routes, depth - 1));
	printf("%d\n", sum);

	return 0;
}

static const char *
pickupnum(const char *str, int *num)
{
	const char *c = str;
	int n = 0;

	while (*c && !isdigit(*c))
		c++;
	if (*c == '\0')
		/* return NULL if str is terminated */
		return NULL;

	while (isdigit(*c)) {
		n *= 10;
		n += *c - '0';
		c++;
	}
	*num = n;
	return c;
}

static int
next_route(int *idxs, int length)
{
	int i;
	i = length - 1;
	for (i = length - 1; i >= 0; i--) {
		if (idxs[i] == 0) {
			idxs[i] = 1;
			break;  /* out to for-loop */
		} else {
			idxs[i] = 0;
		}
	}
	/* return 0 if all route is over */
	return (i >= 0 ? 1 : 0);
}


static int
route_val(int *elems, int *routes, int len)
{
	int idx = 0, depth = 0, sum;

	sum = elems[0];
	while (depth < len) {
		depth++;
		if (routes[depth-1])
			idx += depth+1;
		else
			idx += depth;
		sum += elems[idx];
	}
	return sum;
}
