module Main (main) where

import Data.List (sortBy)
import Debug.Trace (trace)

main :: IO()
main = do
	let input = [9, 6, 3, 2, 7, 5, 4, 8, 1]
	--let input = [3, 8, 9, 1, 2, 5, 4, 6, 7]
        print $ "Sol 1: " ++ show (sol1 input)
        print $ "Sol 2: " ++ show (sol2 (input ++ [10..1000000]))

sol1 :: [Int] -> Int
sol1 input = concatNum . takeWhile (/= 1) . tail . dropWhile (/= 1) $ cycle result
             where
		     result = iterate (step getNext) input !! 100
		     concatNum = foldl (\acc el -> acc * 10 + el) 0

sol2 :: [Int] -> Int
sol2 input = product . take 2 . tail . dropWhile (/= 1) $ cycle result
             where
		     result = iterate (step getNext') input !! 10000000

step :: (Int -> Int) -> [Int] -> [Int]
step next (curr:rest) = new
                   where
			   (three, remaining) = splitAt 3 rest
			   dest = getDest (next curr) remaining
			   (pre_dest, post_dest) = span (/= dest) remaining
			   new = pre_dest ++ [head post_dest] ++ three ++ tail post_dest ++ [curr]

getDest :: Int -> [Int] -> Int
--getDest val list | trace (show val ++ "\t" ++ show list) False = undefined
getDest val list = head dropped
                    where
                            sorted = sortBy (flip compare) list
			    dropped = dropWhile (> val) sorted ++ takeWhile (> val) sorted

getNext :: Int -> Int
getNext x = mod (x - 2) 9 + 1

getNext' :: Int -> Int
getNext' x = mod (x - 2) 1000000 + 1
