module LensPerson

open Aether
open Aether.Operators
open System

type Address = 
    { street: string
      houseNumber: int
      place: string
      country: string }

    static member street_ =
        (fun a -> a.street),
        (fun s a -> {a with street = s})

type Born = 
    { at: Address
      on: DateTime }

    static member at_ =
        (fun b -> b.at),
        (fun a b -> {b with at = a})

    static member on_ =
        (fun b -> b.on),
        (fun o b -> {b with on = o})

type Name = 
    { name: string
      surName: string }

type Person = 
    { name: Name
      born: Born
      address: Address }

    static member born_ =
        (fun p -> p.born),
        (fun b p -> {p with born = b})

    static member address_ =
        (fun p -> p.address),
        (fun a p -> {p with address = a})

type System.DateTime with
    static member month_ =
        (fun (d : DateTime) -> d.Month),
        (fun m (d : DateTime) ->
            DateTime(d.Year, m, d.Day, d.Hour, d.Minute, d.Second, d.Millisecond, d.Kind))

let bornAtStreet = Person.born_ >-> Born.at_ >-> Address.street_
let currentStreet = Person.address_ >-> Address.street_
let bornOn = Person.born_ >-> Born.on_
let birthMonth = bornOn >-> DateTime.month_