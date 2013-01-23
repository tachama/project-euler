{-
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
-}

module Main where

import Data.List (group, sort, sortBy)
import Data.Maybe
import qualified Data.Map as M


------------------------------------------------------------
-- data definitions

data Player = Player Int deriving (Eq, Ord, Show)
data Card = Spade Int | Hart Int | Diamond Int | Club Int deriving (Eq, Ord, Show)

data Hand = HighCard [Int] | OnePair [Int] | TwoPairs [Int] | ThreeOfAKind [Int] | Straight [Int] | Flush [Int] | FullHouse [Int] | FourOfAKind [Int] | StraightFlush [Int] | RoyalFlush [Int]  deriving (Eq, Ord, Show)


------------------------------------------------------------
-- utilities for common

-- problem input file name
problemFileName :: String
problemFileName = "pr054_poker.txt"

-- split string
split :: Char -> String -> [String]
split _ [] = []
split c ss = s1 : split c (dropWhile (==c) s2)
             where
               (s1, s2) = break (==c) ss

-- check sorted list is consecutive
consecutive :: (Integral a) => [a] -> Bool
consecutive ns = all (\t -> (fst t + 1) == snd t) $ zip ns (tail ns)


------------------------------------------------------------
-- utilities for porker

-- convert string to card
--   eg) 2H -> Hart 1  -- value is visual value minus one.
str2Card :: String -> Card
str2Card ns = cardSuit (last ns) $ cardNum (init ns)

cardSuit :: Char -> Int -> Card
cardSuit c = fromJust $ M.lookup c suitMap
             where
               suitMap = M.fromList [('S', Spade), ('H', Hart), ('D', Diamond), ('C', Club)]

cardNum :: String -> Int
cardNum s = fromJust $ M.lookup s numMap
            where
              numMap = M.fromList [("2",1),("3",2),("4",3),("5",4),("6",5),("7",6),("8",7),("9",8),("T",9),("J",10),("Q",11),("K",12),("A",13)]

rankCard :: Card -> Int
rankCard (Spade v)   = v
rankCard (Hart v)    = v
rankCard (Diamond v) = v
rankCard (Club v)    = v

suitCard :: Card -> Int -> Card
suitCard (Spade _)   = Spade
suitCard (Hart _)    = Hart
suitCard (Diamond _) = Diamond
suitCard (Club _)    = Club


------------------------------------------------------------
-- main logic

runGame :: [([Card], Player)] -> Player
runGame gs = player $ maximum $ map (\(c,p) -> (score c, p)) gs
             where
               player = snd  -- pickup player

score :: [Card] -> Hand
score cs | isRoyalFlush cs    = RoyalFlush ranks
         | isStraightFlush cs = StraightFlush ranks
         | isFourOfAKind cs   = FourOfAKind ranks
         | isFullHouse cs     = FullHouse ranks
         | isFlush cs         = Flush ranks
         | isStraight cs      = Straight ranks
         | isThreeOfAKind cs  = ThreeOfAKind ranks
         | isTwoPairs cs      = TwoPairs ranks
         | isOnePair cs       = OnePair ranks
         | otherwise          = HighCard ranks
         where
           -- ranks must be sorted by hand parts.
           ranks = concat $ rankGroup cs



isRoyalFlush :: [Card] -> Bool
isRoyalFlush cs = isStraightFlush cs && ranks == [9,10,11,12,13]
                  where
                    ranks = sort $ map rankCard cs

isStraightFlush :: [Card] -> Bool
isStraightFlush cs = isFlush cs && isStraight cs

isFourOfAKind :: [Card] -> Bool
isFourOfAKind cs = nOfAKind cs == 4

isFullHouse :: [Card] -> Bool
isFullHouse cs = length ranks == 2 &&  length (head ranks) == 3
                 where
                   ranks = rankGroup cs

isFlush :: [Card] -> Bool
isFlush cs = all (uncurry (==)) $ zip suits (tail suits)
             where
               suits = map (\c -> suitCard c dummy) cs  -- choice Suit only
               dummy = 0

isStraight :: [Card] -> Bool
isStraight cs = consecutive $ sort $ map rankCard cs

isThreeOfAKind :: [Card] -> Bool
isThreeOfAKind cs = nOfAKind cs == 3

isTwoPairs :: [Card] -> Bool
isTwoPairs cs = nPair cs == 2

isOnePair :: [Card] -> Bool
isOnePair cs = nPair cs == 1

nOfAKind :: [Card] -> Int
nOfAKind = length . head . rankGroup

-- number of pairs at cards
nPair :: [Card] -> Int
nPair cs = length $ takeWhile (\g -> length g == 2) $ rankGroup cs

-- convert Cards to group list. list sorted by number of members
rankGroup :: [Card] -> [[Int]]
rankGroup cs = sortBy compLength $ group ranks
               where
                 ranks = reverse $ sort $ map rankCard cs
                 compLength a b = compare (length b) (length a)

-- create game from card
cards2game :: [Player] -> [Card] -> [([Card], Player)]
cards2game _ [] = []
cards2game (p:ps) cs = if length cs < 5
                       then error "Invalid cards length"  -- for invalid imput.
                       else (take 5 cs, p) : cards2game ps (drop 5 cs)

-- infinity list of player.
players :: [Player]
players = [Player n | n <- [1..]]


------------------------------------------------------------
-- main function

main :: IO ()
main = do
  cardStrs <- fmap (split '\n') $ readFile problemFileName
  cards <- return $ fmap (map str2Card) $ map (split ' ') cardStrs
  games <- return $ map (cards2game players) cards
  print $ length $ filter (==Player 1) $ map runGame games


------------------------------------------------------------
-- for testing: test "5H 5C 6S 7S KD  2C 3S 8S 8D TD"
test :: String -> Player
test ss = runGame $ cards2game players $ map str2Card $ split ' ' ss

{-
  sample inputs (and winner) from problem description.
    "5H 5C 6S 7S KD  2C 3S 8S 8D TD"  -> Player 2
    "5D 8C 9S JS AC  2C 5C 7D 8S QH"  -> Player 1
    "2D 9C AS AH AC  3D 6D 7D TD QD"  -> Player 2
    "4D 6S 9H QH QC  3D 6D 7H QD QS"  -> Player 1
    "2H 2D 4C 4D 4S  3C 3D 3S 9S 9D"  -> Player 1
-}