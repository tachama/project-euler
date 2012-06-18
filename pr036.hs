{-
The decimal number, 585 = 1001001001b (binary), is palindromic in both bases.

Find the sum of all numbers, less than one million, which are palindromic in
base 10 and base 2.

(Please note that the palindromic number, in either base, may not include
leading zeros.)
-}

module Main where

import Data.Char

-- problem max number.
maxNumber :: Int
maxNumber = 1000000 - 1

-- check string is palindromic or not
palindromic :: String -> Bool
palindromic ss = ss == reverse ss

-- convert number to binary string (XXX: return reverse)
binStr :: Int -> String
binStr 0 = "0"
binStr 1 = "1"
binStr n = let (d,m) = divMod n 2
           in chr (m + ord '0'): binStr d

-- number is palindromic on base 10 and base 2
isPalindromic :: Int -> Bool
isPalindromic n = (palindromic . show) n && (palindromic . binStr) n

main = print $ sum $ filter isPalindromic [0..maxNumber]