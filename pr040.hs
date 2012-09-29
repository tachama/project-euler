{-
An irrational decimal fraction is created by concatenating the positive
integers:

  0.12345678910 1 112131415161718192021...

It can be seen that the 12-th digit of the fractional part is 1.

If d(n) represents the n-th digit of the fractional part, find the value of
the following expression.

  d(1) * d(10) * d(100) * d(1000) * d(10000) * d(100000) * d(1000000)
-}

module Main where

import Data.Char (digitToInt)

-- target index list
targets :: [Int]
targets = map (10^) [0..6]

-- strint expression of irrational decimal fraction sequence
d :: [Char]
d = foldr (\a b -> show a ++ b) "" [1..]

-- get d(n)
dn :: Int -> Int
dn x = digitToInt $ d !! (x - 1)

main = print $ product $ map dn targets