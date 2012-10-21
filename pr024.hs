{-
A permutation is an ordered arrangement of objects. For example, 3124 is one
possible permutation of the digits 1, 2, 3 and 4. If all of the permutations
are listed numerically or alphabetically, we call it lexicographic order.
The lexicographic permutations of 0, 1 and 2 are:

  012   021   102   120   201   210

What is the millionth lexicographic permutation of the
digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?
-}

module Main where

-- factorial number.
factorial :: Int -> Int
factorial n | n == 0 = 1
            | otherwise = n * factorial (n-1)

-- remove entry from list
removeFromList :: (Eq a) => a -> [a] -> [a]
removeFromList x = filter (/=x)

-- solve problem; return number sequenct at list.
solve :: Int -> [Int] -> [Int]
solve _ [] = []
solve x ns = (ns !! d) : solve m (removeFromList (ns !! d) ns)
             where
               (d, m) = divMod x $ factorial $ length ns - 1

main = print $ foldl1 (\a b -> 10*a+b) $ solve (1000000-1) [0..9]