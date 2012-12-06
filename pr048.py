#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
The series, 1**1 + 2**2 + 3**3 + ... + 10**10 = 10405071317.

Find the last ten digits of the series, 1**1 + 2**2 + 3**3 + ... + 1000**1000.
"""

def main():
  """main function"""
  sum = reduce(lambda a, b: a + b,
               map(lambda x: x ** x, range(1, 1001)))
  print int(str(sum)[-10:])


if __name__ == "__main__":
  main()
