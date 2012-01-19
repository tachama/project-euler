#!/usr/bin/env python2
# -*- coding: utf-8 -*-
#

'''
Problem 3
The prime factors of 13195 are 5, 7, 13 and 29.

What is the largest prime factor of the number 600851475143 ?
'''

INPUT_NUM = 600851475143

def has_factor(num, lst):
  '''check where lst has factor of num'''
  for i in lst:
    if num % i == 0:
      return True
  return False

def prime():
  '''generator for prime number'''
  primes = []
  num = 1  # we start at '2' (not include '1')
  while True:
    num += 1
    if has_factor(num, primes):
      continue
    primes.append(num)
    yield num

def prime_factor(num):
  '''return list of prime factors'''
  factors = []
  while num > 1:
    for p in prime():
      if num % p == 0:
        factors.append(p)
        num = num / p
        break
  return factors

def main(num):
  '''main function'''
  print max(prime_factor(num))

if __name__ == '__main__':
  main(INPUT_NUM)
