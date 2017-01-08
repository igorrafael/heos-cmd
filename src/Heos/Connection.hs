{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell   #-}
module Heos.Connection (connect, get) where

import           Data.Aeson
import           Data.Aeson.TH
import           Data.Aeson.Types
import qualified Data.ByteString.Char8      as BS
import qualified Data.ByteString.Lazy.Char8 as BSL
import           Network.Connection
import           System.IO

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

connect :: String -> Int -> IO Connection
connect host port = do
    ctx <- initConnectionContext
    connectTo ctx ConnectionParams
                  { connectionHostname  = host
                  , connectionPort      = 1255
                  , connectionUseSecure = Nothing
                  , connectionUseSocks  = Nothing
                  }

get :: Connection -> String -> IO (Maybe Response)
get connection message = do
  connectionPut connection $ BS.pack $ message ++ "\r\n"
  response <- connectionGet connection maxBound
  return $ decode $ BSL.fromStrict response
