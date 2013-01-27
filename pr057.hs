{-
It is possible to show that the square root of two can be expressed as an
infinite continued fraction.

  root 2 = 1 + 1/(2 + 1/(2 + 1/(2 + ... ))) = 1.414213...

By expanding this for the first four iterations, we get:

  1 + 1/2 = 3/2 = 1.5
  1 + 1/(2 + 1/2) = 7/5 = 1.4
  1 + 1/(2 + 1/(2 + 1/2)) = 17/12 = 1.41666...
  1 + 1/(2 + 1/(2 + 1/(2 + 1/2))) = 41/29 = 1.41379...

The next three expansions are 99/70, 239/169, and 577/408, but the eighth
expansion, 1393/985, is the first example where the number of digits in the
numerator exceeds the number of digits in the denominator.

In the first one-thousand expansions, how many fractions contain a numerator
with more digits than denominator?
-}

module Main where

import Data.Ratio

{- -- it was simple version. but too slow for this problem
routeTwoSub :: Int -> Ratio Integer
routeTwoSub 0 = 2 % 1
routeTwoSub m = 2 + (1 / routeTwoSub (m-1))

routeTwo :: Int -> Ratio Integer
routeTwo n = 1 + 1 / routeTwoSub n
-}

-- dynamic plan version
routeTwoSubTable :: Int -> [Ratio Integer]
routeTwoSubTable 0 = [2 % 1]
routeTwoSubTable n = next : subTable
                     where
                       subTable = routeTwoSubTable (n-1)
                       next = 2 + (1 / head subTable)

routeTwoD :: Int -> [Ratio Integer]
routeTwoD n = map (\r -> 1 + 1 / r) $ routeTwoSubTable n


diffDigit :: Ratio Integer -> Bool
diffDigit r = lenN > lenD
              where
                lenN = length $ show $ numerator r
                lenD = length $ show $ denominator r


main :: IO ()
--main = print $ length $ filter diffDigit $ map routeTwo [0..999]
main = print $ length $ filter diffDigit $ routeTwoD 999


