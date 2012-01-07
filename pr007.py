#!/usr/bin/env python2
# -*- coding: utf-8 -*-
#

'''
Problem 7
By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13,
we can see that the 6th prime is 13.

What is the 10,001st prime number?
'''

NUM = 10001

def has_factor(num, lst):
    for l in lst:
        if num % l == 0:
            return True
    return False

def primes(num):
    '''return list of primes has num elements'''
    prs = []
    n = 0
    val = 1  # we start at '2' (not include '1')
    while n < num:
        val += 1
        if has_factor(val, prs):
            continue
        prs.append(val)
        n += 1
    return prs

def main():
    print primes(NUM)[-1]

if __name__ == '__main__':
    main()
