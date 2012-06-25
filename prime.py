#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
prime related functions
"""

# global variables for optimization.
_primes = [2, 3]  # prime number list.
_primes_len = 2   # length of _primes
_primes_max = 3   # maximum value in _primes


def _grow_primes():
  """grow global prime number list"""
  global _primes
  global _primes_len
  global _primes_max
  val = _primes_max
  not_found = True
  while not_found:
    val += 1
    if all(map(lambda x: val % x != 0, _primes)):
      _primes.append(val)
      _primes_len += 1
      _primes_max = val
      not_found = False


def primes_i(start=0):
  """prime number generator (iterator)"""
  global _primes_len
  global _primes
  idx = 0
  while True:
    while idx >= _primes_len:
      _grow_primes()
    if _primes[idx] >= start:
      yield _primes[idx]
    idx += 1


def is_prime(num):
  """check num is prome?"""
  global _primes
  global _primes_max
  while num > _primes_max:
    _grow_primes()
  return _primes.count(num) == 1


def is_prime_os(num):
  """check num is prime?, one shot version"""
  if num != 2 and num % 2 == 0:
    return False
  for i in range(3, num, 2):
    if num % i == 0:
      return False
  return True


def primes(num):
  """
  return primes list below num.
  generate primes with eratoshnes algorithm
  XXX: not use global _primes
  """
  is_p = [True] * num
  # 0 and 1 is not prime.
  is_p[0] = False
  is_p[1] = False
  for i in range(2, num):
    if is_p[i]:
      # unset prime flag
      for j in range(i * 2, num, i):
        is_p[j] = False
  # filter only set prime flag
  return filter(lambda x: is_p[x], range(2, num))


if __name__ == "__main__":
  # do nothing. only print warning message.
  print "This is module excepted to used from other program."
