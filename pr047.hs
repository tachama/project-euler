{-
The first two consecutive numbers to have two distinct prime factors are:

  14 = 2 * 7
  15 = 3 * 5

The first three consecutive numbers to have three distinct prime factors are:

  644 = (2 ** 2) * 7 * 23
  645 = 3 * 5 * 43
  646 = 2 * 17 * 19

Find the first four consecutive integers to have four distinct primes factors.
What is the first of these numbers?
-}

module Main where

import Prime (primes)

-- number of distinct prime factor
n_prime_factor :: Int -> Int
n_prime_factor = npf_sub primes False

-- subroutine of n_prime_factor
npf_sub :: [Int] -> Bool -> Int -> Int
npf_sub _ cont 1 = if cont then 1 else 0
npf_sub prs cont n = if n `mod` (head prs) == 0
                     then npf_sub prs True (n `div` head prs)
                     else if cont
                          then (+1) $ npf_sub (tail prs) False n
                          else npf_sub (tail prs) False n

-- check n has specific number of distinct primes factor
is_n_prime_factor :: Int -> Int -> Bool
is_n_prime_factor n = (==n) . n_prime_factor
is3pf :: Int -> Bool
is3pf = is_n_prime_factor 3  -- is 3 distinct primes factor
is4pf :: Int -> Bool
is4pf = is_n_prime_factor 4  -- is 4 distinct primes factor

-- checker function
checker :: Int -> Bool
checker n = ((is4pf (2*n-1)) && ((is4pf (2*n-3)) || (is4pf (2*n+1)))) || ((is4pf (2*n+1)) && ((is4pf (2*n-1)) || (is4pf (2*n+3))))



find_first :: Int -> Int
find_first n | all is4pf [2*n-3, 2*n-2, 2*n-1, 2*n] = 2*n-3
             | all is4pf [2*n-2, 2*n-1, 2*n, 2*n+1] = 2*n-2
             | all is4pf [2*n-1, 2*n, 2*n+1, 2*n+2] = 2*n-1
             | all is4pf [2*n, 2*n+1, 2*n+2, 2*n+3] = 2*n

main :: IO ()
main = print $ find_first answer
       where
         evens_4prs = filter is4pf [2,4..]
         candidate1 = filter (\n -> (is3pf (n-1)) || (is3pf (n+1))) evens_4prs
         candidate2 = filter checker candidate1
         answer = head candidate2
