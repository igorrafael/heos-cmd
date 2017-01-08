{-# LANGUAGE TemplateHaskell #-}
module Main where

import           Heos.Browse.GetMusicSources
import           Heos.Browse.PlayInput
import           Heos.Connection             (connect)
import           Heos.Player.GetPlayers
import           Heos.Response
import           HFlags
import           System.Environment          (getArgs, getProgName)

--defineFlag "h:host" "192.168.0.19" "IP of any HEOS device in the network."
flags_host = "192.168.0.19"
--defineFlag "n:name" "HEOS 1" "Name of the device to control."
flags_name = "HEOS 1"
--defineFlag "p:playInput" "aux_in_1" "Input source to play."
flags_playInput = "aux_in_1"

main :: IO ()
main = do
  _ <- $initHFlags "HEOS simplified command line interface. Uses the telnet CLI provided by Denon."
  connection <- connect flags_host
  response <- getPlayerByName flags_name connection
  print $ show response
  --sources <- getMusicSources connection
  --print $ show sources
  case flags_playInput of
    "" -> putStrLn "no source specified"
    _ -> do
      inputChange <- case response of
        Just p -> playInput p flags_playInput connection
        _      -> return $ responseError "" "player not found"
      return ()
