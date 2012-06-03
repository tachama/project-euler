#!/usr/bin/env python2
# -*- coding: utf-8 -*-

"""
Euler published the remarkable quadratic formula:

  n ** 2 + n + 41

It turns out that the formula will produce 40 primes for the consecutive
values n = 0 to 39. However, when n = 40, 40 ** 2 + 40 + 41 = 40(40 + 1) + 41
is divisible by 41, and certainly when n = 41, 41 ** 2 + 41 + 41 is clearly
divisible by 41.

Using computers, the incredible formula  n ** 2 - 79 * n + 1601 was discovered,
which produces 80 primes for the consecutive values n = 0 to 79. The product
of the coefficients, -79 and 1601, is -126479.

Considering quadratics of the form:

  n ** 2 + a * n + b, where |a| < 1000 and |b| < 1000

  where |n| is the modulus/absolute value of n
  e.g. |11| = 11 and |4| = 4

Find the product of the coefficients, a and b, for the quadratic expression
that produces the maximum number of primes for consecutive values of n,
starting with n = 0.
"""

ABS_MAX = 1000  # problem input for thres

primes = [2, 3]  # global list of prime number


def grow_prime(num):
  """grow global prime list to num"""
  global primes
  for n in range(primes[-1], num + 1, 2):
    if all(map(lambda x: n % x != 0, primes)):
      primes.append(n)


def is_prime(num):
  """check num is prime or not"""
  global primes
  if num > primes[-1]:
    grow_prime(num)
  for n in primes:
    if n == num:
      return True
    if n > num:
      return False
  return False


def formula(a, b):
  """return function of problem formula"""
  return lambda n: n ** 2 + a * n + b


def prime_count(t):
  """return num of continuous using t (tuple of a and b)"""
  f = formula(t[0], t[1])
  n = 0
  while is_prime(f(n)):
    n += 1
  return n + 1


def main(n):
  """main function"""
  combs = [(a,b) for a in range(-n + 1, n) for b in range(-n + 1, n)]
  pairs = zip(combs, map(prime_count, combs))
  #ab, _ = max(pairs, key=lambda t: t[1])
  ab, length = max(pairs, key=lambda t: t[1])
  print ab, length
  print ab[0] * ab[1]


if __name__ == "__main__":
  main(ABS_MAX)
