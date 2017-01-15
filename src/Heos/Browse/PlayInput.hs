module Heos.Browse.PlayInput
( playInput
) where

import           Heos.Player.Player (Player (pid))
import           Heos.Request       (Parameter (..), Request (..))
import           Heos.Response      (Response)

playInput :: Player -> String -> Request
playInput player input = Request "heos://browse/play_input?" args
  where
    args =
      [ Parameter "pid" (show $ pid player)
      , Parameter "input" ("inputs/" ++ input)
      ]
