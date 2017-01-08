{-# LANGUAGE OverloadedStrings #-}
module Heos.Connection (connect, get) where

import           Data.Aeson
import qualified Data.ByteString.Char8      as BS
import qualified Data.ByteString.Lazy.Char8 as BSL
import           Heos.Response
import           Network.Connection
import           System.IO

connect :: String -> IO Connection
connect host = do
    ctx <- initConnectionContext
    connectTo ctx ConnectionParams
                  { connectionHostname  = host
                  , connectionPort      = 1255
                  , connectionUseSecure = Nothing
                  , connectionUseSocks  = Nothing
                  }

get :: (FromJSON t) => String -> Connection -> IO (Response t)
get command connection = do
  putStrLn $ "sending command: " ++ command
  connectionPut connection $ BS.pack $ command ++ "\r\n"
  json <- connectionGetLine maxBound connection
  putStrLn $ "received: " ++ show json
  let response = decode $ BSL.fromStrict json
  case response of
    Just x -> return x
    _      -> return $ responseError command "decode failure"
