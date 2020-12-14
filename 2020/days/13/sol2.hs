module Main (main) where

import Data.List (sort, union, group)
import Data.List.Split (splitOn)
import Data.List.Utils (replace)


main :: IO()
main = do
        raw_input <- readFile "input.txt"
	let input = lines raw_input
        let buses = parse $ input !! 1
        print $ "Sol 2: " ++ show (sol2 buses)

parse :: String -> [(Int,Int)]
parse line = filter (\x -> fst x /= 0) pairs
             where
		     nums = map (\x -> read x :: Int) . splitOn "," $ replace "x" "0" line
		     pairs = zip nums [0..]

sol2 :: [(Int, Int)] -> Integer
sol2 list = chineseRemainder vals muds prod
            where
		    vals = map (\(m,v) -> mod (m - v) m) list
		    muds = map fst list
		    prod = product muds

-- code adapted from: https://gist.github.com/trevordixon/6895802
extendedEuclid :: (Int, Int) -> (Int, Int)
extendedEuclid (0, b) = (0, 1)
extendedEuclid (a, b) = (t - (div b a) * s, s)
                        where
				(s, t) = extendedEuclid ((mod b a), a)

inverseModulo :: (Int, Int) -> Int
inverseModulo p@(a, m) = let (x, y) = extendedEuclid p
                         in  mod x m

chineseRemainder :: [Int] -> [Int] -> Int -> Integer
chineseRemainder [] [] _ = 0
chineseRemainder (val:vals) (mud:muds) prod = mod (curr_val + next_val) (toInteger prod)
                                              where
						      dived    = div prod mud
						      (_, s)   = extendedEuclid (mud, dived)
                                                      curr_val = toInteger (val * s * dived)
						      next_val = chineseRemainder vals muds prod
