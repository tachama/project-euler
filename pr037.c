/*
 * The number 3797 has an interesting property. Being prime itself, it is possible
 * to continuously remove digits from left to right, and remain prime at each
 * stage: 3797, 797, 97, and 7. Similarly we can work from right to left: 3797,
 * 379, 37, and 3.
 *
 * Find the sum of the only eleven primes that are both truncatable from left to
 * right and right to left.
 *
 * NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.
 */

#include <err.h>
#include <stdio.h>

#include "prime.c"

#define NEED_NFOUND	11

static int special(int, int *, int);
static int search(int, int *, int, int);

int
main(int argc, char *argv[])
{
	int *pr_arr, pr_len, n_found;
	int max = 1;  /* max number of prime search. this grows '*10' */
	int i, tmp;
	long sum;

	n_found = 0;
	sum = 0L;
	tmp = 4;  /* for skip 2,3,5,7 */

	while (1) {
		/* we grow search range to 10,100,1000.. */
		max *= 10;
		if (primes_under(max, &pr_arr, &pr_len))
			errx(1, "fail primes_under(%d)", max);
		for (i = tmp; i < pr_len; i++) {
			if (special(pr_arr[i], pr_arr, pr_len)) {
				sum += pr_arr[i];
				n_found++;
				if (n_found == NEED_NFOUND)
					break;  /* out to for-loop */
			}
		}
		if (n_found == NEED_NFOUND)
			break;  /* out to while-loop */
		tmp = pr_len;  /* skip already checked for next loop */
		free(pr_arr);
	}
	printf("%ld\n", sum);
	return 0;
}

/*
 * check givin prime specifies problem property.
 * 2nd and 3rd argument is primes array under num.
 */
static int
special(int num, int *prs, int len)
{
	int r_num, l_num, r_idx, l_idx;
	int nd;

	/* check num remove to left is specify property */
	l_num = num / 10;
	while (l_num) {
		l_idx = search(l_num, prs, 0, len - 1);
		if (l_idx == -1)
			return 0;
		l_num /= 10;
	}

	/* check num remove to right is special property */
	for (nd = 1; num / nd; nd *= 10);  /* found n-digit of num */
	nd /= 10;
	r_num = num % nd;
	while (r_num) {
		r_idx = search(r_num, prs, 0, len - 1);
		if (r_idx == -1)
			return 0;
		nd /= 10;
		r_num %= nd;
	}

	/* num has this property */
	return 1;
}


/*
 * binary search for check num is contained givin array
 * return 1 if num in contain ns, otherwise return 0.
 */
static int
search(int num, int *ns, int start, int end)
{
	int idx;
	while (start <= end) {
		idx = (start + end) / 2;
		if (ns[idx] < num)
			start = idx + 1;
		else if (ns[idx] > num)
			end = idx - 1;
		else
			/* found num */
			return idx;
	}
	/* not found num in ns */
	return -1;
}

