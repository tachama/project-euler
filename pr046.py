#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
It was proposed by Christian Goldbach that every odd composite number can
be written as the sum of a prime and twice a square.

9 = 7 + 2 * 1 ^ 2
15 = 7 + 2 * 2 ^ 2
21 = 3 + 2 * 3 ^ 2
25 = 7 + 2 * 3 ^ 2
27 = 19 + 2 * 2 ^ 2
33 = 31 + 2 * 1 ^ 2

It turns out that the conjecture was false.

What is the smallest odd composite that cannot be written as the sum of a prime
and twice a square?
"""

from prime import primes_i


def odd_composite():
  """generator of odd composite number"""
  num = 1
  while True:
    num += 2
    if all(map(lambda n: num % n != 0, range(2, num))):
      # num is prime, so skip it.
      continue
    yield num


def square():
  """generator of square number"""
  n = 0
  while True:
    n += 1
    yield n ** 2


def is_twice_of_square(num):
  """xxx"""
  if (num & 1) == 1:
    # num is odd, so cannot twice of number
    return False
  n = num / 2
  for sq in square():
    if n == sq:
      return True
    if n < sq:
      return False


def is_sum_pt(num):
  """
  check whether num can written as
  the sum of a prime and twice a square
  """
  for p in primes_i():
    if num <= p:
      break
    if is_twice_of_square(num - p):
      return True  # satisfy property.
  return False


def main():
  """main function"""
  for num in odd_composite():
    if not is_sum_pt(num):
      # found answer number. goto out of loop.
      break
  print num


if __name__ == "__main__":
  main()
