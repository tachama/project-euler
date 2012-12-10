{-
n! means n *(n  1) * ... * 3 * 2 * 1

For example, 10! = 10 * 9 * ... * 3 * 2 * 1 = 3628800,
and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.

Find the sum of the digits in the number 100!
-}

module Main where

import Data.List (unfoldr)

input_num :: Integer
input_num = 100  -- problem input number.

-- factorial of number
factorial :: Integer -> Integer
factorial 1 = 1
factorial n = n * factorial (n-1)

-- sum of digits
digit_sum :: Integer -> Integer
digit_sum n = sum $ unfoldr divide n

-- subroutine for digit_sum. using by unfoldr.
divide :: Integer -> Maybe (Integer, Integer)
divide 0 = Nothing
divide n = Just (n `mod` 10, n `div` 10)

-- solve problem
solve :: Integer -> Integer
solve n = digit_sum $ factorial n

main :: IO ()
main = print $ solve input_num