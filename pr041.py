#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
We shall say that an n-digit number is pandigital if it makes use ofall the
digits 1 to n exactly once. For example, 2143 is a 4-digit pandigital and is
also prime.

What is the largest n-digit pandigital prime that exists?
"""

from prime import is_prime_os   # use my original prime module.


def consnums(n1, n2):
  """cons two nums; e.g.) consnums(123, 345) = 123456"""
  num2lst = lambda x: map(int, list(str(x)))
  lst2num = lambda l: int("".join(map(str, l)))
  return lst2num(num2lst(n1) + num2lst(n2))


def create_nums(lst):
  """create number form digits list"""
  if len(lst) == 1:
    # only one elements. just return.
    return lst
  else:
    remove_list = lambda x, ns: filter(lambda n: n != x, ns)
    answer = []
    for l in lst:
      answer.extend(map(lambda n: consnums(l, n),
                        create_nums(remove_list(l, lst))))
    return answer


def digit_nums(n):
  """create n-digit number"""
  return create_nums(range(1, n + 1))


def main():
  """main function."""
  concat = lambda l: reduce(lambda a, b: a + b, l)
  # search max is 7-digit
  print max(filter(is_prime_os, concat(map(digit_nums, range(1, 8)))))


if __name__ == "__main__":
  main()

# Memo
#   If sum of N is product of 3, N is product of 3,
#   so N-digit is same rule.
#     9-digit is pruduct of 9; sum(1..9) = 45 = 3 * 15
#     8-digit is product of 8; sum(1..8) = 36 = 3 * 12
#   So, search only 1-digit to 7-digit.
