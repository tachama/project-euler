#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
The nth term of the sequence of triangle numbers is given by, t(n) = 1/2 * n(n+1);
so the first ten triangle numbers are:

  1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...

By converting each letter in a word to a number corresponding to its alphabetical
position and adding these values we form a word value. For example, the word
value for SKY is 19 + 11 + 25 = 55 = t10. If the word value is a triangle number
then we shall call the word a triangle word.

Using words.txt (right click and 'Save Link/Target As...'), a 16K text file
containing nearly two-thousand common English words, how many are triangle words?
"""

def get_words_from_file(fname):
  """get word list from text file"""
  f = open(fname, 'r')
  buf = f.readline()
  f.close
  words = map(lambda x: x[1:-1], buf.split(','))
  return words


def is_triangle_num(num):
  """check whether num is trianble number or not"""
  triangle = lambda n: (n * (n + 1)) / 2
  idx = 1
  val = triangle(idx)
  while val < num:
    idx += 1
    val = triangle(idx)
  return val == num


def is_triangle_word(word):
  """check whether word is triangle or not"""
  num = sum(map(lambda c: ord(c) - ord('A') + 1, word))
  return is_triangle_num(num)


def main():
  """main function"""
  words = get_words_from_file('pr042_words.txt')
  n_triangle = len(filter(is_triangle_word, words))
  print n_triangle


if __name__ == "__main__":
  main()
