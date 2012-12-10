{-
Problem 15
Starting in the top left corner of a 2 x 2 grid,
there are 6 routes (without backtracking) to the bottom right corner.

How many routes are there through a 20 x 20 grid?
-}

module Main where

input_width :: Integer
input_width = 20

input_height :: Integer
input_height = 20

combination :: Integer -> Integer -> Integer
combination m n = (product [(m-n+1)..m]) `div` (product [1..n])

main :: IO ()
main = print $ combination (input_width + input_height) input_width
