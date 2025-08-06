module Robot (Robot, initialState, mkRobot, resetName, robotName) where
import Control.Monad.State ( MonadIO(liftIO), StateT, MonadState(get, put) )
import Data.IORef ( IORef, newIORef, readIORef, writeIORef )
import System.Random (randomRIO)
newtype Robot = Robot{name::IORef String}
newtype RunState = RunState [String]
initialState :: RunState
initialState = RunState []
mkRobot :: StateT RunState IO Robot
mkRobot = do
    RunState oldNames <- get
    newName <- liftIO $ generateName oldNames
    newNameRef <- liftIO $ newIORef newName
    put $ RunState (newName:oldNames)
    return $ Robot newNameRef
resetName :: Robot -> StateT RunState IO ()
resetName robot = do
    RunState oldNames <- get
    newName <- liftIO $ generateName oldNames
    liftIO $ writeIORef (name robot) newName
    return ()
robotName :: Robot -> IO String
robotName robot = readIORef $ name robot
generateName :: [String] -> IO String
generateName oldNames = do
    newName <- mapM randomRIO namePattern
    if newName `elem` oldNames then generateName oldNames else return newName
namePattern :: [(Char, Char)]
namePattern = [('A', 'Z'), ('A', 'Z'), ('0', '9'), ('0', '9'), ('0', '9')]
