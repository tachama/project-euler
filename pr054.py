#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
In the card game poker, a hand consists of five cards and are ranked,
from lowest to highest, in the following way:

  High Card: Highest value card.
  One Pair: Two cards of the same value.
  Two Pairs: Two different pairs.
  Three of a Kind: Three cards of the same value.
  Straight: All cards are consecutive values.
  Flush: All cards of the same suit.
  Full House: Three of a kind and a pair.
  Four of a Kind: Four cards of the same value.
  Straight Flush: All cards are consecutive values of same suit.
  Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.
  The cards are valued in the order:
  2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace.

If two players have the same ranked hands then the rank made up of the highest
value wins; for example, a pair of eights beats a pair of fives (see example 1
below). But if two ranks tie, for example, both players have a pair of queens,
then highest cards in each hand are compared (see example 4 below); if the
highest cards tie then the next highest cards are compared, and so on.

Consider the following five hands dealt to two players:

  Hand     Player 1          Player 2            Winner
     1     5H 5C 6S 7S KD    2C 3S 8S 8D TD      Player 2
           Pair of Fives     Pair of Eights
     2     5D 8C 9S JS AC    2C 5C 7D 8S QH      Player 1
           Highest card Ace  Highest card Queen
     3     2D 9C AS AH AC    3D 6D 7D TD QD      Player 2
           Three Aces        Flush with Diamonds
     4     4D 6S 9H QH QC    3D 6D 7H QD QS      Player 1
           Pair of Queens    Pair of Queens
           Highest card Nine Highest card Seven
     5     2H 2D 4C 4D 4S    3C 3D 3S 9S 9D      Player 1
           Full House        Full House
           With Three Fours  with Three Threes

The file, poker.txt, contains one-thousand random hands dealt to two players.
Each line of the file contains ten cards (separated by a single space): the
first five are Player 1's cards and the last five are Player 2's cards. You can
assume that all hands are valid (no invalid characters or repeated cards), each
player's hand is in no specific order, and in each hand there is a clear winner.

How many hands does Player 1 win?
"""

import sys

INFILE_NAME = "pr054_poker.txt"  # problem input file name



class Card(object):
  '''Card class'''
  suits = {'S': 'SPADE', 'H': 'HART', 'D': 'DIAMOND', 'C': 'CLUB'}
  numbers = {'2':2, '3':3, '4':4, '5':5, '6':6, '7':7, '8':8, '9':9,
             'T':10, 'J':11, 'Q':12, 'K':13, 'A':14}
  def __init__(self, s):
    '''constructor of card'''
    self.number = self.numbers[s[0]]
    self.suit = self.suits[s[1]]
  def __cmp__(self, other):
    '''compare two card'''
    return self.number - other.number  # compare number only.


class Hand(object):
  '''poker hand class'''
  HIGH_CARD = 0
  ONE_PAIR = 1
  TWO_PAIR = 2
  THREE_OF_A_KIND = 3
  STRAIGHT = 4
  FLUSH = 5
  FULL_HOUSE = 6
  FOUR_OF_A_KIND = 7
  STRAIGHT_FLUSH = 8
  ROYAL_FLUSH = 9
  def __init__(self, cards):
    '''constructor. cards is sorted by number'''
    self.hand, self.ranks = self.calculate(cards)
  @staticmethod
  def calculate(cards):
    '''calculate hand from sorted cards'''
    if Hand.is_royalflush(cards):
      return Hand.ROYAL_FLUSH, Hand.ranks(cards)
    elif Hand.is_straightflush(cards):
      return Hand.STRAIGHT_FLUSH, Hand.ranks(cards)
    elif Hand.is_fourofakind(cards):
      return Hand.FOUR_OF_A_KIND, Hand.ranks(cards)
    elif Hand.is_fullhouse(cards):
      return Hand.FULL_HOUSE, Hand.ranks(cards)
    elif Hand.is_flush(cards):
      return Hand.FLUSH, Hand.ranks(cards)
    elif Hand.is_straight(cards):
      return Hand.STRAIGHT, Hand.ranks(cards)
    elif Hand.is_threeofakind(cards):
      return Hand.THREE_OF_A_KIND, Hand.ranks(cards)
    elif Hand.is_twopair(cards):
      return Hand.TWO_PAIR, Hand.ranks(cards)
    elif Hand.is_onepair(cards):
      return Hand.ONE_PAIR, Hand.ranks(cards)
    else:
      return Hand.HIGH_CARD, Hand.ranks(cards)
  @staticmethod
  def ranks(cards):
    gs = sorted(group(cards), cmp=lambda a,b:len(a)-len(b), reverse=True)
    return map(lambda l: l[0], gs)
  @staticmethod
  def is_royalflush(cs):
    return all([cs[0].number == 10, cs[1].number == 11,
                cs[2].number == 12, cs[3].number == 13,
                cs[4].number == 14]) and Hand.is_flush(cs)
  @staticmethod
  def is_straightflush(cs):
    return Hand.is_straight(cs) and Hand.is_flush(cs)
  @staticmethod
  def is_fourofakind(cs):
    gs = sorted(group(cs), cmp=lambda a,b:len(a)-len(b), reverse=True)
    return True if len(gs[0]) == 4 else False
  @staticmethod
  def is_fullhouse(cs):
    gs = sorted(group(cs), cmp=lambda a,b:len(a)-len(b), reverse=True)
    return True if len(gs) == 2 and len(gs[0]) == 3 else False
  @staticmethod
  def is_flush(cs):
    return all([cs[0].suit == cs[1].suit, cs[1].suit == cs[2].suit,
                cs[2].suit == cs[3].suit, cs[3].suit == cs[4].suit])
  @staticmethod
  def is_straight(cs):
    return all([cs[0].number == cs[1].number + 1,
                cs[1].number == cs[2].number + 1,
                cs[2].number == cs[3].number + 1,
                cs[3].number == cs[4].number + 1])
  @staticmethod
  def is_threeofakind(cs):
    gs = sorted(group(cs), cmp=lambda a,b:len(a)-len(b), reverse=True)
    return True if len(gs[0]) == 3 else False
  @staticmethod
  def is_twopair(cs):
    return Hand.npairs(cs) == 2
  @staticmethod
  def is_onepair(cs):
    return Hand.npairs(cs) == 1
  @staticmethod
  def npairs(cs):
    gs = sorted(group(cs), cmp=lambda a,b:len(a)-len(b), reverse=True)
    return len(filter(lambda l: len(l) == 2, gs))
  def __cmp__(self, other):
    if self.hand == other.hand:
      if self.ranks < other.ranks:
        return -1
      elif self.ranks > other.ranks:
        return 1
      else:
        return 0
    else:
      return self.hand - other.hand


class Player(object):
  '''Player class'''
  def __init__(self, no, cards):
    '''constructor'''
    self.name = "Player %d" % no
    tmp = sorted(cards)
    tmp.reverse()
    self.hand = Hand(tmp)


class Game(object):
  '''Game class'''
  def __init__(self, players):
    self.players = players
  def start(self):
    # return winner name
    return max(self.players, key=lambda p: p.hand).name


def group(lst):
  '''divide lst to group; like haskell group function'''
  if len(lst) == 0:
    return []
  idx = len(lst)
  for i in range(len(lst)):
    if lst[i] != lst[0]:
      idx = i
      break
  return [lst[:idx]] + group(lst[idx:])


def take5s(lst):
  '''divide list 5-element'''
  if lst:
    l = []
    l.append(lst[:5])
    return l + take5s(lst[5:])
  else:
    return []


def play_poker(s):
  '''play poker game'''
  cs = s.split()
  ncs = len(cs)
  if ncs % 5 != 0:
    print "invalid number of card: %s" % s
    sys.exit(1)
  cards = take5s(map(Card, cs))
  players = map(lambda pc: Player(pc[0],pc[1]), zip(range(1, ncs/5+1), cards))
  game = Game(players)
  winner = game.start()
  return winner


def main():
  '''main function'''
  f = open(INFILE_NAME, 'r')
  game_results = map(play_poker, f)
  f.close()
  n_win_p1 = len(filter(lambda n: n == "Player 1", game_results))
  print n_win_p1


if __name__ == '__main__':
  main()
