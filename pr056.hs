{-
A googol (10**100) is a massive number: one followed by one-hundred zeros;
100**100 is almost unimaginably large: one followed by two-hundred zeros.
Despite their size, the sum of the digits in each number is only 1.

Considering natural numbers of the form, a**b, where a, b < 100, what is
the maximum digital sum?
-}

module Main where

import Control.Applicative
import Data.Char

digitSum :: Integer -> Int
digitSum n = sum $ map digitToInt $ show n

power :: (Integral a) => a -> a -> a
power a 0 = a
power a b = a * power a (b-1)

main :: IO ()
main = print $ maximum $ map (digitSum . (uncurry power)) nums
       where
         nums = (,) <$> [1..99] <*> [1..99]