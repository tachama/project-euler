{-
Problem 1

If we list all the natural numbers below 10 that are multiples of 3 or 5,
we get 3, 5, 6 and 9. The sum of these multiples is 23.

Find the sum of all the multiples of 3 or 5 below 1000.
-}

module Main where

mults_3_5 :: Int -> [Int]
mults_3_5 n = [x | x <- [1..(n-1)], (x `mod` 3 == 0) || (x `mod` 5 == 0)]

main = print $ sum $ mults_3_5 1000

