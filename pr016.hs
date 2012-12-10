{-
2 ** 15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.

What is the sum of the digits of the number 2 ** 1000?
-}

module Main where

input_num :: Int
input_num = 1000

-- double value of digit list.
mult2 :: [Int] -> Int -> [Int]
mult2 [] over = if over == 0
                  then []
                  else [over]
mult2 (n:ns) over = m:mult2 ns d
                      where
                        v = 2 * n + over
                        m = v `mod` 10
                        d = v `div` 10

-- subroutine of bvalue
bvalue_sub :: Int -> [Int] -> [Int]
bvalue_sub 0 ns = ns
bvalue_sub n ns = bvalue_sub (n-1) (mult2 ns 0)

-- return 2 ** n as digit list
bvalue :: Int -> [Int]
bvalue n = bvalue_sub n [1]

main :: IO ()
main = print $ sum $ bvalue input_num