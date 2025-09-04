module GithupApi exposing (..)

import Dict exposing (Dict)
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode exposing (Value)


type alias User =
    { id : Int
    , name : Maybe String
    , login : String
    , avatarUrl : String
    , siteAdmin : Bool
    }


type Side
    = Left
    | Right


type alias Comment =
    { id : Int
    , pullRequestReviewId : Maybe Int
    , user : User
    , body : String
    , side : Side
    , links : Dict String String
    }


decodeId : Decoder Int
decodeId =
    Decode.field "id" Decode.int


decodeName : Decoder (Maybe String)
decodeName =
    Decode.field "name" Decode.string
        |> Decode.maybe


decodeUser : Decoder User
decodeUser =
    Decode.map5 User 
        decodeId 
        decodeName 
        (Decode.field "login" Decode.string)
        (Decode.field "avatar_url" Decode.string)
        (Decode.field "site_admin" Decode.bool)


decodePullRequestReviewId : Decoder (Maybe Int)
decodePullRequestReviewId =
    Decode.nullable Decode.int
        |> Decode.field "pull_request_review_id"


decodeSide : Decoder Side
decodeSide =
    Decode.field "side" Decode.string
        |> Decode.andThen
            (\x -> 
                case x of
                    "LEFT" -> Decode.succeed Left
                    "RIGHT" -> Decode.succeed Right
                    _ -> Decode.fail "")


decodeLinks : Decoder (Dict String String)
decodeLinks =
    Decode.field "href" Decode.string
        |> Decode.dict
        |> Decode.field "_links"


decodeComment : Decoder Comment
decodeComment =
    Decode.map6 Comment
        decodeId
        decodePullRequestReviewId
        (Decode.field "user" decodeUser)
        (Decode.field "body" Decode.string)
        decodeSide
        decodeLinks


decodeComments : Decoder (List Comment)
decodeComments =
    Decode.list decodeComment


encodeComment : Comment -> Value
encodeComment comment =
    Encode.object
        [ ( "id", Encode.int comment.id )
        , ( "pull_request_review_id", 
            case comment.pullRequestReviewId of
                Nothing -> Encode.null
                Just reviewId -> Encode.int reviewId )
        , ( "user",
            [ ( "id", Encode.int comment.user.id )
            , ( "login", Encode.string comment.user.login )
            , ( "avatar_url", Encode.string comment.user.avatarUrl )
            , ( "site_admin", Encode.bool comment.user.siteAdmin )
            ]
                |> (\x -> 
                    case comment.user.name of
                        Nothing -> x
                        Just name -> x ++ [( "name", Encode.string name )])
                |> Encode.object )
        , ( "body", Encode.string comment.body )
        , ( "side",
            case comment.side of
                Left -> Encode.string "LEFT"
                Right -> Encode.string "RIGHT" )
        , ( "_links", 
            Encode.dict 
                identity
                (\x -> Encode.object [( "href", Encode.string x )])
                comment.links )
        ]