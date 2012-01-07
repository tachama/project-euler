#!/usr/bin/env python2
# -*- coding: utf-8 -*-
#

'''
Problem 1

If we list all the natural numbers below 10 that are multiples of 3 or 5,
we get 3, 5, 6 and 9. The sum of these multiples is 23.

Find the sum of all the multiples of 3 or 5 below 1000.
'''

MAXNUM = 1000

def main():
    sum = 0
    for n in range(MAXNUM):
        if (n % 3 == 0) or (n % 5 == 0):
            sum += n
    print sum

if __name__ == '__main__':
    main()

