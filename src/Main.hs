
{-# LANGUAGE TemplateHaskell #-}
module Main where

import           Heos.Browse.GetMusicSources
import           Heos.Browse.PlayInput
import           Heos.Connection             (connect, sendRequest)
import           Heos.Player.GetPlayers
import           Heos.Player.Player          (Player (..))
import           Heos.Response
import           HFlags
import           System.Environment          (getArgs, getProgName)

defineFlag "n:name" "" "Name of the device to control."
defineFlag "play_input" "" "Input source to play. Ex: aux_in_1, optical_in_1, hdmi_in_1.\nSee page 31 for other values: http://www2.aerne.com/Public/dok-sw.nsf/1edd1194263fab29c12573ba003a1f32/9193bea412104506c1257dbd00298c78/$FILE/HEOS_CLI_PROTOCOL_Specification_290616.pdf"
--defineFlag "v:verbose" False "Verbose mode."


--workaround to known issue: https://github.com/nilcons/hflags/issues/14
defineFlag "dummy" "dummy" "dummy flag"

main :: IO ()
main = do
  _ <- $initHFlags "HEOS simplified command line interface. Uses the telnet CLI provided by Denon."
  connection <- connect
  let send = sendRequest connection
  response <- send playerRequest
  let player = playerByName flags_name response

  inputChange <- case player of
    Just p -> send $ playInput p flags_play_input :: IO (Response [Player])
    _      -> return $ responseError "" $ "player \"" ++ flags_name ++ "\" not found"
  return ()
