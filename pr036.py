#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
The decimal number, 585 = 1001001001b (binary), is palindromic in both bases.

Find the sum of all numbers, less than one million, which are palindromic in
base 10 and base 2.

(Please note that the palindromic number, in either base, may not include
leading zeros.)
"""

MAX_NUMBER = 1000000  # problem max number


def palindromic(s):
  if not s:  # empty list
    return True
  if s[0] == s[-1]:
    return palindromic(s[1:-1])
  else:
    return False


def binstr(num):
  """binary explation of num"""
  lst = []
  d = num
  while d > 0:
    d, m = divmod(d, 2)
    lst.append(chr(ord('0') + m))
  return "".join(lst)


def is_palindromic(num):
  """num is palindromic in base 10 and base 2"""
  num10 = str(num)
  if palindromic(num10):
    num2 = binstr(num)
    return palindromic(num2)
  else:
    return False


def main():
  """main function"""
  print sum(filter(is_palindromic, range(MAX_NUMBER)))


if __name__ == "__main__":
  main()
