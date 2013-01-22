{-
There are exactly ten ways of selecting three from five, 12345:

  123, 124, 125, 134, 135, 145, 234, 235, 245, and 345

In combinatorics, we use the notation, 5C3 = 10.

In general,

  nCr = n! / (r! (n-r)!)
  ,where r <= n, n! = n*(n1)*...*3*2*1, and 0! = 1.

It is not until n = 23, that a value exceeds one-million: 23C10 = 1144066.

How many, not necessarily distinct, values of  nCr, for 1 <=n <= 100,
are greater than one-million?
-}

module Main where

import Control.Applicative

million :: (Integral a) => a
million = 1000000

factorial :: (Integral a) => a -> a
factorial 0 = 1
factorial n = n * factorial (n-1)

combination :: (Integral a) => a -> a -> a
combination n r = factorial n `div` (factorial r * factorial (n-r))

main = print $ length $ filter (>million) $ map (uncurry combination) nrTuples
       where
         nrTuples = filter (uncurry (>=)) allTuples
         allTuples = (,) <$> [1..100] <*> [1..100]

-- memos
--  (\t -> fst t >= snd t) = (uncurry (>=))
