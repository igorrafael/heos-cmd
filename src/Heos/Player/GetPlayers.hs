module Heos.Player.GetPlayers
( playerRequest
, playerByName
, playerByPid
, playersByGid
, playersByNetwork
) where

import           Data.List
import           Heos.Player.Player (Player (..))
import           Heos.Request       (Request (..))
import           Heos.Response      (Response, payload)

playerRequest :: Request
playerRequest = Request "heos://player/get_players" []

defaultPlayer :: Response [Player] -> Maybe Player
defaultPlayer response = do
  players <- payload response
  return $ head players

playerByName :: String -> Response [Player] -> Maybe Player
playerByName "" = defaultPlayer
playerByName n  = playerByField name n

playerByPid :: Int -> Response [Player] -> Maybe Player
playerByPid = playerByField pid

playersByGid :: Maybe Int -> Response [Player] -> [Player]
playersByGid = playersByField gid

playersByNetwork :: String -> Response [Player] -> [Player]
playersByNetwork = playersByField network

playersByField :: Eq a => (Player -> a) -> a -> Response [Player] -> [Player]
playersByField field value = filter ((== value) . field) . getPayload

playerByField :: Eq a => (Player -> a) -> a -> Response [Player] -> Maybe Player
playerByField field value = find ((== value) . field) . getPayload

getPayload :: Response [Player] -> [Player]
getPayload response = case payload response of
  Just p -> p
  _      -> []
