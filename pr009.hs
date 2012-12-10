{-
Problem 9
A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,

a ** 2 + b ** 2 = c ** 2
For example, 32 + 42 = 9 + 16 = 25 = 52.

There exists exactly one Pythagorean triplet for which a + b + c = 1000.
Find the product abc.
-}

module Main where

-- all of 'a + b + c = 1000'
inlst :: [(Int, Int, Int)]
inlst = [(a,b,1000-b-a) | a <- [1..1000], b <- [a..1000]]

-- pythagorean check
pythagorean :: (Int, Int, Int) -> Bool
pythagorean (a,b,c) = (a > 0) && (b > a) && (c > b) &&
                      (a + b + c == 1000) && (a * a + b * b == c * c)

-- multiple of 3 element tuple
mult_of_3tuple :: (Int, Int, Int) -> Int
mult_of_3tuple (a, b, c) = a * b * c

main :: IO ()
main = print $ head $ map mult_of_3tuple (filter pythagorean inlst)
