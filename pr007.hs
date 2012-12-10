{-
Problem 7
By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13,
we can see that the 6th prime is 13.

What is the 10,001st prime number?
-}

module Main where

has_factor :: Int -> [Int] -> Bool
has_factor x ns = or $ map (\n -> x `mod` n == 0) ns

prime :: [Int]
prime = [x | x <- [2..], not (has_factor x [2..(x-1)])]

main :: IO ()
main = print (head (drop 10000 prime))