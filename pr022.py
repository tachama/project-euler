#!/usr/bin/env python2
# -*- coding: utf-8 -*-

"""
Using names.txt (right click and 'Save Link/Target As...'), a 46K text file
containing over five-thousand first names, begin by sorting it into alphabetical
order. Then working out the alphabetical value for each name, multiply this
value by its alphabetical position in the list to obtain a name score.

For example, when the list is sorted into alphabetical order, COLIN, which is
worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So, COLIN
would obtain a score of 938 * 53 = 49714.

What is the total of all the name scores in the file?
"""

INFILE = "pr022_names.txt"   # input problem file name.


def indata2lst(indata):
  """convert input data as string to list"""
  return map(lambda kw: kw[1:-1], indata.split(','))


def name2val(name):
  """calculate alphabetical value of name"""
  f = lambda c: ord(c) - ord('A') + 1
  return sum(map(f, name))


def solve(lst):
  """solve problem, lst is string list of problem"""
  lst.sort()
  lst2 = map(name2val, lst)   # calc alphabetical value for each name.
  lst3 = zip(lst2, range(1, len(lst) + 1))  # zip alphabetical and index.
  return sum(map(lambda tpl: tpl[0] * tpl[1], lst3))


def main(fname):
  """main function"""
  # open input file.
  try:
    f = open(fname, 'r')
    try:
      buf = f.readline()
    except IOError:
      print "Fail read data from %s" % fname
    finally:
      f.close()
  except IOError:
    print "Cannot open file %s" % fname
    return

  print solve(indata2lst(buf))


if __name__ == "__main__":
  main(INFILE)
