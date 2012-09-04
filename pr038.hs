{-
Take the number 192 and multiply it by each of 1, 2, and 3:

  192 * 1 = 192
  192 * 2 = 384
  192 * 3 = 576

By concatenating each product we get the 1 to 9 pandigital, 192384576. We will
call 192384576 the concatenated product of 192 and (1,2,3)

The same can be achieved by starting with 9 and multiplying by 1, 2, 3, 4, and
5, giving the pandigital, 918273645, which is the concatenated product of 9 and
(1,2,3,4,5).

What is the largest 1 to 9 pandigital 9-digit number that can be formed as the
concatenated product of an integer with (1,2, ... , n) where n > 1?
-}

module Main where

import Data.List (sort)
import Data.Maybe (mapMaybe)

-- create pandigital number from x
generate :: Int -> Int -> Maybe Int
generate x n | genlen == 9 = if isp then Just gennum else Nothing
             | genlen < 9  = generate x (n+1)
             | otherwise   = Nothing
             where
               tmp = foldr1 (++) $ map (show . (*x)) [1..n]
               genlen = length tmp
               gennum = read tmp
               isp = sort tmp == "123456789"

-- return maximun pandigital number.
maxPandigital :: Int
maxPandigital = maximum $ mapMaybe createPandigital [1..9999]
                where
                  createPandigital = flip generate 2

-- main function.
main = print maxPandigital