#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
The prime 41, can be written as the sum of six consecutive primes:

  41 = 2 + 3 + 5 + 7 + 11 + 13

This is the longest sum of consecutive primes that adds to a prime below
one-hundred.

The longest sum of consecutive primes below one-thousand that adds to a prime,
contains 21 terms, and is equal to 953.

Which prime, below one-million, can be written as the sum of the most
consecutive primes?
"""

from prime import primes

NUM_MAX = 1000000  # problem max number.

def search(val, lst, idx1, idx2):
  """
  binary seach at sorted list.
  return value if found, None if not found
  """
  if idx1 > idx2:
    # not found in lst
    return None
  mid = (idx1 + idx2) / 2
  if val > lst[mid]:
    return search(val, lst, mid+1, idx2)
  elif val < lst[mid]:
    return search(val, lst, idx1, mid-1)
  else:
    # val is found at lst[mid]
    return val


def main():
  """main function"""
  prs = primes(NUM_MAX)  # prs is primes below NUM_MAX
  length = len(prs)  # length of prs
  max_consecutive = 0
  max_prime = -1
  for i in range(length):
    for j in range(max_consecutive, length-i+1):
      cnum = sum(prs[i:i+j])  # consecutive number
      if cnum >= NUM_MAX:
        # if sum is over target value, break j loop
        break
      if search(sum(prs[i:i+j]), prs, 1, length-1):
        max_consecutive = j
        max_prime = sum(prs[i:i+j])
  print max_prime


if __name__ == '__main__':
  main()
