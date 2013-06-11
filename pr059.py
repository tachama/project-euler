#!/usr/bin/env python
# -*- coding: utf-8 -*-

'''
Each character on a computer is assigned a unique code and the preferred
standard is ASCII (American Standard Code for Information Interchange).
For example, uppercase A = 65, asterisk (*) = 42, and lowercase k = 107.

A modern encryption method is to take a text file, convert the bytes to ASCII,
then XOR each byte with a given value, taken from a secret key. The advantage
with the XOR function is that using the same encryption key on the cipher text,
restores the plain text; for example, 65 XOR 42 = 107, then 107 XOR 42 = 65.

For unbreakable encryption, the key is the same length as the plain text
message, and the key is made up of random bytes. The user would keep the
encrypted message and the encryption key in different locations, and without
both "halves", it is impossible to decrypt the message.

Unfortunately, this method is impractical for most users, so the modified
method is to use a password as a key. If the password is shorter than the
message, which is likely, the key is repeated cyclically throughout the message.
The balance for this method is using a sufficiently long password key for
security, but short enough to be memorable.

Your task has been made easy, as the encryption key consists of three lower
case characters. Using cipher1.txt (right click and 'Save Link/Target As...'),
a file containing the encrypted ASCII codes, and the knowledge that the plain
text must contain common English words, decrypt the message and find the sum
of the ASCII values in the original text.
'''

import itertools  # for cycle, repeat
import string


# input encrypted ascii code file.
CIPHER_FILE = 'pr059_cipher1.txt'


# ascii frequency table (from haskell)
ASCII_FREQS = {'a':8.2, 'b':1.5, 'c':2.8, 'd':4.3, 'e':12.7, 'f':2.2, 'g':2.0,
               'h':6.1, 'i':7.0, 'j':0.2, 'k':0.8, 'l':4.0, 'm':2.4, 'n':6.7,
               'o':7.5, 'p':1.9, 'q':0.1, 'r':6.0, 's':6.3, 't':9.1, 'u':2.8,
               'v':1.0, 'w':2.4, 'x':0.2, 'y':2.0, 'z':0.1}


def encode(txt, key):
  '''encrypt/decode txt data with key'''
  pairs = zip(txt, itertools.cycle(key))
  xor = lambda p: p[0] ^ p[1]
  return [xor(p) for p in pairs]


def chi_sqr_test(e, o):
  '''chi-square test'''
  val = 0.0
  for x in e:
    val += ((e[x] - o[x]) ** 2) / e[x]
  return val


def ascii_freq(txts):
  '''return ascii frequency in txts'''
  # initial dictionary; {'a':0, 'b':0, .. , 'z':0}
  counts = dict(zip(list(string.lowercase), itertools.repeat(0)))
  total = 0
  for t in txts:
    counts[t] += 1
    total += 1
  # get ascii freqs in txts.
  freqs = dict(zip(list(string.lowercase), itertools.repeat(0.0)))
  for c in counts:
    freqs[c] = float(counts[c]) / float(total)
  return freqs


def text_score(txts):
  '''get text'''
  # filter only ascii test, and convert lower case
  ascii_txts = map(lambda c: c.lower(),
                   filter(lambda c: c.isalpha(), map(chr, txts)))
  # get ascii frequency
  freqs = ascii_freq(ascii_txts)
  return chi_sqr_test(ASCII_FREQS, freqs)  # chi-square test score


def main():
  '''main function'''

  # read encrypted ascii code from file.
  f = open(CIPHER_FILE)
  datas = f.readline().split()[0]  # remove end newline by split
  f.close()
  encrypts = [int(x) for x in datas.split(',')]

  # all combination of three lower case character key.
  ascii_codes = map(ord, string.lowercase)  # all lower case ascii-code
  keys = [[k1, k2, k3] for k1 in ascii_codes
                       for k2 in ascii_codes
                       for k3 in ascii_codes]

  # find key by text score.
  answer_key = min(keys,
                   key = lambda k: text_score(encode(encrypts, k)))
  ## for debug, dump key and original text.
  #print ''.join(map(chr, answer_key))
  #print ''.join(map(chr, encode(encrypts, answer_key)))

  # print sum of original text
  answer_sum = sum(encode(encrypts, answer_key))
  print answer_sum


if __name__ == '__main__':
  main()
