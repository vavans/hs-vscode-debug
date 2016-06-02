module Main where

import DebugProtocol (parseRequest)
import Network
import System.IO

processHandle :: Handle -> IO ()
processHandle handle = do
                line <- hGetChar handle
                --putStrLn ("response: " ++ line)
                putChar line
                --putStr ">"
                --cmd <- getLine
                --hPutStr handle cmd
                processHandle handle

handleSocket :: Socket -> IO ()
handleSocket sock = do
                (handle, _, _) <- accept sock
                hSetBuffering handle NoBuffering
                hSetBuffering stdout NoBuffering
                processHandle handle
                handleSocket sock

main :: IO ()
main = withSocketsDo $ do
                sock <- listenOn $ PortNumber 4711
                putStrLn "Listening on port 4711..."
                handleSocket sock