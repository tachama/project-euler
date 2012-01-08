{-
Problem 5
2520 is the smallest number that can be divided by each of the numbers
from 1 to 10 without any remainder.

What is the smallest positive number that is evenly divisible by all of
the numbers from 1 to 20?
-}

module Main where

rest :: Int -> [Int] -> Int
rest n [] = n
rest n (f:fs) = if n `mod` f == 0
                   then rest (n `div` f) fs
                   else rest n fs

rests :: Int -> Int
rests n = rest n [rests x | x <- [1..(n-1)]]

main = print (foldr (*) 1 [rests n | n <- [1..20]])
