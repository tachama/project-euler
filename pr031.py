#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
In England the currency is made up of pound, £, and pence, p, and there are
eight coins in general circulation:

  1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).

It is possible to make £2 in the following way:

  1 * £1 + 1 * 50p + 2 * 20p + 1 * 5p + 1 * 2p + 3 * 1p

How many different ways can £2 be made using any number of coins?
"""

# type of coin.
coins = [200, 100, 50, 20, 10, 5, 2, 1]

def coins_pattern(value, cs=coins):
  if value == 0:
    return 1
  if not cs:
    return 0
  m = value / cs[0]
  return sum(map(lambda x: coins_pattern(value - x * cs[0], cs[1:]),
                 range(0, m+1)))

def main():
  """main function"""
  print coins_pattern(200)

if __name__ == "__main__":
  main()
