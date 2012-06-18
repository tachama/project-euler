#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
The number, 197, is called a circular prime because all rotations of the
digits: 197, 971, and 719, are themselves prime.

There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37, 71,
73, 79, and 97.

How many circular primes are there below one million?
"""

# problem max number.
MAX_NUMBER = 1000000
primes = None  # glbal prime number list craete at create_primes()

def create_primes(num):
  """build prime numbers by eratoshenes algorithm (ref. pr010.py)"""
  global primes
  nums = range(num)
  chks = [True] * num
  for n in nums[2:]:
    if chks[n]:
      idx = n * 2
      while idx < num:
        chks[idx] = False
        idx += n
  primes = [nums[i] for i in nums[2:] if chks[i]]


def has_even(num):
  """num contain even digit"""
  s = str(num)
  return (num != 2) and (any(map(lambda a: s.count(a) > 0, list("02468"))))


def rotate(num, x):
  """rotate number to x"""
  s = str(num)
  return int(s[x:] + s[:x])


def is_circular(num):
  """check num is circular prime or not"""
  if has_even(num):
    return False
  else:
    is_prime = lambda x: x in primes
    rnums = map(lambda x: rotate(num, x), range(0, len(str(num))))
    return all(map(is_prime, rnums))


def main():
  """main function"""
  create_primes(MAX_NUMBER)
  print len(filter(is_circular, primes))


if __name__ == "__main__":
  main()
