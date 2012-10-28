{-
Problem 10
The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.

Find the sum of all the primes below two million.
-}

module Main where

import Prime   -- use original prime module function.

input_number :: Int
input_number = 2000000  -- two million

-- main function
main = print $ sum $ primesUnder input_number
