module Main where

import           Heos.Connection    (telnet)
import           System.Environment (getArgs, getProgName)

host _ = "192.168.0.19"
port _ = 1255

main :: IO ()
main = do
    args <- getArgs
    putStrLn "Hi"
    telnet (host args) (port args)
    putStrLn "Bye"
