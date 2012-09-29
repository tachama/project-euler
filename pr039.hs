{-
If p is the perimeter of a right angle triangle with integral length sides,
{a,b,c}, there are exactly three solutions for p = 120.

  {20,48,52}, {24,45,51}, {30,40,50}

For which value of p < 1000, is the number of solutions maximised?
-}

module Main where

-- generate triple (a,b,c)
--   a + b + c = n, a <= b <= c
genTriple :: Int -> [(Int, Int, Int)]
genTriple n = [(a,b,n-a-b) | a <- [1..(n `div` 3)], b <- [a..((n -a) `div` 2)]]

-- check triple value is right triagle or not.
isRightTrianble :: (Int, Int, Int) -> Bool
isRightTrianble (a,b,c) = a ^ 2 + b ^ 2 == c ^ 2

-- calculate number of solutions about a number.
nSolution :: Int -> Int
nSolution = length . (filter isRightTrianble) . genTriple

-- main function
main = print $ (snd . maximum) $ zip (map nSolution range) range
       where
         range = [1..999]
