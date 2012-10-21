{-
It was proposed by Christian Goldbach that every odd composite number can
be written as the sum of a prime and twice a square.

9 = 7 + 2 * 1 ^ 2
15 = 7 + 2 * 2 ^ 2
21 = 3 + 2 * 3 ^ 2
25 = 7 + 2 * 3 ^ 2
27 = 19 + 2 * 2 ^ 2
33 = 31 + 2 * 1 ^ 2

It turns out that the conjecture was false.

What is the smallest odd composite that cannot be written as the sum of a prime
and twice a square?
-}

module Main where

-- prime numbers
primes :: [Int]
primes = [n | n <- [2..], all (\x -> n `mod` x /= 0) [2..(n-1)]]

-- composite numbers
composites :: [Int]
composites = [n | n <- [2..], any (\x -> n `mod` x == 0) [2..(n-1)]]

-- twice of squere numbers
twiceSqr :: [Int]
twiceSqr = [2*n^2 | n <- [1..]]

-- number can be written as a sum of a prime and twice a squere ?
hasProperty :: Int -> Bool
hasProperty n = any sub $ takeWhile (<n) primes
                where
                  sub x = any (\y -> x + y == n) $ takeWhile (<=(n-x)) twiceSqr

main = print $ head $ filter (not . hasProperty) $ filter odd composites