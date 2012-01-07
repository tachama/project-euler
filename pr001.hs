{-
Problem 1

If we list all the natural numbers below 10 that are multiples of 3 or 5,
we get 3, 5, 6 and 9. The sum of these multiples is 23.

Find the sum of all the multiples of 3 or 5 below 1000.
-}

module Main where

-- check multiples of 3 or 5
mults_3_5 :: Int -> Bool
mults_3_5 n | n `mod` 3 == 0 = True
            | n `mod` 5 == 0 = True
            | otherwise = False

main = print (sum ( filter mults_3_5 [1..999] ))
