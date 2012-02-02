#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
2 ** 15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.

What is the sum of the digits of the number 2 ** 1000?
"""

INPUT_NUM = 1000


def mult2(nlst):
  """calclulate double of nlst """
  over = 0
  for i in range(len(nlst)):
    v = nlst[i] * 2 + over
    over, nlst[i] = divmod(v, 10)
  if over > 0:
    nlst.append(over)


def bvalue(num):
  """
  return '2 ** num' as the digit list
  eg) bvalue(15) = [3, 2, 7, 6, 8] = 32768 = 2 ** 15
  """
  val = [1]
  for i in range(num):
    mult2(val)
  val.reverse()
  return val


def main(num):
  """main function"""
  print sum(bvalue(num))


if __name__ == "__main__":
  main(INPUT_NUM)
