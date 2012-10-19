{-
The number, 1406357289, is a 0 to 9 pandigital number because it is made up of
each of the digits 0 to 9 in some order, but it also has a rather interesting
sub-string divisibility property.

Let d(1) be the 1st digit, d(2) be the 2nd digit, and so on. In this way, we
note the following:

  d(2)d(3)d(4)=406 is divisible by 2
  d(3)d(4)d(5)=063 is divisible by 3
  d(4)d(5)d(6)=635 is divisible by 5
  d(5)d(6)d(7)=357 is divisible by 7
  d(6)d(7)d(8)=572 is divisible by 11
  d(7)d(8)d(9)=728 is divisible by 13
  d(8)d(9)d(10)=289 is divisible by 17

Find the sum of all 0 to 9 pandigital numbers with this property.
-}

module Main where

-- simple implementation of prime number list
primes :: Integral a => [a]
primes = [n | n <- [2..], all (\x -> n `mod` x /= 0) [2..(n-1)]]

-- convert list of digit to number; e.g. [1,2,3,4] -> 1234
listToNum :: Num a => [a] -> a
listToNum = foldl1 (\n1 n2 -> n1 * 10 + n2)

-- all 0 to 9 pandigital number list
pandigitals :: Integral a => [a]
pandigitals = filter (>1000000000) $ map listToNum $ makePandigitals [0..9]

-- subroutine for creating pandigitals
makePandigitals :: Eq a => [a] -> [[a]]
makePandigitals ns = if length ns == 1
                     then [ns]
                     else concatMap sub ns
                          where
                            sub = \n -> map (n:) $ makePandigitals $ delList n ns
                            delList = \x xs -> filter (/= x) xs

-- create problem properties number list;
-- e.g. 1406357289 -> [406, 63, 635, 357, 572, 728, 289]
numToPropnums :: Int -> [Int]
numToPropnums n = map (\x -> read $ take 3 $ drop x ns) [1..7]
                  where ns = show n

-- check number has above property ?
hasProperty :: Int -> Bool
hasProperty n = all (uncurry canDiv) $ zip (numToPropnums n) primes
                where canDiv x y = x `mod` y == 0

-- main
main = print $ sum $ filter hasProperty pandigitals
