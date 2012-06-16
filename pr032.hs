{-
We shall say that an n-digit number is pandigital if it makes use of all the
digits 1 to n exactly once; for example, the 5-digit number, 15234, is 1
through 5 pandigital.

The product 7254 is unusual, as the identity, 39 * 186 = 7254, containing
multiplicand, multiplier, and product is 1 through 9 pandigital.

Find the sum of all products whose multiplicand/multiplier/product identity can
be written as a 1 through 9 pandigital.

HINT: Some products can be obtained in more than one way so be sure to only
include it once in your sum.
-}

module Main where

import qualified Data.Set as S

digits :: [Char]
digits = "123456789"

-- permutation list
permutation :: [a] -> [[a]]
permutation [] = [[]]
permutation xs = let rt = map (rotate xs) [1..(length xs)]
                     rts = map (\ns -> map (head ns :) (permutation (tail ns))) rt
                 in
                   foldl (++) [] rts

-- rotate list to n
rotate :: [a] -> Int -> [a]
rotate xs 0 = xs
rotate (x:xs) n = rotate (xs ++ [x]) (n - 1)  -- XXX: need tuning?

-- reduce list
reduceList :: [[a]] -> [a]
reduceList = foldr (++) []

-- remove duplicated from list
removeDup :: Ord a => [a] -> [a]
removeDup = S.toList . S.fromList

-- devide 3 parts
divide3 :: [a] -> (Int, Int) -> ([a], [a], [a])
divide3 ss (d1,d2) = (ss1, ss2, ss3)
                     where
                       (ss1, tmp) = splitAt d1 ss
                       (ss2, ss3) = splitAt d2 tmp

-- all patterns for divide3
--   each digits a, b and c must be above rule for isMMP
--     a+b-1=c or a+b=c
--   this rule is condition for true isMMP.
dividePattern n = [(a,b) | a <- [1..(n-2)], b <- [1..(n-a-1)], f a b (n-a-b)]
                  where
                    f = \a b c -> a <= b && (a + b - 1 == c || a + b == c)

-- convert String to Int at triple; three elements tuple.
readTriple :: (String, String, String) -> (Int, Int, Int)
readTriple (x1,x2,x3) = (read x1, read x2, read x3)

-- a * b = c on triple (a, b, c)
isMMP :: (Int, Int, Int) -> Bool
isMMP (a,b,c) | a >= b = False
              | otherwise = a * b == c

-- found all products whose multiplicand/multiplier/product identity
mmpProducts base = let pattern = dividePattern $ length base
                       f = \s -> map (readTriple . (divide3 s)) $ pattern
                       alls = reduceList $ map f $ permutation base
                   in
                     removeDup $ map (\(_, _, x) -> x) $ filter isMMP alls

main = print $ sum $ mmpProducts digits
