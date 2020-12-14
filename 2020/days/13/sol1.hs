module Main (main) where

import Data.List (sort, union)
import Data.List.Split (splitOn)


main :: IO()
main = do
        raw_input <- readFile "input.txt"
	let input = lines raw_input
	let earliest_timestamp = read (head input) :: Int
        let buses = parse $ input !! 1
	print $ show earliest_timestamp ++ " " ++ show buses
        print $ "Sol 1: " ++ show (sol1 earliest_timestamp buses)

parse :: String -> [Int]
parse line = map (\x -> read x :: Int) . filter (/= "x") $ splitOn "," line

calc :: Int -> [Int] -> (Int,Int)
calc start list = if null matching then calc1 (start + 1) list
        		   	    else (start, fst $ head matching)
                   where
        	          matching = filter (\x -> snd x == 0) $ map (\y -> (y, mod start y)) list

sol1 :: Int -> [Int] -> Int
sol1 start list = bus * (pickup - start)
                  where
		         (pickup, bus) = calc1 start list
