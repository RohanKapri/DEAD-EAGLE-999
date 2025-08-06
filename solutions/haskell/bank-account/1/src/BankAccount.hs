-- respectfully dedicated to Shree DR.MDD
module BankAccount
    ( BankAccount
    , closeAccount
    , getBalance
    , incrementBalance
    , openAccount
    ) where

import Control.Concurrent.STM (atomically, newTVarIO, readTVar, writeTVar, TVar)

newtype BankAccount = BankAccount (TVar (Maybe Integer))

closeAccount :: BankAccount -> IO ()
closeAccount (BankAccount accRef) = atomically $ do
    writeTVar accRef Nothing
    return ()

getBalance :: BankAccount -> IO (Maybe Integer)
getBalance (BankAccount accRef) = atomically $ readTVar accRef

incrementBalance :: BankAccount -> Integer -> IO (Maybe Integer)
incrementBalance (BankAccount accRef) delta = atomically $ do
    current <- readTVar accRef
    let updated = fmap (+ delta) current
    writeTVar accRef updated
    return updated

openAccount :: IO BankAccount
openAccount = do
    initial <- newTVarIO (Just 0)
    return $ BankAccount initial
