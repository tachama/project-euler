#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
It can be seen that the number, 125874, and its double, 251748, contain exactly
the same digits, but in a different order.

Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and 6x, contain
the same digits.
"""

NTARGET = 6


def digs(n):
  """string digit-sort of n"""
  lst = list(str(n))
  lst.sort()
  return lst


def main():
  """main function"""
  n = 1
  while True:
    digs_n = digs(n)
    digs_nx = map(digs, range(2*n, 6*n+1, n))
    if all(map(lambda x: x == digs_n, digs_nx)):
      break
    n += 1
  print n


if __name__ == "__main__":
  main()
