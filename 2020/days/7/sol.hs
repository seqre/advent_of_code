module Main (main) where

import Data.List
import Data.List.Split
import Data.Maybe
import qualified Data.Map as M
import Text.Read


main :: IO()
main = do
        raw_input <- readFile "input.txt"
        let rules = map words $ lines raw_input
        let parsed = parse rules
        print $ take 10 $ M.toList parsed
        print ("Sol 1: " ++ (show $ sol1 parsed))
        print ("Sol 2: " ++ (show $ sol2 parsed))


parse :: [[String]] -> M.Map String (M.Map String Int)
parse [] = M.empty
parse (x:xs) = let bags = drop 4 x
                   parsed_elem = if length bags == 3 then [] else parseElem (drop 4 x)
                   name = unwords $ take 2 x
               in  M.union (M.singleton name $ M.fromList parsed_elem) $ parse xs


parseElem :: [String] -> [(String,Int)]
parseElem [] = []
parseElem (num:look:color:_:rest) = let bag = unwords [look,color]
                                        number = readMaybe num::Maybe Int
                                    in  if isJust number
                                        then (bag,fromJust number) : (parseElem rest)
                                        else []


sol1 :: M.Map String (M.Map String Int) -> Int
sol1 big_map = sum $ map calcBag $ M.elems big_map
               where
                       calcBag :: M.Map String Int -> Int
                       calcBag mp = if M.member "shiny gold" mp
                                    then 1
                                    else let maps = map (\x -> big_map M.! x) $ M.keys mp
                                             space = map calcBag maps
                                         in  if sum space > 0 then 1 else 0


sol2 :: M.Map String (M.Map String Int) -> Int
sol2 big_map = let shiny_map = big_map M.! "shiny gold"
                   countBags :: M.Map String Int -> Int
                   countBags cmap = if M.null cmap
                                    then 0
                                    else sum $ map (\(x,y) -> y + y * countBags (big_map M.! x)) $ M.toList cmap
               in  countBags shiny_map
