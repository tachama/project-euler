{-
Euler published the remarkable quadratic formula:

  n ** 2 + n + 41

It turns out that the formula will produce 40 primes for the consecutive
values n = 0 to 39. However, when n = 40, 40 ** 2 + 40 + 41 = 40(40 + 1) + 41
is divisible by 41, and certainly when n = 41, 41 ** 2 + 41 + 41 is clearly
divisible by 41.

Using computers, the incredible formula  n ** 2 - 79 * n + 1601 was discovered,
which produces 80 primes for the consecutive values n = 0 to 79. The product
of the coefficients, -79 and 1601, is -126479.

Considering quadratics of the form:

  n ** 2 + a * n + b, where |a| < 1000 and |b| < 1000

  where |n| is the modulus/absolute value of n
  e.g. |11| = 11 and |4| = 4

Find the product of the coefficients, a and b, for the quadratic expression
that produces the maximum number of primes for consecutive values of n,
starting with n = 0.
-}

module Main where

-- prime list
primes :: [Int]
primes = 2:[n | n <- [3,5..], all (\x -> n `mod` x /= 0) [2..(n-1)]]

-- check number is prime or not
isPrime :: Int -> Bool
isPrime n = elem n $ takeWhile (<=n) primes

-- formula
formula :: Num a => a -> a -> a -> a
formula a b n = n * n + a * n + b

-- return continuous prime numbers with coefficients a, b
contPrimes :: (Int, Int) -> [Int]
contPrimes (a,b) = takeWhile isPrime $ map (formula a b) [0..]

-- combination of list
combinate :: [a] -> [a] -> [(a,a)]
combinate xs ys = [(x,y) | x <- xs, y <- ys]

-- create all combination of a and b
makeComb :: Integral a => a -> [(a, a)]
makeComb n = combinate lst lst
             where lst = [(negate n + 1)..(n-1)]

-- multiple of second tupple.
multSndTup :: Num a => (b, (a, a)) -> a
multSndTup (_, (x,y)) = x * y

-- problem max absolute
maxAbs = 1000

main = print $ multSndTup $ maximum $ zip (map (length . contPrimes) lst) lst
       where lst = makeComb maxAbs

