#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
By starting at the top of the triangle below and moving to adjacent numbers
on the row below, the maximum total from top to bottom is 23.

3
7 4
2 4 6
8 5 9 3

That is, 3 + 7 + 4 + 9 = 23.

Find the maximum total from top to bottom of the triangle below:

75
95 64
17 47 82
18 35 87 10
20 04 82 47 65
19 01 23 75 03 34
88 02 77 73 07 63 67
99 65 04 28 06 16 70 92
41 41 26 56 83 40 80 70 33
41 48 72 33 47 32 37 16 94 29
53 71 44 65 25 43 91 52 97 51 14
70 11 33 28 77 73 17 78 39 68 17 57
91 71 52 38 17 14 91 43 58 50 27 29 48
63 66 04 68 89 53 67 30 73 16 69 87 40 31
04 62 98 27 23 09 70 98 73 93 38 53 60 04 23

NOTE: As there are only 16384 routes, it is possible to solve this problem
by trying every route. However, Problem 67, is the same challenge with a
triangle containing one-hundred rows; it cannot be solved by brute force,
and requires a clever method! ;o)
"""

input_str = """\
75
95 64
17 47 82
18 35 87 10
20 04 82 47 65
19 01 23 75 03 34
88 02 77 73 07 63 67
99 65 04 28 06 16 70 92
41 41 26 56 83 40 80 70 33
41 48 72 33 47 32 37 16 94 29
53 71 44 65 25 43 91 52 97 51 14
70 11 33 28 77 73 17 78 39 68 17 57
91 71 52 38 17 14 91 43 58 50 27 29 48
63 66 04 68 89 53 67 30 73 16 69 87 40 31
04 62 98 27 23 09 70 98 73 93 38 53 60 04 23"""

def instr2lst(instr):
  """convert input string to num list"""
  lst = [map(int,l.split(' ')) for l in instr.split('\n')]
  return lst


def routes_sub(lst):
  """
  subroutine of route.
    ex)
    [[0]] -> [[0,0],[0,1]]
    [[0,0], [0,1]] -> [[0, 0, 0], [0, 1, 1], [0, 0, 1], [0, 1, 2]]
  """
  return [l + [l[-1]] for l in lst] + [l + [l[-1]+1] for l in lst]


def routes(depth):
  """create route patterns of binary tree."""
  lst = [[0]]
  for i in range(depth-1):
    lst = routes_sub(lst)
  return lst


def route_value(tree, route):
  """value sum at route"""
  return sum([tree[depth][idx] for depth, idx
                                   in zip(range(len(route)), route)])


def main(instr):
  """main function"""
  lst = instr2lst(instr)  # convert input string to list of int lists.
  depth = len(lst)
  max_value =  max(map(lambda l: route_value(lst, l), routes(depth)))
  print max_value


if __name__ == "__main__":
  main(input_str)
