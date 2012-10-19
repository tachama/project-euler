#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
The number, 1406357289, is a 0 to 9 pandigital number because it is made up of
each of the digits 0 to 9 in some order, but it also has a rather interesting
sub-string divisibility property.

Let d(1) be the 1st digit, d(2) be the 2nd digit, and so on. In this way, we
note the following:

  d(2)d(3)d(4)=406 is divisible by 2
  d(3)d(4)d(5)=063 is divisible by 3
  d(4)d(5)d(6)=635 is divisible by 5
  d(5)d(6)d(7)=357 is divisible by 7
  d(6)d(7)d(8)=572 is divisible by 11
  d(7)d(8)d(9)=728 is divisible by 13
  d(8)d(9)d(10)=289 is divisible by 17

Find the sum of all 0 to 9 pandigital numbers with this property.
"""


# global primes list for check property.
primes = [2,3,5,7,11,13,17]


def list_to_num(lst):
  """convert digit list to number"""
  return reduce(lambda a, b: a * 10 + b, lst)


def del_from_lst(num, lst):
  """return list except num from lst"""
  return filter(lambda x: x != num, lst)


def make_pandigital_sub(lst):
  """subroutine for make_pandigital"""
  if len(lst) == 1:
    return [lst]
  else:
    ret_lst = []
    for x in lst:
      tmp = make_pandigital_sub(del_from_lst(x, lst))
      tmp2 = map(lambda l: [x] + l, tmp)
      ret_lst.extend(tmp2)
    return ret_lst


def make_pandigitals():
  """create all numbers that is a 0 to 9 pandigitals"""
  tmp = map(list_to_num, make_pandigital_sub(range(10)))
  return filter(lambda x: x > 1000000000, tmp)


def can_div(x, y):
  """x can be devided by y ?"""
  return (x % y == 0)


def has_property(num):
  """check num has this problem propertiy"""
  return all(map(lambda n: can_div(pick3_num(num, n+1), primes[n]), range(7)))


def pick3_num(num, x):
  """pickup 3 number from num, digit x to digit (x+3)"""
  return int("".join(list(str(num))[x:x+3]))


def main():
  """main function"""
  pandigitals = make_pandigitals()
  print sum(filter(has_property, pandigitals))


if __name__ == "__main__":
  main()
