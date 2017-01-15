module Heos.Player.GetPlayers
( getPlayers
, getPlayerByName
, getPlayerByPid
, getPlayersByGid
, getPlayersByNetwork
) where

import           Data.List
import           Heos.Connection    (get)
import           Heos.Player.Player (Player (..))
import           Heos.Request       (Request (..))
import           Heos.Response      (Response, payload)
import           Network.Connection

--IO functions
getPlayers :: (Request -> t) -> t
getPlayers f = f $ Request "heos://player/get_players" []

getPlayerByName :: String -> (Request -> IO (Response [Player])) -> IO (Maybe Player)
getPlayerByName v = fmap (playerByName v) . getPlayers
getPlayerByPid :: Int -> (Request -> IO (Response [Player])) -> IO (Maybe Player)
getPlayerByPid v = fmap (playerByPid v) . getPlayers
getPlayersByGid :: Maybe Int -> (Request -> IO (Response [Player])) -> IO [Player]
getPlayersByGid v = fmap (playersByGid v) . getPlayers
getPlayersByNetwork :: String -> (Request -> IO (Response [Player])) -> IO [Player]
getPlayersByNetwork v = fmap (playersByNetwork v) . getPlayers


--Pure functions
playerByName :: String -> Response [Player] -> Maybe Player
playerByName = playerByField name

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
