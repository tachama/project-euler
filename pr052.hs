{-
It can be seen that the number, 125874, and its double, 251748, contain exactly
the same digits, but in a different order.

Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and 6x, contain
the same digits.
-}

module Main where

import Data.List

nTarget :: Int
nTarget = 6

-- digit-sorted strings of n
digs :: Int -> String
digs x = (sort . show) x

-- N has same digit at N*1, N*2, N*3 .. N*X ?
hasSameDigs :: Int -> Int -> Bool
hasSameDigs x n = and $ map (\m -> (digs n) == (digs m)) [i * n | i <- [2..x]]

-- main function.
main :: IO ()
main = print $ head $ filter (hasSameDigs nTarget) [1..]