module Main (main) where

import Data.List (groupBy, nub)
import Data.Map (Map, findWithDefault, fromList, empty, toAscList, mapWithKey, alter, keys, size)
import qualified Data.Map as M (filter)
import Data.Tuple.Extra (fst3, snd3, thd3)
import Data.Bifunctor (second)
import Debug.Trace (trace)

type Coord3D = (Int, Int, Int)
type Map3D = Map Coord3D Bool

main :: IO()
main = do
	input <- readFile "input.txt"
        let parsed = parse input
        print $ "Sol 1: " ++ show (sol1 parsed)

sol1 :: Map3D -> Int
sol1 mp = getActiveCubes . (!! 6) $ iterate step mp

parse :: String -> Map3D
parse input = fromList tuples
              where
		      rows = zip [0..] $ lines input
		      mapRow (ind, list) = foldl (\acc el -> ((fromInteger ind, length acc, 0), el == '#') : acc ) [] list
		      tuples = concatMap mapRow rows

step :: Map3D -> Map3D
step mp = mp_mapped
          where
		  neighbours = nub . concatMap getNeighbours $ keys mp
		  neutral Nothing = Just False
		  neutral (Just x) = Just x
		  mp_extended = foldl (\mup coord -> alter neutral coord mup ) mp neighbours
		  mp_mapped = mapWithKey (getState mp) mp_extended

getState :: Map3D -> Coord3D -> Bool -> Bool
getState mp coord val | val && (num == 2 || num == 3) = True
                      | not val && num == 3           = True
		      | otherwise                     = False
	              where num = countActive mp coord

countActive :: Map3D -> Coord3D -> Int
countActive mp coords = length $ filter (== True) vals
                        where
		       	        neighbours = getNeighbours coords
		       	        vals = map (\k -> findWithDefault False k mp) neighbours

getNeighbours :: Coord3D -> [Coord3D]
getNeighbours (x,y,z) = [(a,b,c) | a <- [x-1..x+1], b <- [y-1..y+1], c <- [z-1..z+1], (a,b,c) /= (x,y,z)]

getActiveCubes :: Map3D -> Int
getActiveCubes mp = size $ M.filter (== True) mp
