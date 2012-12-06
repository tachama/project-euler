{-
The series, 1**1 + 2**2 + 3**3 + ... + 10**10 = 10405071317.

Find the last ten digits of the series, 1**1 + 2**2 + 3**3 + ... + 1000**1000.
-}

module Main where

numLast :: Int -> Integer -> Integer
numLast n x = read $ drop dropLen numStr
              where
                numStr = show x
                dropLen = length numStr - n

numLast10 = numLast 10

selfPowered :: Integral a => a -> a
selfPowered x = x ^ x

main = print $ numLast10 $ sum $ map selfPowered [1..1000]