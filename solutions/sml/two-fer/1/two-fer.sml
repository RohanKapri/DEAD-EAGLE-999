fun name (who: string option): string =
  let val moniker = getOpt (who, "you")
  in  "One for " ^ moniker ^ ", one for me."
  end
