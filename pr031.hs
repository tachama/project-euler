{-
In England the currency is made up of pound, P, and pence, p, and there are
eight coins in general circulation:

  1p, 2p, 5p, 10p, 20p, 50p, 1P (100p) and 2P (200p).

It is possible to make 2P in the following way:

  1 * 1P + 1 * 50p + 2 * 20p + 1 * 5p + 1 * 2p + 3 * 1p

How many different ways can 2P be made using any number of coins?
-}

module Main where

import Data.Maybe

-- all coins
coins :: [Int]
coins = [200, 100, 50, 20, 10, 5, 2, 1]

coinsPattern :: Int -> [Int] -> Int
coinsPattern 0 _ = 1
coinsPattern _ [] = 0
coinsPattern n (x:xs) = let as = takeWhile (\a -> a * x <= n) [0..]
                        in
                          sum $ map (\a -> coinsPattern (n - a * x) xs) as

main = print $ coinsPattern 200 coins