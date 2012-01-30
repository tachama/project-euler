#!/usr/bin/env python2
# -*- coding: utf-8 -*-

'''
Problem 14

The following iterative sequence is defined for the set of positive integers:

  n = n/2 (n is even)
  n = 3n + 1 (n is odd)

Using the rule above and starting with 13, we generate the following sequence:

  13  40  20  10  5  16  8  4  2  1

It can be seen that this sequence (starting at 13 and finishing at 1) contains
10 terms. Although it has not been proved yet (Collatz Problem), it is thought
that all starting numbers finish at 1.

Which starting number, under one million, produces the longest chain?

NOTE: Once the chain starts the terms are allowed to go above one million.
'''

INPUT_NUM = 1000000

def seqlen(num):
  '''return length of sequence of num'''
  n = num
  length = 1
  while n != 1:
    length += 1
    if n % 2 == 0:
      n = n / 2
    else:
      n = 3 * n + 1
  return length

def seq(num):
  '''get sequence of number'''
  n = num
  lst = [n]
  while n != 1:
    if n % 2 == 0:
      n = n / 2
    else:
      n = 3 * n + 1
    lst.append(n)
  return lst

def main(num):
  '''main function'''
  maxlen = 0
  maxnum = -1  # initial value
  for n in range(1, num):
    l = seqlen(n)
    if l > maxlen:
      maxlen = l
      maxnum = n
  print maxnum

if __name__ == '__main__':
  main(INPUT_NUM)
