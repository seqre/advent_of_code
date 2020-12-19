module Main (main) where

import Data.List (groupBy, nub)
import Data.Map (Map, findWithDefault, fromList, empty, toAscList, mapWithKey, alter, keys, size)
import qualified Data.Map as M (filter)
import Data.Tuple.Extra (fst3, snd3, thd3)
import Data.Bifunctor (second)
import Debug.Trace (trace)

type Coord4D = (Int, Int, Int, Int)
type Map4D = Map Coord4D Bool

main :: IO()
main = do
	input <- readFile "input.txt"
        let parsed = parse input
        print $ "Sol 2: " ++ show (sol2 parsed)

sol2 :: Map4D -> Int
sol2 mp = getActiveCubes . (!! 6) $ iterate step mp

parse :: String -> Map4D
parse input = fromList tuples
              where
		      rows = zip [0..] $ lines input
		      mapRow (ind, list) = foldl (\acc el -> ((fromInteger ind, length acc, 0, 0), el == '#') : acc ) [] list
		      tuples = concatMap mapRow rows

step :: Map4D -> Map4D
step mp = mp_mapped
          where
		  neighbours = nub . concatMap getNeighbours $ keys mp
		  neutral Nothing = Just False
		  neutral (Just x) = Just x
		  mp_extended = foldl (\mup coord -> alter neutral coord mup ) mp neighbours
		  mp_mapped = mapWithKey (getState mp) mp_extended

getState :: Map4D -> Coord4D -> Bool -> Bool
getState mp coord val | val && (num == 2 || num == 3) = True
                      | not val && num == 3           = True
		      | otherwise                     = False
	              where num = countActive mp coord

countActive :: Map4D -> Coord4D -> Int
countActive mp coords = length $ filter (== True) vals
                        where
		       	        neighbours = getNeighbours coords
		       	        vals = map (\k -> findWithDefault False k mp) neighbours

getNeighbours :: Coord4D -> [Coord4D]
getNeighbours (x,y,z,w) = [(a,b,c,d) | a <- [x-1..x+1], b <- [y-1..y+1], c <- [z-1..z+1], d <- [w-1..w+1], (a,b,c,d) /= (x,y,z,w)]

getActiveCubes :: Map4D -> Int
getActiveCubes mp = size $ M.filter (== True) mp
