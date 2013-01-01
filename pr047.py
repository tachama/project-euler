#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
The first two consecutive numbers to have two distinct prime factors are:

  14 = 2 * 7
  15 = 3 * 5

The first three consecutive numbers to have three distinct prime factors are:

  644 = (2 ** 2) * 7 * 23
  645 = 3 * 5 * 43
  646 = 2 * 17 * 19

Find the first four consecutive integers to have four distinct primes factors.
What is the first of these numbers?
"""

from prime import primes_i

def num_of_prime_factors(num):
  """return number of prime factor. this is distinct prime factors"""
  n = num
  pfs = 0  # num of prime factor
  for p in primes_i():
    if n % p == 0:
      # p is prime factor of n
      pfs += 1
      while n % p == 0:
        n = n / p
    if n == 1:
      break;
  return pfs


def sub(num):
  """
  sub routine for solve problem
  argument is even number has 4 distinct prime factor
  search number
  """
  if num_of_prime_factors(num - 1) == 3:
    if num_of_prime_factors(2 * num - 1) == 4:
      if num_of_prime_factors(2 * num - 3) == 4:
        # 2*num-3, 2*num-2, 2*num-1, 2*num
        return 2 * num - 3
      if num_of_prime_factors(2 * num + 1) == 4:
        # 2*num-2, 2*num-1, 2*num, 2*num+1
        return 2 * num - 2
  if num_of_prime_factors(num + 1) == 3:
    if num_of_prime_factors(2 * num + 1) == 4:
      if num_of_prime_factors(2 * num - 1) == 4:
        # 2*num-1, 2*num, 2*num+1, 2*num+2
        return 2 * num - 1
      if num_of_prime_factors(2*num + 3) == 4:
        # 2*num, 2*num+1, 2*num+2, 2*num+3
        return 2*num
  return None


def main():
  """main function"""
  num = 2
  answer = None
  while True:
    if num_of_prime_factors(num) == 4:
      # found even number has 4 distinct prime number
      answer = sub(num)
      if answer:
        break;
    num += 2
  print answer


if __name__ == '__main__':
  main()
