#!/usr/bin/env python2
# -*- coding: utf-8 -*-
#
# XXX - this needs too many run-time...
#

'''
Problem 10
The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.

Find the sum of all the primes below two million.
'''

def eratoshenes(lst):
  idx = 0
  length = len(lst)
  while idx < length:
    n = lst[idx]
    for i in range(length - 1, idx, -1):
      if lst[i] % n == 0:
        lst.pop(i)   # is faster than 'del lst[i]' ?
    idx += 1
    length = len(lst)

def prime(num):
  '''create prime list by Eratoshenes'''
  lst = range(3,num,2)  # prepare only odd number (>= 3)
  eratoshenes(lst)
  lst.insert(0, 2)  # insert '2' to list head
  return lst

def main():
  print sum(prime(2000000))

if __name__ == '__main__':
  main()
