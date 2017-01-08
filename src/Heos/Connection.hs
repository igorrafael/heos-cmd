{-# LANGUAGE OverloadedStrings #-}
module Heos.Connection (connect, get) where

import           Data.Aeson
import qualified Data.ByteString.Char8      as BS
import qualified Data.ByteString.Lazy.Char8 as BSL
import           Heos.Response
import           Network.Connection
import           System.IO

connect :: String -> Int -> IO Connection
connect host port = do
    ctx <- initConnectionContext
    connectTo ctx ConnectionParams
                  { connectionHostname  = host
                  , connectionPort      = 1255
                  , connectionUseSecure = Nothing
                  , connectionUseSocks  = Nothing
                  }

get :: String -> Connection -> IO (Maybe Response)
get message connection = do
  connectionPut connection $ BS.pack $ message ++ "\r\n"
  response <- connectionGet connection maxBound
  return $ decode $ BSL.fromStrict response
