## Opponent
# Rock(A) = 1
# Paper(B) = 2
# Scissors(C) = 3
## Me
# Rock(X) = 1
# Paper(Y) = 2
# Scissors(Z) = 3

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
    case {parse_move(a), parse_move(b)} do
      {1, 3} -> 3
      {3, 1} -> 7
      {ma, mb} when ma > mb -> mb
      {ma, mb} when ma < mb -> mb + 6
      {ma, mb} when ma == mb -> mb + 3
    end
  end

  defp parse_move(move) do
    cond do
      move in ["A", "X"] -> 1
      move in ["B", "Y"] -> 2
      move in ["C", "Z"] -> 3
    end
  end

end

{:ok, file} = File.read("input")
IO.puts(Rochambeau.parse(file))
