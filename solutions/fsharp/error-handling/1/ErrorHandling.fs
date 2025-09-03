// Dedicated to Shree DR.MDD
module ErrorHandling

open System
type Result<'T, 'TError> =
    | Ok of 'T
    | Error of 'TError

let handleErrorByThrowingException () =
    failwith "An error occurred."

let handleErrorByReturningOption (txt: string) =
    match Int32.TryParse txt with
    | true, parsed -> Some parsed
    | false, _ -> None

let handleErrorByReturningResult (txt: string) =
    match Int32.TryParse txt with
    | true, parsed -> Ok parsed
    | false, _ -> Error "Could not convert input to integer"

let cleanupDisposablesWhenThrowingException disposable =
    use activeRes = disposable
    failwith "Throw exception"

let bind transform resVal =
    match resVal with
    | Ok data -> transform data
    | Error err -> Error err
