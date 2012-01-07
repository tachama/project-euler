#!/usr/bin/env python2
# -*- coding: utf-8 -*-
#

'''
Problem 5
2520 is the smallest number that can be divided by each of the numbers
from 1 to 10 without any remainder.

What is the smallest positive number that is evenly divisible by all of
the numbers from 1 to 20?
'''

NUM = 20

def mult(lst):
    '''list multi'''
    m = 1
    for l in lst:
        m *= l
    return m

def rests(num):
    rs = []
    for i in range(1, num + 1):
        val = i
        for r in rs:
            if val % r == 0:
                val /= r
        rs.append(val)
    return rs

def main():
    print mult(rests(NUM))

if __name__ == '__main__':
    main()
