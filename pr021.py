#!/usr/bin/env python2
# -*- coding: utf-8 -*-

"""
Let d(n) be defined as the sum of proper divisors of n (numbers less than n
which divide evenly into n).
If d(a) = b and d(b) = a, where a != b, then a and b are an amicable pair and
each of a and b are called amicable numbers.

For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44,
55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4,
71 and 142; so d(284) = 220.

Evaluate the sum of all the amicable numbers under 10000.
"""

INPUT_NUM = 10000


def divisors(num):
  """return divisors list of num"""
  return filter(lambda x: num % x == 0, range(1,num/2+1))

def d(num):
  """problem function"""
  return sum(divisors(num))


def is_amecable(num):
  n2 = d(num)
  return (num != n2 and d(n2) == num)


def main(num):
  """main function"""
  amecables = filter(is_amecable, range(1,num))
  print sum(amecables)


if __name__ == "__main__":
  main(INPUT_NUM)
