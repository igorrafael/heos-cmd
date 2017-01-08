module Heos.Browse.PlayInput
( playInput
) where

import           Data.Aeson.Types   (Value)
import           Heos.Connection    (get)
import           Heos.Response      (Response)
import           Network.Connection

playInput :: Connection -> IO (Response Value) --HACK the response should actually have no type
playInput = get $ "heos://browse/play_input?" ++ args
  where
    args = "" --TODO get args
