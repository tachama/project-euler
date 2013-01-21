{-# LANGUAGE BangPatterns #-}
{-
The prime 41, can be written as the sum of six consecutive primes:

  41 = 2 + 3 + 5 + 7 + 11 + 13

This is the longest sum of consecutive primes that adds to a prime below
one-hundred.

The longest sum of consecutive primes below one-thousand that adds to a prime,
contains 21 terms, and is equal to 953.

Which prime, below one-million, can be written as the sum of the most
consecutive primes?
-}

module Main where

import Data.Maybe
import Prime (primesUnder)

-- target maximum number; one million
targetMax :: Int
targetMax = 1000000


-- main function.
--  for pruning search path, hold length of consecutive and use this.
main :: IO ()
main = print $ snd $ foldr func (0,0) primes
       where
         !primes = primesUnder targetMax
         func n (l,m) = if isJust ans
                        then if fromJust ans > l then (fromJust ans, n) else (l,m)
                        else (l,m)
                        where
                          ans = findConsecutive primes n l


-- find consecutive sequence.
--   ns : primes numbers
--   x  : target prime
--   m  : minimal length of consecutive.
findConsecutive :: [Int] -> Int -> Int -> Maybe Int
findConsecutive [] _ _ = Nothing
findConsecutive ns x m = if sum (take m ns) > x
                         then Nothing
                         else if isJust ans
                              then ans
                              else findConsecutive (tail ns) x m
                             where
                               ans = findCSub (drop m ns) x (sum (take m ns)) m

-- subroutine of findConsecutive
findCSub :: [Int] -> Int -> Int -> Int -> Maybe Int
findCSub [] _ _ _ = Nothing
findCSub (n:ns) x s len | x == s    = Just len
                        | x < s     = Nothing
                        | otherwise = findCSub ns x (s+n) (len+1)

