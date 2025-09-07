let validate = n => {
  let digitArray =
    n->string_of_int |> Js.String.split("") |> Array.map(int_of_string);
  
  let digitCount = digitArray |> Array.length;
  
  let raisedDigits =
    digitArray |> Array.map(v => Js.Math.pow_int(~base = v, ~exp = digitCount));
  
  let sum = raisedDigits -> Belt.Array.reduce(0, (acc, curr) => acc + curr);
  sum == n;
};