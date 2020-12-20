module Main (main) where

import Data.List
import Data.Map (Map, fromList, adjust, (!), (!?), findWithDefault, filterWithKey, size, toAscList, mapWithKey)
import qualified Data.Map as M (filter)

type Map2D = Map (Int, Int) Char

main :: IO()
main = do
        raw_input <- readFile "input.txt"
        let parsed = parse raw_input
        print $ "Sol 1: " ++ show (sol1 parsed 0)

sol1 :: Map2D -> Int -> Int
sol1 mp prev = let stepped = step mp
                   taken = countTaken stepped
	       in  if taken == prev then taken
		                    else sol1 stepped taken

parse :: String -> Map2D
parse input = fromList tuples
              where
	              rows = zip [0..] $ lines input
	              mapRow (ind, list) = foldl (\acc el -> ((fromInteger ind, length acc), el) : acc ) [] list
                      tuples = concatMap mapRow rows

printMap :: Map2D -> String
printMap mp = foldl func "" (toAscList mp) ++ "\n"
              where
                      func acc ((_,y),v) = if y == 0 then acc ++ "\n" ++ [v] 
                                                     else acc ++ " " ++ [v]

step :: Map2D -> Map2D
step mp = mapWithKey (getState mp) mp
		  
getState :: Map2D -> (Int, Int) -> Char -> Char
getState mp c@(x, y) val | val == 'L' && num == 0 = '#'
                         | val == '#' && num >= 4 = 'L'
		         | otherwise              = val
                         where num = countActive mp c

getNeighbors :: (Int, Int) -> [(Int, Int)]
getNeighbors (x, y) = [(a,b) | a <- [x-1..x+1], b <- [y-1..y+1], (a,b) /= (x,y)]

countActive :: Map2D -> (Int, Int) -> Int
countActive mp c@(x, y) = length $ filter (== '#') vals
                          where
			          neighbors = getNeighbors c
				  vals = map (\k -> findWithDefault '.' k mp) neighbors

countTaken :: Map2D -> Int
countTaken = size . M.filter (== '#')
