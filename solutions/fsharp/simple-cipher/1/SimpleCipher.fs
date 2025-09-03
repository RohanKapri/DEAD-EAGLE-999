module SimpleCipher
open System
type SimpleCipher(key: string) =
    do
        match key with
        | k when k = String.Empty -> invalidArg "Key" "with empty key"
        | k when k|> Seq.forall (fun ch -> Char.IsUpper(ch)) = true -> invalidArg "Key" "all uppercase key"
        | k when k|> Seq.forall (fun ch -> Char.IsDigit(ch)) = true -> invalidArg "Key" "with a numeric ke"
        | _ -> ()
    member private self.Modulo x y = ((x % y) + y) % y
    member private self.CharToInt (c:char) = (int c) - (int 'a')
    member private self.IntToChar (i:int) = (char)((int 'a') + (self.Modulo i 26))
    member private self.ShiftChar operation key char = 
        operation (self.CharToInt char) (self.CharToInt key) |> self.IntToChar
    member private self.Shift operation (key:string) (input:string) =
        input
        |> Seq.mapi (fun idx ch -> self.ShiftChar operation key.[idx % key.Length] ch) 
        |> Seq.toArray
        |> String
    member self.Key with get() = key
    member private self.EncodeStep key input = self.Shift (+) key input   
    member private self.DecodeStep key input = self.Shift (-) key input
    member self.Encode(plaintext) = self.EncodeStep key plaintext
    member self.Decode(ciphertext) = self.DecodeStep key ciphertext
    new() = 
        let random = System.Random()
        let letters = ['a'..'z']
        let keyLength = 26
        let generateKey() = 
            let numberOfLetters = List.length letters 
            Array.init keyLength (fun _ -> List.item (random.Next(numberOfLetters)) letters) |> String
        SimpleCipher(generateKey()) 