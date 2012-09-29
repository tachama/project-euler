#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
An irrational decimal fraction is created by concatenating the positive
integers:

  0.12345678910 1 112131415161718192021...

It can be seen that the 12-th digit of the fractional part is 1.

If d(n) represents the n-th digit of the fractional part, find the value of
the following expression.

  d(1) * d(10) * d(100) * d(1000) * d(10000) * d(100000) * d(1000000)
"""

def d(n):
  """get d(n) value"""
  digit = 1
  sum = 0
  s = (9 * (10 ** (digit - 1))) * digit
  while n > sum + s:
    sum += s
    digit += 1
    s = (9 * (10 ** (digit - 1))) * digit
  nidx = n - sum - 1
  d = nidx % digit
  answer = ((nidx / digit) / (10 ** (digit - d - 1))) % 10
  if d == 0:  # if d == 0, it means value is most significant, so add +1
    answer += 1
  return answer


def main():
  """main function"""
  # index of target number; 1, 10, .. , 1000000
  targets = map(lambda x: 10 ** x, range(7))
  product = lambda a, b: a * b
  print reduce(product, map(d, targets))


if __name__ == "__main__":
  main()
