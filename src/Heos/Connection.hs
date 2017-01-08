module Heos.Connection (connect, get) where

import           Data.ByteString.Char8 (pack, unpack)
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

get :: Connection -> String -> IO String
get connection message = do
  connectionPut connection $ pack $ message++"\r\n"
  response <- connectionGet connection 9999
  return $ unpack response
