{-
Surprisingly there are only three numbers that can be written as the sum of
fourth powers of their digits:

  1634 = 1**4 + 6**4 + 3**4 + 4**4
  8208 = 8**4 + 2**4 + 0**4 + 8**4
  9474 = 9**4 + 4**4 + 7**4 + 4**4

As 1 = 1**4 is not a sum it is not included.

The sum of these numbers is 1634 + 8208 + 9474 = 19316.

Find the sum of all the numbers that can be written as the sum of fifth powers
of their digits.
-}

module Main where

import Data.Char

-- power of this problem.
power :: Int
power = 5

-- calculate max search number from power.
maxNumber :: Int -> Int
maxNumber n = (10^) $ head $ dropWhile (\x -> (9 ^ n) * x > 10 ^ x) [1..]

-- x is equal with sum of power x of each digits
isNthPower :: Int -> Int -> Bool
isNthPower n x = x == nthPowerSum n x

-- powers sum of number list.
nthPowerSum :: Int -> Int -> Int
nthPowerSum n = sum . map (^n) . toDigit

-- split digits from number
toDigit :: Int -> [Int]
toDigit = map digitToInt . show

main = print $ sum $ filter (isNthPower power) [2..(maxNumber power)]