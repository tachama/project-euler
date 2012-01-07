#!/usr/bin/env python2
# -*- coding: utf-8 -*-
#

'''
Problem 3
The prime factors of 13195 are 5, 7, 13 and 29.

What is the largest prime factor of the number 600851475143 ?
'''

NUM = 600851475143

def has_factor(num, lst):
    '''check where lst has factor of num'''
    for l in lst:
        if num % l == 0:
            return True
    return False

def prime():
    '''generator for prime number'''
    primes = []
    n = 1  # we start at '2' (not include '1')
    while True:
        n += 1
        if has_factor(n, primes):
            continue
        primes.append(n)
        yield n

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

def main():
    print max(prime_factor(NUM))

if __name__ == '__main__':
    main()
