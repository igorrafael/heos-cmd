{-# LANGUAGE TemplateHaskell #-}
module Heos.Connection (connect, get) where

import           Data.Aeson
import qualified Data.ByteString.Char8      as BS
import qualified Data.ByteString.Lazy.Char8 as BSL
import           Heos.Response
import           HFlags
import           Network.Connection
import           System.IO

defineFlag "d:device" "192.168.0.19" "IP of any HEOS device in the network."

connect :: IO Connection
connect = do
  ctx <- initConnectionContext
  connectTo ctx ConnectionParams
                { connectionHostname  = flags_device --TODO autodiscover
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
  --TODO sleep if response.message=="command under process"

  case response of
    Just x -> return x
    _      -> return $ responseError command "decode failure"
