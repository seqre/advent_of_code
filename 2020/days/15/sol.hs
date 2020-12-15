module Main (main) where

import Data.Map (Map, fromList, findWithDefault, (!?), insert, size)
import Data.Maybe (fromMaybe)
import Debug.Trace (trace)

main :: IO()
main = do
	let input = [6,3,15,13,1,0]
	--let input = [0,3,6]
        let parsed = fromList $ zip (init input) [1..]
        print $ "Sol 1: " ++ show (sol1 (last input) (size parsed + 1) parsed)
        print $ "Sol 2: " ++ show (sol2 (last input) (size parsed + 1) parsed)

sol1 :: Int -> Int -> Map Int Int -> Int
sol1 = solutionFinder 2020

sol2 :: Int -> Int -> Map Int Int -> Int
sol2 = solutionFinder 30000000

solutionFinder :: Int -> Int -> Int -> Map Int Int -> Int
solutionFinder limit num turn mp = if turn == limit then num else solutionFinder limit next (turn + 1) mp'
                                   where
                        		   last_pos = findWithDefault 0 num mp
                        		   mp' = insert num turn mp
                        		   next = if last_pos == 0 then 0 else turn - last_pos
