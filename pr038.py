#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Take the number 192 and multiply it by each of 1, 2, and 3:

  192 * 1 = 192
  192 * 2 = 384
  192 * 3 = 576

By concatenating each product we get the 1 to 9 pandigital, 192384576. We will
call 192384576 the concatenated product of 192 and (1,2,3)

The same can be achieved by starting with 9 and multiplying by 1, 2, 3, 4, and
5, giving the pandigital, 918273645, which is the concatenated product of 9 and
(1,2,3,4,5).

What is the largest 1 to 9 pandigital 9-digit number that can be formed as the
concatenated product of an integer with (1,2, ... , n) where n > 1?
"""

def is_pandigital(s):
  """check whether string s is pandigital"""
  tmp = list(s)
  if len(tmp) != 9:
    return False
  else:
    tmp.sort()
    return "".join(tmp) == "123456789"


def gen_pandigital(n):
  """
  generate pandigital number from n.
  return None if cannot generate pandigital from n
  """
  idx = 1
  while True:
    v = reduce(lambda s, x: s + str(x),
               map(lambda x: n * (x + 1), range(idx)), "")
    # v is string expression.
    if len(v) > 9:
      return None
    if is_pandigital(v):
      return int(v)
    idx += 1


def main():
  """main function"""
  # seach value is [1..9999] because condition means "val*1 and val*2"
  # if val >= 10000, digits of "val*1" is more than 5, and digits of "val*2"
  # is more than 5. so sum of digits is greater than 10, and not pandigital.
  max_num = 10000
  print max(map(gen_pandigital, range(1, max_num)))


if __name__ == "__main__":
  main()
