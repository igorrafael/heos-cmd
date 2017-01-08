module Heos.Browse.PlayInput
( playInput
) where

import           Data.Aeson.Types   (Value)
import           Heos.Connection    (get)
import           Heos.Response      (Response)
import           Network.Connection

-- HACK the response should actually have no type
-- but also needs to implement FromJSON
playInput :: Connection -> IO (Response Value)
playInput = get $ "heos://browse/play_input?" ++ args
  where
    args = "" --TODO get args
