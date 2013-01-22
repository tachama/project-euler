#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
There are exactly ten ways of selecting three from five, 12345:

  123, 124, 125, 134, 135, 145, 234, 235, 245, and 345

In combinatorics, we use the notation, 5C3 = 10.

In general,

  nCr = n! / (r! (n-r)!)
  ,where r <= n, n! = n*(n1)*...*3*2*1, and 0! = 1.

It is not until n = 23, that a value exceeds one-million: 23C10 = 1144066.

How many, not necessarily distinct, values of  nCr, for 1 <=n <= 100,
are greater than one-million?
"""

ONEMILLION = 1000000

def combination(n, r):
  """conbination; nCr"""
  val = 1
  for i in range(n, n-r, -1):
    val *= i
  for i in range(r, 0, -1):
    val /= i
  return val

def main():
  """main function"""
  nover = 0
  for n in range(1,100+1):
    for r in range(1,n+1):
      ncomb = combination(n, r)
      if ncomb > ONEMILLION:
        nover += 1
  print nover

if __name__ == '__main__':
  main()
