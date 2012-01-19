#!/usr/bin/env python2
# -*- coding: utf-8 -*-
#

'''
Problem 4
A palindromic number reads the same both ways. The largest palindrome made from
the product of two 2-digit numbers is 9009 = 91  99.

Find the largest palindrome made from the product of two 3-digit numbers.

問題
回文数(palindromic numbers)とは両方から読んで同じとなる。
2桁の数の積で生成されるもっとも大きな回文数は、9009 (= 91 * 99) である
3桁の数の積で生成されるもっとも大きな回文数を探せ
'''

def is_palindromic(s):
  '''check whether given str is palindromic'''
  tmp = list(s)
  tmp.reverse()
  revs = "".join(tmp)
  if s == revs:
    return True
  else:
    return False

def main():
  '''main function'''
  palindromics = [n for n in [i * j for i in range(100, 1000)
                                    for j in range(i, 1000)]
                             if is_palindromic(str(n))]
  print max(palindromics)

if __name__ == '__main__':
  main()
