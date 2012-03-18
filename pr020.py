#!/usr/bin/env python2
# -*- coding: utf-8 -*-

"""
n! means n *(n  1) * ... * 3 * 2 * 1

For example, 10! = 10 * 9 * ... * 3 * 2 * 1 = 3628800,
and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.

Find the sum of the digits in the number 100!
"""

INPUT_NUM = 100


def factrial(num):
  """factorial of number"""
  if num == 1:
    return 1
  else:
    return num * factrial(num - 1)


def digits_sum(val):
  """sum of digits of number"""
  lst = list(str(val))  # convert number to list of digits char
  return sum(map(int, lst))


def main(num):
  """main function"""
  print digits_sum(factrial(num))


if __name__ == "__main__":
  main(INPUT_NUM)
