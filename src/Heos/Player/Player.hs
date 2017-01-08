{-# LANGUAGE TemplateHaskell #-}
module Heos.Player.Player (Player(..)) where

import           Data.Aeson.TH

data Player = Player
    { name    :: String
    , pid     :: Int
    , gid     :: Maybe Int
    , model   :: String
    , version :: String
    , ip      :: String
    , network :: String
    , lineout :: Int
    , control :: Maybe Int
    } deriving (Show, Eq)

$(deriveJSON defaultOptions ''Player)
