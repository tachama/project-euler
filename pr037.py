#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
The number 3797 has an interesting property. Being prime itself, it is possible
to continuously remove digits from left to right, and remain prime at each
stage: 3797, 797, 97, and 7. Similarly we can work from right to left: 3797,
379, 37, and 3.

Find the sum of the only eleven primes that are both truncatable from left to
right and right to left.

NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.
"""

import prime as p

TOTAL_NUMS = 11  # number of need found

# function for checking prime. (- this is tuning point)
func_prime = p.is_prime_os
#func_prime = p.is_prime


def digits(num):
  """return number of digits in num"""
  return len(str(num))


def join_num(n1, n2):
  """join two number"""
  return int(str(n1) + str(n2))


def next_right(lst):
  """grow digit of prime number to right"""
  l = [(a,b) for a in range(1,10) for b in lst]
  return filter(func_prime, map(lambda t: join_num(t[0],t[1]), l))


def next_left(lst):
  """grow digit of prime number to left"""
  l = [(b,a) for a in range(1,10) for b in lst]
  return filter(func_prime, map(lambda t: join_num(t[0],t[1]), l))


def can_combinate(pair):
  """check pair number (left, right) can combinated number"""
  left = pair[0]
  right = pair[1]
  return left % (10 ** (digits(left) - 1)) == right / 10


def combination_nums(llst, rlst):
  """return numbers that created by combinating llst and rlst"""
  comb = [(a,b) for a in llst for b in rlst]
  combinate = lambda lr: lr[0] * 10 + lr[1] % 10
  tmp =  map(combinate, filter(can_combinate, comb))
  return tmp


def main():
  """main function"""
  primes_r = p.primes(10)   # 1 digit primes.
  primes_l = p.primes(10)   # 1 digit_primes.
  answer = []
  while True:
    tmp = filter(func_prime, combination_nums(primes_l, primes_r))
    tmp.sort()
    answer.extend(list(set(tmp)))
    if len(answer) >= TOTAL_NUMS:
      # break out while loop.
      break;
    primes_r = next_right(primes_r)
    primes_l = next_left(primes_l)
  print sum(answer[:TOTAL_NUMS])  # print sum of first eleven


if __name__ == "__main__":
  main()
