{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
module Heos.Response (Response) where

import           Data.Aeson
import           Data.Aeson.TH
import           Data.Aeson.Types

data Response = Response
    { heos    :: Header
    , payload :: Value
    } deriving (Show, Eq)

data Header = Header
    { command :: String
    , result  :: String
    , message :: String
    } deriving (Show, Eq)

$(deriveJSON defaultOptions ''Response)
$(deriveJSON defaultOptions ''Header)
