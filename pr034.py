#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.

Find the sum of all numbers which are equal to the sum of the
factorial of their digits.

Note: as 1! = 1 and 2! = 2 are not sums they are not included.
"""


def max_digits():
  """
  calculate max digits of this problem.
  at N digits values.
    max of sum of fractions is : 9! * N
    max of number is : 10 ** N - 1
  so below must be true for problem.
    9! * N >= 10 ** n - 1
  """
  n = 1
  while factorial(9) * n >= 10 ** n - 1:
    n += 1
  return n


def factorial(num):
  """factorial of num"""
  return reduce(lambda a, b: a * b, [1] + range(1,num+1))


def is_curious(num):
  """check number is curious number or not """
  digits = map(int, list(str(num)))
  return num == reduce(lambda a, b: a + b, map(factorial, digits))


def main():
  """main functions"""
  # 1!=1 and 2!=2 are not included.
  lst = filter(is_curious, range(3, 10 ** max_digits()))
  print sum(lst)


if __name__ == "__main__":
  main()


