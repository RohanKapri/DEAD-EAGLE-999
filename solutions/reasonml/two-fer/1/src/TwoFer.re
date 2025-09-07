let twoFer = (name: option(string)) =>
  switch (name) {
  | Some(name) => "One for " ++ name ++ ", one for me."
  | _ => "One for you, one for me."
  };