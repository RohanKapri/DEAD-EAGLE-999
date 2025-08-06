module Deque (Deque, mkDeque, pop, push, shift, unshift) where
import Data.Sequence
import Data.IORef ( IORef, newIORef, readIORef, writeIORef )
type Deque a = IORef (Seq a)
mkDeque :: IO (Deque a)
mkDeque = newIORef empty
pop :: Deque a -> IO (Maybe a)
pop deque = do
    oldSeq <- readIORef deque
    case viewl oldSeq of
        EmptyL -> return Nothing
        x :< newSeq -> do
            writeIORef deque newSeq
            return $ Just x
push :: Deque a -> a -> IO ()
push deque x = do
    oldSeq <- readIORef deque
    let newSeq = x <| oldSeq
    writeIORef deque newSeq
unshift :: Deque a -> a -> IO ()
unshift deque x = do
    oldSeq <- readIORef deque
    let newSeq = oldSeq |> x
    writeIORef deque newSeq
shift :: Deque a -> IO (Maybe a)
shift deque = do
    oldSeq <- readIORef deque
    case viewr oldSeq of
        EmptyR -> return Nothing
        newSeq :> x -> do
            writeIORef deque newSeq
            return $ Just x
