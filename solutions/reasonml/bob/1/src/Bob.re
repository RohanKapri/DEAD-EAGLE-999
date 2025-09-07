let isSilence = (q: string) => q == "";
let isQuestion = (q: string) => q != "" && q.[String.length(q) - 1] == '?';
let isShouting = (q: string) =>
  Js.Re.test_([%re "/[a-zA-Z]/"], q) && String.uppercase_ascii(q) == q;

let hey = (q: string): string => {
  let q = Js.String.replaceByRe([%re "/\\s/g"], "", q);

  switch (isSilence(q), isQuestion(q), isShouting(q)) {
  | (true, _, _) => "Fine. Be that way!"
  | (_, true, false) => "Sure."
  | (_, true, true) => "Calm down, I know what I'm doing!"
  | (_, false, true) => "Whoa, chill out!"
  | _ => "Whatever."
  };
};