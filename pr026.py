#!/usr/bin/env python2
# -*- coding: utf-8 -*-

"""
A unit fraction contains 1 in the numerator. The decimal representation of the
unit fractions with denominators 2 to 10 are given:

  1/2  = 0.5
  1/3  = 0.(3)
  1/4  = 0.25
  1/5  = 0.2
  1/6  = 0.1(6)
  1/7  = 0.(142857)
  1/8  = 0.125
  1/9  = 0.(1)
  1/10 = 0.1

Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle. It can be
seen that 1/7 has a 6-digit recurring cycle.

Find the value of d < 1000 for which 1/d contains the longest recurring cycle
in its decimal fraction part.
"""

MAX_NUM = 1000  # max number of problem input.


def recurring_cycle(lst, dm):
  """
  found recurring cycle in lst.
  if not exist, return None
  """
  if not lst:
    return None
  else:
    # XXX: check only last of list because this function called each time.
    if lst[0] == dm:
      return str(reduce(lambda a, b: a * 10 + b, map(lambda t: t[0], lst)))
    else:
      return recurring_cycle(lst[1:], dm)


def fraction(num):
  """
  return reurring cycle of unit fraction of num; (1 / num)
  """
  work = [(0, 1)]
  while True:
    val = work[-1][1] * 10
    d, m = divmod(val, num)
    if m == 0:
      # fraction has no recurring cycle.
      return ""
    cycle = recurring_cycle(work, (d, m))
    if cycle:
      return cycle
    else:
      work.append((d, m))


def compare_tuple(t1, t2):
  """
  compare tuple with second element length.
  """
  return len(t2[1]) - len(t1[1])


def main(num):
  """
  main function.
  """
  nums = range(2, num)
  fracs = [fraction(i) for i in nums]
  pairs = zip(nums, fracs)
  pairs.sort(compare_tuple)
  print pairs[0][0]  # print second element of list head.


if __name__ == "__main__":
  main(MAX_NUM)
