module Heos.Browse.PlayInput
( playInput
) where

import           Data.Aeson.Types   (Value)
import           Heos.Connection    (get)
import           Heos.Player.Player (Player (pid))
import           Heos.Response      (Response)
import           Network.Connection

-- HACK the response should actually have no type
-- but also needs to implement FromJSON
playInput :: Player -> String -> Connection -> IO (Response Value)
playInput player input = get $ "heos://browse/play_input?" ++ args
  where
    args = "pid=" ++ pid' ++ "&" ++ "input=inputs/" ++ input
    pid' = show $ pid player
