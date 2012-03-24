{-
Let d(n) be defined as the sum of proper divisors of n (numbers less than n
which divide evenly into n).
If d(a) = b and d(b) = a, where a != b, then a and b are an amicable pair and
each of a and b are called amicable numbers.

For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44,
55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4,
71 and 142; so d(284) = 220.

Evaluate the sum of all the amicable numbers under 10000.
-}

module Main where

input_num = 10000

-- divisors list of n
divisors :: Int -> [Int]
divisors n = [x | x <- [1..(n `div` 2)], n `mod` x == 0]

-- sum of proper divisors.
d :: Int -> Int
d n = sum $ divisors n

-- check whether is amicable
amicable :: Int -> Bool
amicable n = let n2 = d n
             in
               if (n2 /= n) && (n == d n2) then True else False

-- sum of all the amicable numbers under n.
solve :: Int -> Int
solve n = sum $ filter amicable [1..(n-1)]

main = print $ solve input_num