#!/usr/bin/env python2
# -*- coding: utf-8 -*-
#

'''
Problem 2

Each new term in the Fibonacci sequence is generated by adding the previous two
terms. By starting with 1 and 2, the first 10 terms will be:

  1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...

By considering the terms in the Fibonacci sequence whose values do not exceed
four million, find the sum of the even-valued terms.
'''

INPUT_NUM = 4000000  # four million

def fibonnaci(num):
  '''create fibonnaci seq less than num'''
  fib = [1, 2]  # 1st term is '1', 2nd is '2'
  idx = 2
  val = fib[idx - 2] + fib[idx - 1]
  while val < num:
    fib.append(val)
    idx += 1
    val = fib[idx - 2] + fib[idx - 1]
  return fib

def main(num):
  '''main function'''
  print sum(filter((lambda x: x % 2 == 0), fibonnaci(num)))

if __name__ == '__main__':
  main(INPUT_NUM)
