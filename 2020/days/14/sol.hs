module Main (main) where

import Data.List (sort, union)
import Data.List.Split (splitOn)
import Data.Maybe (fromJust)
import Text.Regex (mkRegex, matchRegex)
import Data.Bifunctor (second)
import Data.Map (Map, empty, elems, insert)
import Debug.Trace

main :: IO()
main = do
        raw_input <- readFile "input.txt"
	let parsed = parse raw_input
        print $ "Sol 1: " ++ show (sol1 empty parsed)
        print $ "Sol 2: " ++ show (sol2 empty parsed)

parse :: String -> [(String, [(Int,Int)])]
parse input = map (second (map getFromRegex)) pairs
              where
		      batches = map (init . splitOn "\n") . tail $ splitOn "mask = " input
		      pairs = map (\(l:ls) -> (l, ls)) batches
		      regex = mkRegex "mem\\[([0-9]+)\\] = ([0-9]+)"
		      getFromRegex str = let matched = fromJust $ matchRegex regex str
		      			     mem_index = read (head matched) :: Int
					     mem_value = read (matched !! 1) :: Int
		                         in  (mem_index, mem_value)

int2Bin :: Int -> [Int]
int2Bin 0 = []
int2Bin x = if even x then rest ++ [0]
                      else rest ++ [1]
                              where rest = int2Bin (floor (fromIntegral x / 2))

bin2Int :: [Int] -> Int
bin2Int = foldl (\acc el -> acc * 2 + el) 0

applyMask :: String -> Int -> Int
applyMask mask val = bin2Int $ apply padded mask
                     where
			     bin_val = int2Bin val
			     padded = replicate (36 - length bin_val) 0 ++ bin_val
			     apply vals masks = foldl changeMask [] $ zip vals masks
			     changeMask acc (v, m) = acc ++ case m of '1' -> [1]
			                                              '0' -> [0]
								      'X' -> [v]

sol1 :: Map Int Int -> [(String, [(Int, Int)])] -> Int
sol1 mp []                = sum $ elems mp
sol1 mp ((mask, vals):ls) = sol1 mp' ls
                            where
				    vals' = map (second (applyMask mask)) vals
				    mp' = foldl (\m (k,v) -> insert k v m) mp vals'

makeAdresses :: Int -> String -> [Int]
makeAdresses val mask = map bin2Int $ helper padded mask
                        where
				bin_val = int2Bin val
                                padded = replicate (36 - length bin_val) 0 ++ bin_val
				helper [num]      [musk]       = case musk of '1' -> [[1]]
				                                              '0' -> [[num]]
									      'X' -> [[0],[1]]
				helper (num:nums) (musk:musks) = let next = helper nums musks
				                                 in case musk of '1' -> map ([1] ++) next
								                 '0' -> map ([num] ++) next
										 'X' -> map ([0] ++) next ++ map ([1] ++) next

sol2 :: Map Int Int -> [(String, [(Int, Int)])] -> Int
sol2 mp []                = sum $ elems mp
sol2 mp ((mask, vals):ls) = sol2 mp' ls
                            where
				    vals' = foldl addMoreAdresses [] vals
				    mp' = foldl (\m (k,v) -> insert k v m) mp vals'
				    
				    addMoreAdresses acc (ind, val) = let adresses = makeAdresses ind mask
				                                         pairs = zip adresses $ repeat val
								     in  acc ++ pairs

