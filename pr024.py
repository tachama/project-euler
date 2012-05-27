#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
A permutation is an ordered arrangement of objects. For example, 3124 is one
possible permutation of the digits 1, 2, 3 and 4. If all of the permutations
are listed numerically or alphabetically, we call it lexicographic order.
The lexicographic permutations of 0, 1 and 2 are:

  012   021   102   120   201   210

What is the millionth lexicographic permutation of the
digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?
"""

from math import factorial

TARGET_NUM = 1000000


def solve(inlst, value, outlst=[]):
  """
  solve problem recursibly
  """
  if not inlst:
    return outlst
  d, m = divmod(value, factorial(len(inlst) - 1))
  return solve(inlst[:d] + inlst[d+1:], m, outlst + [inlst[d]])


def main():
  """
  main function
  """
  lst = solve(range(10), TARGET_NUM - 1)
  print reduce(lambda a, b: a * 10 + b, lst)

if __name__ == "__main__":
  main()
