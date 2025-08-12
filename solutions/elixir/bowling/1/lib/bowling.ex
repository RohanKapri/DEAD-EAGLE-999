defmodule Bowling do
  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """

  @type strike :: 10
  @type throw :: 0..10
  @type frame :: strike() | {throw(), throw()}
  @type ongoing_frame :: nil | {throw(), nil}
  @type last_frame ::
          ongoing_frame() | frame() | {strike(), strike(), strike()} | {strike(), throw()}
  @type game_state :: %{
          throws: [throw()]
        }

  @spec start() :: game_state()
  def start do
    %{throws: []}
  end

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful error tuple.
  """

  @spec roll(game_state(), integer) :: {:ok, game_state()} | {:error, String.t()}
  def roll(
        _,
        roll
      )
      when roll > 10 do
    {:error, "Pin count exceeds pins on the lane"}
  end

  def roll(
        _,
        roll
      )
      when roll < 0 do
    {:error, "Negative roll is invalid"}
  end

  def roll(
        %{throws: throws},
        roll
      ) do
    case score_inner(0, 0, Enum.reverse(throws)) do
      {:ongoing, pins} when pins >= roll -> {:ok, %{throws: [roll | throws]}}
      {:ongoing, pins} -> {:error, "Pin count exceeds pins on the lane"}
      {:ok, _} -> {:error, "Cannot roll after game is over"}
    end
  end

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful error tuple.
  """

  @spec score(game_state()) :: {:ok, integer} | {:error, String.t()}
  def score(game) do
    case score_inner(0, 0, Enum.reverse(game[:throws])) do
      {:ongoing, _} -> {:error, "Score cannot be taken until the end of the game"}
      any -> any
    end
  end

  defp score_inner(acc_score, acc_frames, throws) when acc_frames < 9 do
    case throws do
      [10, y, z | rest] ->
        score_inner(acc_score + 10 + y + z, acc_frames + 1, [y, z | rest])

      [x, y, z | rest] when x + y == 10 ->
        score_inner(acc_score + 10 + z, acc_frames + 1, [z | rest])

      [x, y | rest] ->
        score_inner(acc_score + x + y, acc_frames + 1, rest)

      [10] ->
        {:ongoing, 10}

      [x] ->
        {:ongoing, 10 - x}

      [] ->
        {:ongoing, 10}
    end
  end

  defp score_inner(acc_score, acc_frames, throws) when acc_frames == 9 do
    case throws do
      [10, y, z] ->
        {:ok, acc_score + 10 + y + z}

      [10, 10] ->
        {:ongoing, 10}

      [10, y] ->
        {:ongoing, 10 - y}

      [10] ->
        {:ongoing, 10}

      [x, y, z] when x + y == 10 ->
        {:ok, acc_score + 10 + z}

      [x, y] when x + y == 10 ->
        {:ongoing, 10}

      [x, y] ->
        {:ok, acc_score + x + y}

      [x] ->
        {:ongoing, 10 - x}

      [] ->
        {:ongoing, 10}
    end
  end
end