#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Starting with the number 1 and moving to the right in a clockwise direction
a 5 by 5 spiral is formed as follows:

  21 22 23 24 25
  20  7  8  9 10
  19  6  1  2 11
  18  5  4  3 12
  17 16 15 14 13

It can be verified that the sum of the numbers on the diagonals is 101.

What is the sum of the numbers on the diagonals in a 1001 by 1001 spiral formed
in the same way?
"""

SIZE = 1001  # problem input size


def main(size):
  """main function"""
  max = size / 2 + 1

  # found start number of each rectangle.
  # start number of rectangle n; s(n)...
  #   s(n+1) - f(n) = 8 * n  [n>=1]
  starts = [1,2]
  for i in range(1,max):
    val = starts[-1] + 4 * 2 * i
    starts.append(val)

  # calculate each sum of each rectangle.
  # sum of rectangle n; sum(n)
  #   sum(n) = (s(n) + 2 * n - 1) * 4 + 12 * n
  #          = 4 * s(n) + 20 * n - 4  [n>=1]
  sums = [1]
  for i in range(1, max):
    s = 4 * starts[i] + 20 * i - 4
    sums.append(s)

  print sum(sums)  # answer.


if __name__ == "__main__":
  main(SIZE)
