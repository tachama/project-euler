#!/usr/bin/env python2
# -*- coding: utf-8 -*-
#

'''
Problem 10
The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.

Find the sum of all the primes below two million.
'''

INPUT_NUM = 2000000

def eratoshenes(num):
  '''eratoshenes algorithm for prime numbers'''
  num_lst = range(num)   # list of all number; [0,1,2...]
  prm_lst = [True for i in num_lst]  # number in num_lst is prime ?
  idx = 2
  while idx < num:
    if prm_lst[idx]:  # check number is marked as prime ?
      # mark all multiples as NOT prime
      idx2 = 2 * idx
      while idx2 < num:
        prm_lst[idx2] = False
        idx2 += idx
    idx += 1
  # return number that marked prime. except 0 and 1.
  return [n for b, n in zip(prm_lst, num_lst)[2:] if b]

def main(num):
  '''main function'''
  print sum(eratoshenes(num))

if __name__ == '__main__':
  main(INPUT_NUM)
