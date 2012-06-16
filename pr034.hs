{-
145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.

Find the sum of all numbers which are equal to the sum of the
factorial of their digits.

Note: as 1! = 1 and 2! = 2 are not sums they are not included.
-}

module Main where

import Data.Char

maxDigits :: Int
maxDigits = head $ dropWhile (\n -> frac 9 * n > power 10 n) [1..]

frac :: Int -> Int
frac 0 = 1
frac n = n * frac (n - 1)

power :: Int -> Int -> Int
power _ 0 = 1
power n m = n * power n (m-1)

digits :: Int -> [Int]
digits = map digitToInt . show

isCurious :: Int -> Bool
isCurious n = n == (sum $ map frac $ digits n)

curiousNumbers :: [Int]
curiousNumbers = filter isCurious [3..(power 10 maxDigits)]

main = print $ sum curiousNumbers