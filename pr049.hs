{-
The arithmetic sequence, 1487, 4817, 8147, in which each of the terms increases
by 3330, is unusual in two ways: (i) each of the three terms are prime, and,
(ii) each of the 4-digit numbers are permutations of one another.

There are no arithmetic sequences made up of three 1-, 2-, or 3-digit primes,
exhibiting this property, but there is one other 4-digit increasing sequence.

What 12-digit number do you form by concatenating the three terms in this
sequence?
-}

module Main where

import Control.Applicative   -- for <$>, <*>
import Data.List  -- for sort
import Prime (primesUnder)

-- 4-digits primes
primes4digits :: [Int]
primes4digits = dropWhile (<999) $ primesUnder 10000

-- 3 element list is arithmetic ?
arithmetic :: [Int] -> Bool
arithmetic (n1:n2:n3:_) = (n2 > n1) && ((n2 - n1) == (n3 - n2))

-- two number is permutations ?
isPermutation :: Int -> Int -> Bool
isPermutation n m = (sort . show) n == (sort . show) m

-- XXX: 3 numbers from lst
-- XXX:   I try to use an applicative style, but it is slow...
__threes :: [Int] -> [[Int]]
__threes ns = map (\(n1,n2,n3) -> [n1,n2,n3]) triples
            where
              triples = (,,) <$> ns <*> ns <*> ns

-- choice three number from list. the three number is permutation
threes :: [Int] -> [[Int]]
threes ns = filterThree $ foldr1 (++) $ map sub [0..(length ns - 3)]
            where
              filterThree = filter (\ns -> length ns == 3)
              sub x = map ((ns !! x):) (choicePair (filter (isPermutation (ns !! x)) (drop (x+1) ns)))

-- choice two number from list
choicePair :: [Int] -> [[Int]]
choicePair ns = map sort $ concatMap func [0..(length ns - 1)]
                where
                  func x = map (:[ns !! x]) $ drop (x+1) ns

-- concat numbers
concatNums :: [Int] -> Int
concatNums ns = read $ concatMap show ns

-- main function
main :: IO ()
main = print $ concatNums targetTriple
       where
         arithmeticSequence = filter arithmetic $ threes primes4digits
         targetTriple = head $ filter (\t -> head t /= 1487) arithmeticSequence
