{-
The number 3797 has an interesting property. Being prime itself, it is possible
to continuously remove digits from left to right, and remain prime at each
stage: 3797, 797, 97, and 7. Similarly we can work from right to left: 3797,
379, 37, and 3.

Find the sum of the only eleven primes that are both truncatable from left to
right and right to left.

NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.
-}

module Main where

import Data.List (elem)

-- prime numbers
primes :: [Int]
primes = [x | x <- [2..], all (\n -> x `mod` n /= 0) [2..(x-1)]]

-- check number is prime or not
isPrime :: Int -> Bool
isPrime x = elem x $ takeWhile (<=x) primes

-- check number has interesting property
isInteresting :: Int -> Bool
isInteresting x = if x < 10
                  then isPrime x
                  else
                      and [isPrime x, isInteresting (rtrunc x), isInteresting (ltrunc x)]
                      where
                        rtrunc x = x `div` 10
                        ltrunc x = x `mod` (10 ^ (length (show x) - 1))


-- list of numbers that has interesting property.
interesting :: [Int]
interesting = filter isInteresting $ dropWhile (<10) primes

-- main function
main = print $ sum $ take 11 interesting
