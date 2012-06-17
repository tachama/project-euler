{-
The fraction 49/98 is a curious fraction, as an inexperienced mathematician
in attempting to simplify it may incorrectly believe that 49/98 = 4/8, which
is correct, is obtained by cancelling the 9s.

We shall consider fractions like, 30/50 = 3/5, to be trivial examples.

There are exactly four non-trivial examples of this type of fraction, less
than one in value, and containing two digits in the numerator and denominator.

If the product of these four fractions is given in its lowest common terms,
find the value of the denominator.
-}

module Main where

import Data.List
import Data.Maybe

-- Fraction type; pair of numerator and denomiator.
type Fraction = (Int, Int)

-- numerator of fraction
num :: Fraction -> Int
num = fst

-- denomiator of fraction
den :: Fraction -> Int
den = snd

-- pair of number for this problem.
--   numerator is 2 digits number; 10 to 99
--   denomiator is 2 digits number and fraction is less than 1; (a+1) to 99
numbers :: [Fraction]
numbers = [(a,b) | a <- [10..99], b <- [(a+1)..99]]

-- remove element from list
remove :: Eq a => a -> [a] -> [a]
remove _ [] = []
remove x (n:ns) | x == n = ns
                | otherwise = n:remove x ns

-- return simplify fractions if exist.
simplify :: Fraction -> Maybe Fraction
simplify f = let n = show $ num f
                 d = show $ den f
                 com = common n d
             in
               fmap (\c -> (read $ remove c n, read $ remove c d)) com

-- find common element from two list.
common :: Eq a => [a] -> [a] -> Maybe a
common [] ns= Nothing
common (m:ms) ns = let idx = elemIndex m ns
                   in
                     if isNothing idx
                     then common ms ns
                     else Just m

-- Fraction is trivial or not.
isTrivial :: Fraction -> Bool
isTrivial f = (num f `mod` 10 == 0) && (den f `mod` 10 == 0)

-- check numbers is curious
isCurious :: Fraction -> Bool
isCurious f = let s = simplify f
              in
                if isNothing s
                then False
                else num f * den (fromJust s) == den f * num (fromJust s)

-- product of fraction list
productF :: [Fraction] -> Fraction
productF = foldr (\a b -> (num a * num b, den a * den b)) (1,1)

-- lowest common of fraction
lowest :: Fraction -> Fraction
lowest f = lowestSub f [2..(num f)]

lowestSub :: Fraction -> [Int] -> Fraction
lowestSub f [] = f
lowestSub f (n:ns) = if (num f `mod` n == 0) && (den f `mod` n == 0)
                     then lowestSub (num f `div` n, den f `div` n) (n:ns)
                     else lowestSub f ns

-- solve problem
solve :: Int
solve = let curiouses = filter isCurious numbers
            nonTrivialCuriouses = filter (not . isTrivial) curiouses
        in
          den $ lowest $ productF nonTrivialCuriouses

main = print solve