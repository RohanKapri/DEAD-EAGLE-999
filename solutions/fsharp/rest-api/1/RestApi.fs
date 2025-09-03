// Dedicated to Shree DR.MDD
module RestApi

open Newtonsoft.Json
open System.Collections.Generic

type UsersRequest =
    { users: string array }

type AddUserRequest =
    { user: string }

type IouRequest =
    { lender: string
      borrower: string
      amount: decimal }

type User =
    { name: string
      owes: Map<string, decimal>
      owed_by: Map<string, decimal>
      balance: decimal }

type Db = { users: User array }

type RestApi(input: string) =

    let mutable userDict =
        (JsonConvert.DeserializeObject<Db> input).users
        |> Seq.map (fun u -> (u.name, u))
        |> dict
        |> Dictionary

    let serialize names =
        let users = names |> Array.sort |> Array.map (fun n -> userDict.[n])
        let db: Db = { users = users }
        JsonConvert.SerializeObject db

    let normalizeBalances user =
        let combined =
            user.owes
            |> Map.toSeq |> Seq.map (fun (key, v) -> (key, -v))
            |> Seq.append (user.owed_by |> Map.toSeq)
            |> Seq.groupBy fst
            |> Seq.map (fun (k, group) -> k, group |> Seq.sumBy snd)
            |> List.ofSeq
        { user with
            owes = combined |> List.filter (snd >> ((>) 0m)) |> List.map (fun (k,v) -> k, -v) |> Map.ofList
            owed_by = combined |> List.filter (snd >> ((<) 0m)) |> Map.ofList
            balance = combined |> List.sumBy snd }

    member this.Get(url: string) =
        match url with
        | "/users" -> serialize (userDict.Keys |> Seq.toArray)
        | _ -> failwith "bad request"

    member this.Get(url: string, payload: string) =
        match url with
        | "/users" ->
            let req = JsonConvert.DeserializeObject<UsersRequest> payload
            serialize req.users
        | _ -> failwith "bad request"

    member this.Post(url: string, payload: string) =
        match url with
        | "/add" ->
            let req = JsonConvert.DeserializeObject<AddUserRequest> payload
            let newUser = { name = req.user; owes = Map.empty; owed_by = Map.empty; balance = 0.0m }
            userDict.Add(newUser.name, newUser)
            JsonConvert.SerializeObject newUser

        | "/iou" ->
            let req = JsonConvert.DeserializeObject<IouRequest> payload
            let lender = userDict.[req.lender]
            let borrower = userDict.[req.borrower]
            let updatedLender =
                { lender with owed_by = lender.owed_by |> Map.add borrower.name req.amount }
                |> normalizeBalances
            let updatedBorrower =
                { borrower with owes = borrower.owes |> Map.add lender.name req.amount }
                |> normalizeBalances
            userDict.[req.lender] <- updatedLender
            userDict.[req.borrower] <- updatedBorrower
            serialize [| updatedBorrower.name; updatedLender.name |]

        | _ -> failwith "bad request"
