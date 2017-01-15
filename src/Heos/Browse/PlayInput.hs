module Heos.Browse.PlayInput
( playInput
) where

import           Data.Aeson.Types   (Value)
import           Heos.Connection    (get)
import           Heos.Player.Player (Player (pid))
import           Heos.Request       (Parameter (..), Request (..))
import           Heos.Response      (Response)
import           Network.Connection

-- HACK the response should actually have no type
-- but also needs to implement FromJSON
playInput :: Player -> String -> (Request -> IO (Response Value)) -> IO (Response Value)
playInput player input f = f $ Request "heos://browse/play_input?" args
  where
    args =
      [ Parameter "pid" (show $ pid player)
      , Parameter "input" ("inputs/" ++ input)
      ]
