module Heos.Connection (telnet) where

import           Control.Concurrent           (forkIO, killThread)
import           Control.Monad.IO.Class       (MonadIO, liftIO)
import           Control.Monad.Trans.Resource
import           Data.Conduit
import           Data.Conduit.Binary          (sinkHandle, sourceHandle)
import           Network                      (PortID (..), connectTo)
import           System.IO

-- original code from http://www.mega-nerd.com/erikd/Blog/CodeHacking/Haskell/telnet-conduit.html

-- Usage example \
-- main :: IO ()
-- main = do
--     args <- getArgs
--     case args of
--         [host, port] -> telnet host (read port :: Int)
--         _ -> usageExit
--   where
--     usageExit = do
--         name <- getProgName
--         putStrLn $ "Usage : " ++ name ++ " host port"

telnet :: String -> Int -> IO ()
telnet host port = runResourceT $ do
    (releaseSock, hsock) <- allocate (connectTo host $ PortNumber $ fromIntegral port) hClose
    liftIO $ mapM_ (`hSetBuffering` LineBuffering) [ stdin, stdout, hsock ]
    (releaseThread, _) <- allocate (forkIO $ runResourceT $ sourceHandle stdin $$ sinkHandle hsock) killThread
    sourceHandle hsock $$ sinkHandle stdout
    release releaseThread
    release releaseSock
