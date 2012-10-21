{-
A perfect number is a number for which the sum of its proper divisors is
exactly equal to the number. For example, the sum of the proper divisors
of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.

A number n is called deficient if the sum of its proper divisors is less than
n and it is called abundant if this sum exceeds n.

As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest
number that can be written as the sum of two abundant numbers is 24.
By mathematical analysis, it can be shown that all integers greater than 28123
can be written as the sum of two abundant numbers. However, this upper limit
cannot be reduced any further by analysis even though it is known that the
greatest number that cannot be expressed as the sum of two abundant numbers is
less than this limit.

Find the sum of all the positive integers which cannot be written as the sum of
two abundant numbers.
-}

module Main where

import Data.List (sort)

-- divisors of N except of N.
divisors :: Int -> [Int]
divisors n = [x | x <- [1..(n`div`2)], n `mod` x == 0]

-- abundant number list
abundantNums :: [Int]
abundantNums = [n | n <- [1..], n < sum (divisors n)]

-- limit number of this problem.
limitNum :: Int
limitNum = 28123

-- unique elements list of sorted list
uniq :: (Eq a) => [a] -> [a]
uniq (n:[]) = [n]
uniq (n1:n2:ns) | n1 == n2 = uniq (n1:ns)
                | otherwise = n1 : uniq (n2:ns)

-- non-abundant number list equal or under n
nonAbundant :: Int -> [Int]
nonAbundant n = uniq $ sort $ concatMap sub abundantN
                where
                  abundantN = takeWhile (<=n) abundantNums
                  sub x = map (+x) $ dropWhile (<x) abundantN

-- sub of two list
listSub :: (Ord a) => [a] -> [a] -> [a]
listSub ns [] = ns
listSub [] _ = []
listSub (x:xs) (y:ys) | x == y = listSub xs ys
                      | x > y = listSub (x:xs) ys
                      | x < y = x : listSub xs (y:ys)

main = print $ sum $ listSub [1..limitNum] $ nonAbundant limitNum
