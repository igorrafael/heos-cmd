{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
module Heos.Response (Response, payload, responseError) where

import           Data.Aeson
import           Data.Aeson.TH
import           Data.Aeson.Types

data Response t = Response
    { heos    :: Header
    , payload :: Maybe t
    } deriving (Show, Eq)

data Header = Header
    { command :: String
    , result  :: String
    , message :: String
    } deriving (Show, Eq)

$(deriveJSON defaultOptions ''Response)
$(deriveJSON defaultOptions ''Header)

responseError :: String -> String -> Response t
responseError command message = Response header Nothing
  where header = Header command "error" message
