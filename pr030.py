#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Surprisingly there are only three numbers that can be written as the sum of
fourth powers of their digits:

  1634 = 1**4 + 6**4 + 3**4 + 4**4
  8208 = 8**4 + 2**4 + 0**4 + 8**4
  9474 = 9**4 + 4**4 + 7**4 + 4**4

As 1 = 1**4 is not a sum it is not included.

The sum of these numbers is 1634 + 8208 + 9474 = 19316.

Find the sum of all the numbers that can be written as the sum of fifth powers
of their digits.
"""

POWER = 5


def max_number(power):
  """calculate max search number from power"""
  i = 1
  while 9 ** power * i > 10 ** i:
    i += 1
  return 10 ** i


def is_fifthpower(num):
  """num is equal with sum of fourth powers of digits"""
  if num == sum(map(lambda x: int(x) ** POWER, list(str(num)))):
    return True
  else:
    return False


def main():
  """main function"""
  print sum(filter(is_fifthpower, range(2, max_number(POWER))))


if __name__ == "__main__":
  main()
