#!/usr/bin/env python
# -*- coding: utf-8 -*-

'''
If the numbers 1 to 5 are written out in words: one, two, three, four, five,
then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.

If all the numbers from 1 to 1000 (one thousand) inclusive were written out
in words, how many letters would be used?


NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and
forty-two) contains 23 letters and 115 (one hundred and fifteen) contains
20 letters. The use of "and" when writing out numbers is in compliance with
British usage.
'''

input_num = 1000

# letters for 1 to 19
DIGITS_LETTER = [ "one", "two", "three", "four", "five", "six", "seven",
                  "eight", "nine", "ten", "eleven", "twelve", "thirteen",
                  "fourteen", "fifteen", "sixteen", "seventeen", "eighteen",
                  "nineteen" ]

# letters for 20, 30, 40, ...
DIGITS10_LETTER = [ "twenty", "thirty", "forty", "fifty", "sixty",
                    "seventy", "eighty", "ninety" ]


def letter_sub(num):
  """letters for 1 to 99"""
  lett = ""
  n = num
  if n >= 20:
    div, n = divmod(n, 10)
    lett += DIGITS10_LETTER[div - 2]
    if n == 0:
      return lett
    #lett += "-"    # '-' is not counted.
  lett += DIGITS_LETTER[n - 1]
  return lett


def letter(num):
  """return letters of num"""
  if num > 1000:
    # XXX: this function work under 1000
    import sys
    sys.stderr.write("num is too large...\n")
    sys.exit(1)

  lett = ""
  n = num

  # check 1000 and 100 letters.
  for base, blett in [(1000, "thousand"), (100, "hundred")]:
    div, n = divmod(n, base)
    if div > 0:
      lett += letter_sub(div)
      lett += blett
      if n == 0:
        return lett
      lett += "and"

  lett += letter_sub(n)
  return lett


def main(num):
  """main function"""
  print sum(map(len, map(letter, range(1,num+1))))


if __name__ == "__main__":
  main(input_num)
