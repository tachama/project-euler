{-
Starting with the number 1 and moving to the right in a clockwise direction
a 5 by 5 spiral is formed as follows:

  21 22 23 24 25
  20  7  8  9 10
  19  6  1  2 11
  18  5  4  3 12
  17 16 15 14 13

It can be verified that the sum of the numbers on the diagonals is 101.

What is the sum of the numbers on the diagonals in a 1001 by 1001 spiral formed
in the same way?
-}

module Main where

-- problem input.
size :: Int
size = 1001

-- start number of rectangle n
startNumber :: Int -> Int
startNumber 1 = 2
startNumber n = startNumber (n-1) + 8 * (n-1)

-- sum of diagonals in N by N spirals.
sumOfDiagnals :: Int -> Int
sumOfDiagnals 0 = 1
sumOfDiagnals n = 4 * startNumber n + 20 * n - 4 + sumOfDiagnals (n-1)

main = print $ sumOfDiagnals $ size `div` 2

-- XXX: I want to define infinite list using fold[r], not recursive define...