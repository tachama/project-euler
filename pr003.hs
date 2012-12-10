{-
Problem 3
The prime factors of 13195 are 5, 7, 13 and 29.

What is the largest prime factor of the number 600851475143 ?
-}

module Main where

has_factor :: Int -> [Int] -> Bool
has_factor _ [] = False
has_factor n (f:fs) | n `mod` f == 0 = True
                    | otherwise = has_factor n fs

next_prime :: Int -> Int
next_prime n = if has_factor (n + 1) [2..n]
                   then next_prime (n + 1)
                   else (n + 1)

pf :: Int -> [Int] -> Int -> [Int]
pf 1 fs _ = fs
pf n fs n2 | n `mod` n2 == 0 = pf (n `div` n2) (n2:fs) n2
           | otherwise = pf n fs (next_prime n2)

prime_factors :: Int -> [Int]
prime_factors n = pf n [] (next_prime 1)

main :: IO ()
main = print $ maximum $ prime_factors 600851475143

