{-
Problem 10
The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.

Find the sum of all the primes below two million.
-}

module Main where

input_number :: Int
input_number = 2000000

-- XXX: maybe waste stack
eratoshenes :: [Int] -> [Int]
eratoshenes [] = []
eratoshenes (n:ns) = n: eratoshenes (filter (\x -> x `mod` n /= 0) ns)

-- primes below n
primes :: Int -> [Int]
primes n = eratoshenes [2..(n-1)]

main = print $ sum $ primes input_number
