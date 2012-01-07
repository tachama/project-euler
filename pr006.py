#!/usr/bin/env python2
# -*- coding: utf-8 -*-
#

'''
Problem 6
The sum of the squares of the first ten natural numbers is,
  1**2 + 2**2 + ... + 10**2 = 385
The square of the sum of the first ten natural numbers is,
  (1 + 2 + ... + 10) ** 2 = 55 ** 22 = 3025

Hence the difference between the sum of the squares of the first ten natural
numbers and the square of the sum is 3025 - 385 = 2640.

Find the difference between the sum of the squares of the first one hundred
natural numbers and the square of the sum.
'''

NUM = 100

def sum_of_sqr(num):
    '''sum of squrares of 1 to num'''
    sum = 0
    for i in range(1, num+1):
        sum += i ** 2
    return sum

def sqr_of_sum(num):
    '''squrare of sum of 1 to num'''
    sum = 0
    for i in range(1, num+1):
        sum += i
    return sum ** 2

def main():
    print sqr_of_sum(NUM) - sum_of_sqr(NUM)

if __name__ == '__main__':
    main()
