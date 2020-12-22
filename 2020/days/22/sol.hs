module Main (main) where

import Data.List (sort)
import Data.List.Split (splitOn)
import Data.Set (Set, empty, insert, member)
import Debug.Trace (trace)

data Player = P Int [Int] deriving (Show, Eq, Ord)

main :: IO()
main = do
	raw_input <- readFile "input.txt"
        let parsed = parse raw_input
        print $ "Sol 1: " ++ show (sol1 parsed)
        print $ "Sol 2: " ++ show (sol2 parsed)

sol1 :: (Player, Player) -> Int
sol1 = getScore . getWinner . play1

sol2 :: (Player, Player) -> Int
sol2 = getScore . getWinner . play2 empty

parse :: String -> (Player, Player)
parse input = (head players, players !! 1)
              where
		      players = map (getPlayer . lines) . splitOn "\n\n" $ input

getPlayer :: [String] -> Player
getPlayer (ids:nums) = P (getInt id) cards
                      where
			      id = init . last . words $ ids
			      cards = map getInt nums

getInt :: String -> Int
getInt str = read str :: Int

play1 :: (Player, Player) -> (Player, Player)
play1 (l@(P _ []), r)             = (l, r)
play1 (l, r@(P _ []))             = (l, r)
play1 (P id_l left, P id_r right) = if left_wins then play1 (P id_l (tail left ++ new), P id_r (tail right))
         					 else play1 (P id_l (tail left), P id_r (tail right ++ new))
                                    where
         				   left_wins = head left >= head right
         				   new = reverse . sort $ [head left, head right]

play2 :: Set (Player, Player) -> (Player, Player) -> (Player, Player)
play2 _    (l@(P _ []), r)             = (l, r)
play2 _    (l, r@(P _ []))             = (l, r)
play2 prev players@(P id_l (h_l:rest_l), P id_r (h_r:rest_r)) = play2 (insert players prev) new_players
      where
              is_recursive = length rest_l >= h_l && length rest_r >= h_r
	      left_wins | member players prev = True
                        | is_recursive        = id_l == (getId . getWinner . play2 empty $ getSubPlayers h_l h_r players)
                        | otherwise           = h_l >= h_r
              new = if left_wins then [h_l, h_r] else [h_r, h_l]
	      new_players = if left_wins then (P id_l (rest_l ++ new), P id_r rest_r)
                                         else (P id_l rest_l, P id_r (rest_r ++ new))


getSubPlayers :: Int -> Int -> (Player, Player) -> (Player, Player)
getSubPlayers l_num r_num (P id_l (_:left), P id_r (_:right)) = (P id_l (take l_num left), P id_r (take r_num right))

getWinner :: (Player, Player) -> Player
getWinner (l@(P _ []), r)             = r
getWinner (l, r@(P _ []))             = l

getId :: Player -> Int
getId (P id _) = id

getScore :: Player -> Int
getScore (P _ nums) = sum . zipWith (*) [1..] $ reverse nums
