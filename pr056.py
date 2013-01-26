#!/usr/bin/env python
# -*- coding: utf-8 -*-

'''
A googol (10**100) is a massive number: one followed by one-hundred zeros;
100**100 is almost unimaginably large: one followed by two-hundred zeros.
Despite their size, the sum of the digits in each number is only 1.

Considering natural numbers of the form, a**b, where a, b < 100, what is
the maximum digital sum?
'''


def main():
  '''main function'''
  sum_digit = lambda n: sum(map(int, list(str(n))))
  ab_lst = [(a,b) for a in range(1,100) for b in range(1,100)]
  print max(map(lambda t: sum_digit(t[0] ** t[1]), ab_lst))


if __name__ == '__main__':
  main()
