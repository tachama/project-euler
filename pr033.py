#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
The fraction 49/98 is a curious fraction, as an inexperienced mathematician
in attempting to simplify it may incorrectly believe that 49/98 = 4/8, which
is correct, is obtained by cancelling the 9s.

We shall consider fractions like, 30/50 = 3/5, to be trivial examples.

There are exactly four non-trivial examples of this type of fraction, less
than one in value, and containing two digits in the numerator and denominator.

If the product of these four fractions is given in its lowest common terms,
find the value of the denominator.
"""


def simplify(n1, n2):
  """return simplify number pair if exist."""
  # convert number to char list
  ns1 = list(str(n1))
  ns2 = list(str(n2))
  for x in ns1:
    if x != '0' and x in ns2:  # skip trivial (x = '0')
      ns1.remove(x)
      ns2.remove(x)
      return int("".join(ns1)), int("".join(ns2))
  return None


def is_curious(nums):
  """check num / den is curious nunber or not"""
  sims = simplify(nums[0], nums[1])
  if not sims:
    return False
  return nums[0] * sims[1] == nums[1] * sims[0]


def lowest_common(t):
  """return lowest common terms of num / den"""
  num = t[0]
  den = t[1]
  for x in range(2, num+1):
    if num < x:
      return num, den
    while num % x == 0 & den % x == 0:
      num = num / x
      den = den / x
  return num, den


def main():
  """main function"""
  nums = [(a,b) for a in range(10,100) for b in range(a+1,100)]
  curiouses = filter(is_curious, nums)
  product = reduce(lambda a,b:(a[0]*b[0], a[1]*b[1]), curiouses)
  print lowest_common(product)[1]


if __name__ == "__main__":
  main()
