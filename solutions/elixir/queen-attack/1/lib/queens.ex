defmodule Queens do
  @type t :: %Queens{black: {integer, integer}, white: {integer, integer}}
  defstruct [:white, :black]

  @indices 0..7

  @doc """
  Creates a new set of Queens
  """
  @spec new(Keyword.t()) :: Queens.t()
  def new(opts),
    do:
      with(
        true <- (Enum.all?(Keyword.keys(opts), &( &1 in [:black, :white])) || raise ArgumentError),
        true <- (opts[:black] != opts[:white] || raise ArgumentError),
        do: %Queens{} |> set_opt_pos(opts, :black) |> set_opt_pos(opts, :white))

  defp set_opt_pos(q, opts, color), do: (case opts[color] do
        nil -> q
        {r,c} = pos when r in @indices and c in @indices -> q |> Map.put(color, pos)
        _ -> raise ArgumentError
    end)

  @doc """
  Gives a string representation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens),
    do:
      with(
        black = queens.black,
        white = queens.white,
        do: Enum. join( for(r <- @indices, do:
              Enum.join( for(c <- @indices, do: (case {r,c} do
                            ^black -> "B"
                            ^white -> "W"
                            _ -> "_"
                          end)), " ")), "\n"))

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(%Queens{black: {r, _}, white: {r,_}}), do: true
  def can_attack?(%Queens{black: {_, c}, white: {_,c}}), do: true
  def can_attack?(%Queens{black: {rb, cb}, white: {rw, cw}}), do: abs(rw-rb)==abs(cw-cb)
  def can_attack?(_), do: false

end