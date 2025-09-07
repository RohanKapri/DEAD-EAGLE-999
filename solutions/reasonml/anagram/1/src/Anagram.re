let anagrams = (str, anagrams) => {
  let sortStr = unsorted =>
    unsorted
    |> String.lowercase
    |> Js.String.split("")
    |> Js.Array.sortInPlace
    |> Js.Array.joinWith("");
  
  let baseStr = sortStr(str);
  
  anagrams
  |> List.filter(s =>
       sortStr(s) == baseStr
       && String.lowercase(str) !== String.lowercase(s)
     );
    };