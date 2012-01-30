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

def next_val(val):
  """return sequence next value"""
  if val % 2 == 0:  # even
    return val / 2
  else:  # odd
    return 3 * val + 1

def seqval(seq, length, idx):
  """return value of seq[idx]"""
  if idx < length:  # idx is in seq.
    if not seq[idx]:
      # if value is not created yet,
      # put the value in seq.
      seq[idx] = seqval(seq, length, next_val(idx)) + 1
    return seq[idx]
  else:  # idx is out of seq.
    return seqval(seq, length, next_val(idx)) + 1

def create_seq(maxidx):
  """create problem sequence"""
  seq = [None] * maxidx
  seq[1] = 1
  for i in range(1, maxidx):
    if not seq[i]:  # skip if already created.
      seq[i] = seqval(seq, maxidx, i)
  return seq

def main(num):
  '''main function'''
  # create None list for seq
  seq = create_seq(num + 1)
  print seq.index(max(seq[1:]))

if __name__ == '__main__':
  main(INPUT_NUM)
