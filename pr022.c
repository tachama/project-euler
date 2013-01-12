/*
 * Using names.txt (right click and 'Save Link/Target As...'), a 46K text file
 * containing over five-thousand first names, begin by sorting it into alphabetical
 * order. Then working out the alphabetical value for each name, multiply this
 * value by its alphabetical position in the list to obtain a name score.
 *
 * For example, when the list is sorted into alphabetical order, COLIN, which is
 * worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So, COLIN
 * would obtain a score of 938 * 53 = 49714.
 *
 * What is the total of all the name scores in the file?
 */

#include <sys/types.h>
#include <sys/stat.h>
#include <sys/queue.h>
#include <ctype.h>
#include <err.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define INFILENAME	"pr022_names.txt"

static char *read_file(const char *);
static char *get_name(char *, char **);
static int name_score(const char *);


typedef struct nameelem {
	TAILQ_ENTRY(nameelem)	next;
	const char		*name;
} nameelem_t;
TAILQ_HEAD(, nameelem) nameq = TAILQ_HEAD_INITIALIZER(nameq);

int
main(int argc, char *argv[])
{
	char *filebuf, *namep, *np;
	int idx;
	long total_score;
	nameelem_t *elm, *e;

	filebuf = read_file(INFILENAME);
	if (!filebuf)
		errx(1, "fail read file");

	/* read names and sort */
	namep = filebuf;
	while ((namep = get_name(namep, &np)) != NULL) {
		elm = (nameelem_t *)malloc(sizeof(nameelem_t));
		if (!elm)
			err(1, "fail malloc");
		memset(elm, 0, sizeof(nameelem_t));
		elm->name = np;
		TAILQ_FOREACH(e, &nameq, next) {
			/* insert at sorted order */
			if (strcmp(e->name, elm->name) > 0) {
				TAILQ_INSERT_BEFORE(e, elm, next);
				break;
			}
		}
		if (e == NULL)
			/* if elm is end of list */
			TAILQ_INSERT_TAIL(&nameq, elm, next);
	}

	/* calculate scores */
	idx = 1;
	total_score = 0;
	TAILQ_FOREACH(e, &nameq, next) {
		total_score += idx * name_score(e->name);
		idx++;
	}
	printf("%ld\n", total_score);
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
get_name(char *buf, char **np)
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
name_score(const char *name)
{
	int score = 0;
	const char *c;
	for (c = name; *c; c++)
		score += *c - 'A' + 1;
	return score;
}
