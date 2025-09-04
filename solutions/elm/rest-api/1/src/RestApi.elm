module RestApi exposing (databaseFromJsonString, get, post)

import Dict exposing (Dict)
import Json.Decode as D exposing (Error)
import Json.Encode as E
import Maybe
import Result


type alias JsonString =
    String


type alias Name =
    String


type alias User =
    { name : Name
    , owes : Dict Name Float
    , owedBy : Dict Name Float
    , balance : Float
    }


type alias Database =
    Dict Name User


type alias Loan =
    { lender: Name
    , borrower: Name
    , amount: Float
    }


decodeUser : D.Decoder User
decodeUser =
    D.map4 User
        (D.field "name" D.string)
        (D.field "owes" (D.dict D.float))
        (D.field "owed_by" (D.dict D.float))
        (D.field "balance" (D.float))


decodeUserList: D.Decoder (List User)
decodeUserList =
    D.field "users" (D.list decodeUser)


encodeUser : User -> E.Value
encodeUser u =
    E.object
        [ ("name", E.string u.name)
        , ("owes", E.dict identity E.float u.owes)
        , ("owed_by", E.dict identity E.float u.owedBy)
        , ("balance", E.float u.balance)
        ]


encodeUserList : List User -> E.Value
encodeUserList users =
    E.list encodeUser users


makeDb : List User -> Database
makeDb users =
        Dict.fromList (List.map (\u -> (u.name, u)) users)


databaseFromJsonString : JsonString -> Result Error Database
databaseFromJsonString payload =
    Result.map makeDb (D.decodeString decodeUserList payload)


extractUsers : Database -> Maybe JsonString -> List Name
extractUsers db payload =
   case payload of
       Nothing -> Dict.keys db
       Just users ->
           Result.withDefault []
               (D.decodeString (D.field "users" (D.list D.string)) users)


listUsers : Database -> List Name -> JsonString
listUsers db names =
    let users =
            List.sort names
            |> List.foldl
                (\name us ->
                    case Dict.get name db of
                        Just u -> u :: us
                        Nothing -> us
                ) []
             |> List.reverse
    in
    E.encode 0 (E.object [("users", encodeUserList users)])


newUser : Name -> User
newUser name =
    User name Dict.empty Dict.empty 0


encodeError : String -> JsonString
encodeError message =
    E.encode 0 (E.string message)


addUser :  Database -> JsonString -> JsonString
addUser db payload =
    case D.decodeString (D.field "user" D.string) payload of
        Ok name ->
            if Dict.member name db then
                encodeError "user already exists"
            else
                E.encode 0 (encodeUser (newUser name))
        _ -> encodeError "bad /add payload"


decodeLoan : D.Decoder Loan
decodeLoan =
    D.map3 Loan
        (D.field "lender" D.string)
        (D.field "borrower" D.string)
        (D.field "amount" D.float)


insertDebt : Name -> Float -> Dict Name Float -> Dict Name Float
insertDebt name amt account =
    if amt > 0 then
        Dict.insert name amt account
    else
        Dict.remove name account


transfer : User -> User -> Float -> (User, User)
transfer lender borrower amount =
    let
        oldBal =
            if Dict.member borrower.name lender.owes then
                Maybe.withDefault 0 (Dict.get borrower.name lender.owes)
            else
                -(Maybe.withDefault 0 (Dict.get lender.name borrower.owes))
        newBal = oldBal - amount
        lOwes = insertDebt borrower.name newBal lender.owes
        lOwedBy = insertDebt borrower.name -newBal lender.owedBy
        bOwes = insertDebt lender.name -newBal borrower.owes
        bOwedBy = insertDebt lender.name newBal borrower.owedBy
    in
        (User lender.name lOwes lOwedBy (lender.balance + amount),
         User borrower.name bOwes bOwedBy (borrower.balance - amount))


addLoan : Database -> JsonString -> JsonString
addLoan db payload =
    case D.decodeString decodeLoan payload of
        Ok loan ->
            let
                lender = Maybe.withDefault (newUser "?")
                             (Dict.get loan.lender db)
                borrower = Maybe.withDefault (newUser "?")
                             (Dict.get loan.borrower db)
             in
                if lender.name == "?" || borrower.name == "?" then
                    encodeError "unknown user in /iou"
                else
                    let
                        (l, b) = transfer lender borrower loan.amount
                     in
                        listUsers (makeDb [l, b]) [l.name, b.name]
        _ -> encodeError "bad /iou payload"


get : Database -> String -> Maybe JsonString -> JsonString
get database url maybePayload =
    case url of
        "/users" -> listUsers database (extractUsers database maybePayload)
        _ -> encodeError "bad URL in get"


post : Database -> String -> JsonString -> JsonString
post database url payload =
    case url of
        "/add" -> addUser database payload
        "/iou" -> addLoan database payload
        _ -> encodeError "bad URL in post"