{-
Problem 4
A palindromic number reads the same both ways. The largest palindrome made from
the product of two 2-digit numbers is 9009 = 91  99.

Find the largest palindrome made from the product of two 3-digit numbers.
-}

module Main where

import Char

-- subroutine of int2str
int2rts :: Int -> String
int2rts 0 = []
int2rts n = chr(n `mod` 10 + ord('0')):(int2rts (n `div` 10))

-- convert Int to String
int2str :: Int -> String
int2str n | n == 0 = "0"
          | otherwise = reverse (int2rts n)

-- check number is palindromic
palindromic :: Int -> Bool
palindromic n = if str == (reverse str)
                   then True
                   else False
                 where str = int2str n

main = print $ maximum [x * y | x <- [100..999], y <- [x..999], palindromic (x * y)]
