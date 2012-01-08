{-
Problem 6
The sum of the squares of the first ten natural numbers is,
  1**2 + 2**2 + ... + 10**2 = 385
The square of the sum of the first ten natural numbers is,
  (1 + 2 + ... + 10) ** 2 = 55 ** 22 = 3025

Hence the difference between the sum of the squares of the first ten natural
numbers and the square of the sum is 3025 - 385 = 2640.

Find the difference between the sum of the squares of the first one hundred
natural numbers and the square of the sum.
-}

module Main where

sqr :: Int -> Int
sqr n = n * n

main = print ((sqr $ sum [1..100]) - sum [sqr x | x <- [1..100]])
