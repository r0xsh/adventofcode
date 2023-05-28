## Opponent
# Rock(A) = 1
# Paper(B) = 2
# Scissors(C) = 3
## Me
# Rock(X) = 1
# Paper(Y) = 2
# Scissors(Z) = 3

# X = lose
# Y = draw
# Z = win

# Win = 6
# Draw = 3
# Lose = 0

defmodule Rochambeau do


  def parse(buffer) do
    buffer
    |> String.split("\n", trim: true)
    |> Enum.map(&(tour(&1)))
    |> Enum.sum()
  end

  defp tour(buffer) do
    [a, b] = String.split(buffer, " ")
    case {parse_move(a), b} do
      {1, "X"} -> 3
      {3, "Z"} -> 7
      {ma, "X"} -> ma - 1
      {ma, "Z"} -> ma + 1 + 6
      {ma, "Y"} -> ma + 3
    end
  end

  defp parse_move(move) do
    case move do
      "A" -> 1
      "B" -> 2
      "C" -> 3
    end
  end

end

{:ok, file} = File.read("input")
IO.puts(Rochambeau.parse(file))
