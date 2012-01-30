#!/usr/bin/env python2
# -*- coding: utf-8 -*-

'''
Problem 15
Starting in the top left corner of a 2 x 2 grid,
there are 6 routes (without backtracking) to the bottom right corner.

How many routes are there through a 20 x 20 grid?
'''

INPUT_WIDTH = 20
INPUT_HEIGHT = 20

def mults(m, n=0):
  '''mults of continuous num'''
  r = 1
  for i in range(m, n, -1):
    r *= i
  return r

def combination(n, x):
  '''conbination of n ,x'''
  return mults(n, n - x) / mults(x)

def main(width, height):
  '''main function'''
  print (combination(width + height, width))

if __name__ == '__main__':
  main(INPUT_WIDTH, INPUT_HEIGHT)
