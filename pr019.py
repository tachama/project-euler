#!/usr/bin/env python2

"""
You are given the following information, but you may prefer to do some
research for yourself.

  - 1 Jan 1900 was a Monday.
  - Thirty days has September,
    April, June and November.
    All the rest have thirty-one,
    Saving February alone,
    Which has twenty-eight, rain or shine.
    And on leap years, twenty-nine.
  - A leap year occurs on any year evenly divisible by 4, but not on a
    century unless it is divisible by 400.

How many Sundays fell on the first of the month during the twentieth century
(1 Jan 1901 to 31 Dec 2000)?
"""


def is_leap(year):
  """is year leap ?"""
  divisible = lambda x: year % x == 0
  return divisible(4) and (not divisible(100) or divisible(400))


def num_of_day(year, month):
  """return days at year/month"""
  days = [0,31,28,31,30,31,30,31,31,30,31,30,31]  # Feb is dummy.
  if month == 2 and is_leap(year):
    return days[month] + 1
  return days[month]


def main():
  """main function"""
  first_sunday = 0
  first_day = 1   # 1 Jan 1901 is Monday.
  # parse 1900.
  for m in range(1, 12+1):
    first_day = (first_day + num_of_day(1900, m)) % 7
  # calculate 1901 to 2000
  for y in range(1901, 2000+1):
    for m in range(1, 12+1):
      if first_day == 0:
        first_sunday += 1
      first_day = (first_day + num_of_day(y, m)) % 7
  print first_sunday

if __name__ == "__main__":
  main()
