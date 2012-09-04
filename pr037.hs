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

import Data.List (sort, elem)
import Data.Maybe (catMaybes)

-- prime numbers
primes :: [Int]
primes = [x | x <- [2..], isPrime x]

-- check number is prime or not
isPrime :: Int -> Bool
isPrime x = all (\n -> x `mod` n /= 0) [2..(x-1)]


-- digits of number
ndigits :: Int -> Int
ndigits = length . show


-- generate list for solve this problem
genPrime :: (Int -> [Int]) -> [Int] -> [Int]
genPrime f ns = filter isPrime $ concatMap f ns

genLPrime = genPrime (\x -> [x * 10 + n | n <- [1..9]])
genRPrime = genPrime (\x -> [x + n * (10 ^ ndigits x) | n <- [1..9]])


mergeLR :: Int -> Int -> Maybe Int
mergeLR l r = if coml /= comr
                then Nothing
                else Just (l * 10 + r `mod` 10)
              where
                coml = l `mod` (10 ^ (ndigits l - 1))
                comr = r `div` 10


-- generate interesting prime numbers.
genInteresting :: [Int] -> [Int] -> [Int]
genInteresting lpr rpr = gens ++ genInteresting nextLpr nextRpr
                         where
                           lst = [mergeLR l r | l <- lpr, r <- rpr]
                           gens = sort $ filter isPrime $ catMaybes lst
                           nextLpr = genLPrime lpr
                           nextRpr = genRPrime rpr

-- main function.
main = print $ sum $ take 11 interestings
       where
         oneDigitPrimes = takeWhile (<10) primes
         interestings = genInteresting oneDigitPrimes oneDigitPrimes
