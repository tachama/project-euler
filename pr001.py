#!/usr/bin/env python2
# -*- coding: utf-8 -*-
#

'''
Problem 1

If we list all the natural numbers below 10 that are multiples of 3 or 5,
we get 3, 5, 6 and 9. The sum of these multiples is 23.

Find the sum of all the multiples of 3 or 5 below 1000.
'''

INPUT_NUM = 1000

def mults_3_5(num):
  '''calculate sum of multiples of 3 or 5 below num'''
  return [x for x in range(1, num)
                  if (x % 3 == 0) or (x % 5 == 0)]

def main(num):
  '''print sum of multiples of 3 or 5 below num'''
  print sum(mults_3_5(num))

if __name__ == '__main__':
  main(INPUT_NUM)
