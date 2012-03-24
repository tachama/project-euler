#!/usr/bin/env python2
# -*- coding: utf-8 -*-

"""
A perfect number is a number for which the sum of its proper divisors is
exactly equal to the number. For example, the sum of the proper divisors
of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.

A number n is called deficient if the sum of its proper divisors is less than
n and it is called abundant if this sum exceeds n.

As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest
number that can be written as the sum of two abundant numbers is 24.
By mathematical analysis, it can be shown that all integers greater than 28123
can be written as the sum of two abundant numbers. However, this upper limit
cannot be reduced any further by analysis even though it is known that the
greatest number that cannot be expressed as the sum of two abundant numbers is
less than this limit.

Find the sum of all the positive integers which cannot be written as the sum of
two abundant numbers.
"""

# all integer greater than 28123 can be written as a sum of two abundant
# numbers. so consider number limit is 28123 at this problem.
NUM_LIMIT = 28123


def divisors(num):
  """return divisors of num"""
  return [x for x in range(1,num) if num % x == 0]


def get_abundants(limit):
  """abundant number list under limit."""
  return [n for n in range(1, limit) if n < sum(divisors(n))]


def search(num, lst, length):
  """binary search for sorted list; loop version."""
  start = 0
  end = length  # len(lst)
  while start <= end:
    idx = start + (end - start) / 2
    if lst[idx] == num:
      return idx  # found num in lst.
    if lst[idx] < num:
      start = idx + 1
    else:  # lst[idx] > num
      end = idx - 1
  return None  # num is not found in lst. return None object.


# binary search; recursive call version.
# XXX: I not use this version for optimization
def search_rec(num, lst, start, end):
  """binary search for sorted list: recursive version."""
  if start > end:
    return None  # num is not found in lst, return None object.
  idx = start + (end - start) / 2
  if lst[idx] == num:
    return idx  # found num in lst.
  elif lst[idx] < num:
    return search(num, lst, idx+1, end)
  else: # lst[idx] > num
    return search(num, lst, start, idx-1)


def can_sum(num, abundants):
  """num can written as the sum of two abundant numbers"""
  length = len(abundants)   # XXX: calclulate length on each the func call...
  for i in abundants:
    if i >= num:
      return False
    if search(num-i, abundants, length) is not None:  # found in abundants
      return True
  return False


def main():
  """main function"""
  abundants = get_abundants(NUM_LIMIT+1)
  lst = [n for n in range(1, NUM_LIMIT+1) if not can_sum(n, abundants)]
  print sum(lst)


if __name__ == "__main__":
  main()
