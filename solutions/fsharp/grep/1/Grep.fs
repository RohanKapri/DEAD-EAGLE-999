module Grep

open System.IO
open System.Text.RegularExpressions

type GrepArg = 
    {
        LineNumbers:        bool
        FileNamesOnly:      bool
        CaseInsensitive:    bool 
        Invert:             bool
        EntireLines:        bool
    }

let getGrepArg (flagArguments: string list) =
    let getParam flag =
        List.contains(flag) flagArguments
    {
        LineNumbers     = getParam "-n"
        FileNamesOnly   = getParam "-l"
        CaseInsensitive = getParam "-i"
        Invert          = getParam "-v"
        EntireLines     = getParam "-x"
    }

let getRegex (pattern: string) (arg: GrepArg) =
    let pat = 
        if arg.EntireLines then
            "^" + pattern + "$"
        else 
            pattern
    
    let regexOptions = 
        if arg.CaseInsensitive then
            RegexOptions.IgnoreCase
        else
            RegexOptions.None

    new Regex(pat, regexOptions)

let fileToList fileName : string list =
    fileName
    |> File.ReadAllLines
    |> Array.toList

let fileToOutput (pattern: string) (arg: GrepArg) (mulitpleFiles: bool) (fileName: string) =
    let rx = getRegex pattern arg

    let matchFunction (str: string) : bool =
        rx.IsMatch str = not arg.Invert
    
    let getFileLines = fileName |> fileToList        

    if arg.FileNamesOnly then
        if getFileLines |> List.exists(fun l -> matchFunction l) then 
            [fileName] 
        else 
            []
    else
        getFileLines
        |> List.mapi(fun i l -> (i + 1, matchFunction l, l))
        |> List.filter(fun (_, mached, _) -> mached)
        |> List.map(fun (lineNumber, _, lineText) -> 
            match (arg.LineNumbers, mulitpleFiles) with
            | (true,  true)  -> sprintf "%s:%d:%s"  fileName lineNumber lineText
            | (true,  false) -> sprintf "%d:%s"     lineNumber lineText
            | (false, true)  -> sprintf "%s:%s"     fileName lineText
            | (false, false) -> lineText
            )
          
let grep (files: string list) (flagArguments: string list) (pattern: string) : string list = 
    let arg = getGrepArg flagArguments
    let isMultipleFiles = files.Length > 1

    files
    |> List.collect(fileToOutput pattern arg isMultipleFiles)