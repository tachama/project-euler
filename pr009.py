#!/usr/bin/env python2
# -*- coding: utf-8 -*-
#

'''
Problem 9
A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,

a ** 2 + b ** 2 = c ** 2
For example, 32 + 42 = 9 + 16 = 25 = 52.

There exists exactly one Pythagorean triplet for which a + b + c = 1000.
Find the product abc.
'''

def triplet(b, c):
  '''
  whether check a, b, c is pythagorean triplet?

  a ** 2 + b ** 2 = c ** 2
  a ** 2 = c ** 2 - b ** 2
         = (c + b) * (c - b)

  a + b + c = 1000
  a = 1000 - b - c
  '''
  return ((1000 - b - c) ** 2 == (c + b) * (c - b)) and 1000 - b - c < b

def main():
  (b, c) = [(b, c) for b in range(1,500)
                   for c in range(b+1,1000) if triplet(b, c)][0]
  print (1000 - b - c) * b * c

if __name__ == '__main__':
  main()
