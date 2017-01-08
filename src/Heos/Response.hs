{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
module Heos.Response (Response) where

import           Data.Aeson
import           Data.Aeson.TH
import           Data.Aeson.Types

data Response = Response
    { heos    :: Header
    , payload :: [Payload]
    } deriving (Show, Eq)

data Payload = Payload
    { name    :: String
    , pid     :: Int
    , model   :: String
    , version :: String
    , ip      :: String
    , network :: String
    , lineout :: Int
    } deriving (Show, Eq)

data Header = Header
    { command :: String
    , result  :: String
    , message :: String
    } deriving (Show, Eq)

$(deriveJSON defaultOptions ''Response)
$(deriveJSON defaultOptions ''Payload)
$(deriveJSON defaultOptions ''Header)
