defmodule Username do
  def sanitize([]), do: []

  def sanitize([h | t]) do
    case h do
      h when h in ?a..?z or h == ?_ -> [h]
      ?ä -> 'ae'
      ?ö -> 'oe'
      ?ü -> 'ue'
      ?ß -> 'ss'
      _ -> ''
    end
    |> Kernel.++(sanitize(t))
  end
end