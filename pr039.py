#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
If p is the perimeter of a right angle triangle with integral length sides,
{a,b,c}, there are exactly three solutions for p = 120.

  {20,48,52}, {24,45,51}, {30,40,50}

For which value of p < 1000, is the number of solutions maximised?
"""

def triple(n):
  """
  generate triple (a,b,c,),
  where a + b + c = n and a <= b <= c
  """
  # it is ok that b is more than n/3, but it is not ok that c is more than n/3
  return [(a, b, n-a-b) for a in range(1, n / 3 + 1)
                        for b in range(a, (n - a) / 2 + 1)]


def is_right_trianble(t):
  """is right trianble ?"""
  return t[0] ** 2 + t[1] ** 2 == t[2] ** 2


def nsolution(n):
  """number of solutions at n"""
  return len(filter(is_right_trianble, triple(n)))


def main():
  """main function"""
  max_enum = max(enumerate(map(nsolution, range(1, 1000))),
                 key=lambda x: x[1])
  # format of max_enum is "(number, solutions)" and number is start with 0,
  # so answer is "number + 1"
  print max_enum[0] + 1


if __name__ == "__main__":
  main()
