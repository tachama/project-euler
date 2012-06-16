#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
We shall say that an n-digit number is pandigital if it makes use of all the
digits 1 to n exactly once; for example, the 5-digit number, 15234, is 1
through 5 pandigital.

The product 7254 is unusual, as the identity, 39 * 186 = 7254, containing
multiplicand, multiplier, and product is 1 through 9 pandigital.

Find the sum of all products whose multiplicand/multiplier/product identity can
be written as a 1 through 9 pandigital.

HINT: Some products can be obtained in more than one way so be sure to only
include it once in your sum.
"""

DIGITS = "123456789"


def rotate(s, n):
  """rotate string"""
  return s[n:] + s[:n]


def permutation(s):
  """permutation list"""
  if not s:  # s is empty list.
    return [[]]
  else:
    rt = map(lambda n: rotate(s, n), range(0, len(s)))
    rts = map(lambda r: map(lambda x: [r[0]] + x, permutation(r[1:])),  rt)
    return reduce(lambda a, b: a + b, rts)


def remove_dup(lst):
  """remove duplicate element from lst"""
  return list(set(lst))


def divide_pattern(n):
  """pattern for devide3"""
  f = lambda a, b, c: (a + b - 1 == c) or (a + b == c)
  return [(a,b) for a in range(1,n-1) for  b in range(1, n-a) if f(a,b,(n-a-b))]


def divide3(s, t):
  """divide string to three parts and convert integer."""
  s1 = s[:t[0]]
  tmp = s[t[0]:]
  s2 = tmp[:t[1]]
  s3 = tmp[t[1]:]
  return (int(s1), int(s2), int(s3))


def is_mmp(triple):
  """check triple is mmp (a * b = c)"""
  if triple[0] >= triple[1]:
    return False
  return triple[0] * triple[1] == triple[2]


def main():
  """main function"""
  digits = map(lambda s: "".join(s), permutation(DIGITS))
  pattern = divide_pattern(len(DIGITS))

  # create all number pattern that use all digits.
  # XXX: I want to use reduce. but it is too slow because large list copy.
  alls = []
  for d in digits:
    tmp = map(lambda p: divide3(d, p), pattern)
    alls.extend(tmp)

  # pickup triples that is mmp.
  mmps = filter(is_mmp, alls)
  products = map(lambda t: t[2], mmps)  # product only.

  # sum of products. remove duplicate
  print sum(remove_dup(products))


if __name__ == "__main__":
  main()
