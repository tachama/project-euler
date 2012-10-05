{-
We shall say that an n-digit number is pandigital if it makes use ofall the
digits 1 to n exactly once. For example, 2143 is a 4-digit pandigital and is
also prime.

What is the largest n-digit pandigital prime that exists?
-}

module Main where

import Data.Char (digitToInt)

-- check whether digit is prime.
isPrime :: Int -> Bool
isPrime n = all (\x -> n `mod` x /= 0) [2..(n-1)]

-- delete number from digit list.
delFromList :: Ord a => a -> [a] -> [a]
delFromList x ns = filter (/=x) ns

-- cat two digit; eg) catDigit 123 456 = 123456
catDigit :: Int -> Int -> Int
catDigit n1 n2 = foldl1 (\x y -> x * 10 + y) $ digits n1 ++ digits n2
                 where
                   digits = map digitToInt . show

-- subroutine of n-digit number.
digitNSub :: [Int] -> [Int]
digitNSub ns = if length ns == 1
               then ns
               else concatMap func ns
                 where func = \n -> map (catDigit n) (digitNSub $ delFromList n ns)

-- n-digit number.
digitN :: Int -> [Int]
digitN n = digitNSub $ reverse [1..n]

-- max number of n-digit pandigital prime
maxPrimeAtNdigit :: Int
maxPrimeAtNdigit = head $ filter isPrime $ concatMap digitN [7,6..1]

main = print maxPrimeAtNdigit
