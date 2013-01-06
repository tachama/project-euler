#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
The arithmetic sequence, 1487, 4817, 8147, in which each of the terms increases
by 3330, is unusual in two ways: (i) each of the three terms are prime, and,
(ii) each of the 4-digit numbers are permutations of one another.

There are no arithmetic sequences made up of three 1-, 2-, or 3-digit primes,
exhibiting this property, but there is one other 4-digit increasing sequence.

What 12-digit number do you form by concatenating the three terms in this
sequence?
"""

from prime import primes


def is4digit(num):
  """num is 4-digit number or not"""
  return num >= 1000 and num < 10000


def permutations(n1, n2, n3):
  """check three number is permutations or not"""
  l1 = list(str(n1))
  l1.sort()
  l2 = list(str(n2))
  l2.sort()
  l3 = list(str(n3))
  l3.sort()
  return "".join(l1) == "".join(l2) == "".join(l3)


def found_3arithmetic(lst):
  """find 3 arithmetic sequence from lst"""
  arithmetics = []
  length = len(lst)
  for i in range(length):
    num1 = lst[i]
    for j in range(i+1, length):
      num2 = lst[j]
      num3 = num2 + (num2 - num1)
      if lst.count(num3) > 0:
        if permutations(num1, num2, num3):
          arithmetics.append([num1, num2, num3])
  return arithmetics


def main():
  """main function"""
  primes_4digits = filter(is4digit, primes(10000))
  ars = found_3arithmetic(primes_4digits)
  # found unknonw triples.
  for ar in ars:
    if ar[0] != 1487:
      print reduce(lambda a,b:a+b, map(str, ar))
      break;  # out to loop


if __name__ == '__main__':
  main()
