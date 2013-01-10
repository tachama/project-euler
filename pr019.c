/*
 * You are given the following information, but you may prefer to do some
 * research for yourself.
 *
 *   - 1 Jan 1900 was a Monday.
 *   - Thirty days has September,
 *     April, June and November.
 *     All the rest have thirty-one,
 *     Saving February alone,
 *     Which has twenty-eight, rain or shine.
 *     And on leap years, twenty-nine.
 *   - A leap year occurs on any year evenly divisible by 4, but not on a
 *     century unless it is divisible by 400.
 *
 * How many Sundays fell on the first of the month during the twentieth century
 * (1 Jan 1901 to 31 Dec 2000)?
 */

#include <stdio.h>

/* enum of days */
enum day {
	SUNDAY = 0,
	MONDAY = 1,
	TUESDAY = 2,
	WEDNESDAY = 3,
	THURSDAY = 4,
	FRIDAY = 5,
	SATURDAY = 6,
	NDAYS = 7,  /* number of days */
};
static const int days[] = {
	0 /*dummy*/, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31,
};

static int ndays(int, int);
static int is_leap(int);

int
main(int argc, char *argv[])
{
	int year, month;
	int start_day = MONDAY;  /* start day of 1900 */
	int sunday_at_mstart;

	/* found start day of 1901 */
	year = 1900;
	for (month = 1; month <= 12; month++)
		start_day = (start_day + ndays(year, month)) % NDAYS;

	/* count sunday at start of month */
	sunday_at_mstart = 0;
	for (year = 1901; year <= 2000; year++) {
		for (month = 1; month <= 12; month++) {
			if (start_day == SUNDAY)
				sunday_at_mstart++;
			start_day = (start_day + ndays(year, month)) % NDAYS;
		}
	}
	printf("%d\n", sunday_at_mstart);
	return 0;
}

/* number of days at year */
static int
ndays(int year, int month)
{
	return days[month] + ((month == 2 && is_leap(year)) ? 1 : 0);
}

/* year is leap or not */
static int
is_leap(int year)
{
	int leap;
	if ((year % 400 == 0) || ((year % 4 == 0) && (year % 100 != 0)))
		leap = 1;
	else
		leap = 0;
	return leap;
}

