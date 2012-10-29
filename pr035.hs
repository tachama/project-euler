{-
The number, 197, is called a circular prime because all rotations of the
digits: 197, 971, and 719, are themselves prime.

There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37, 71,
73, 79, and 97.

How many circular primes are there below one million?
-}

module Main where

import Data.Array
import Data.Maybe (isJust)
import Prime   -- original prime module.

-- create circular numbers from n
circularNums :: Int -> [Int]
circularNums n = map (rotate n) [0..(digits n)]

-- rotate number
rotate :: Int -> Int -> Int
rotate n x = read $ (drop x s) ++ (take x s)
             where s = show n

-- num of digits of number n
digits :: Int -> Int
digits n | n < 10 = 1
         | otherwise = digits (n `div` 10) + 1


-- check whether number is circular number or not.
--   1st arg is function for check num is prime
isCircular :: (Int -> Maybe Int) -> Int -> Bool
isCircular chkFunc n = all (isJust . chkFunc) $ circularNums n

-- binary search
binSearch :: Array Int Int -> (Int, Int) -> Int -> Maybe Int
binSearch arr (a, b) v | a > b = Nothing
                       | (arr ! m) > v = binSearch arr (a, m-1) v
                       | (arr ! m) < v = binSearch arr (m+1, b) v
                       | otherwise = Just v  -- (arr ! m) == v
                       where m = (a + b) `div` 2


-- main function
main = print $ length $ filter (isCircular func) primes
       where
         primesArr = primesArrUnder 1000000  -- pair as "(length, array primes)"
         primes = elems $ snd primesArr  -- prime list
         func = binSearch (snd primesArr) (0, fst primesArr - 1)
