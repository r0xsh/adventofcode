defmodule AdventOfCode.Day2 do

  @default_config %{:red => 0, :green => 0, :blue => 0}

  def games(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&game_round/1)
    |> Enum.sum() 
  end

  defp game_round(game) do
    [_, round] = String.split(game, ":", trim: true)

    config_min(round)
    |> Map.values()
    |> Enum.reduce(fn x, acc -> x * acc end)
  end

  defp config_min(sets) do
    sets
    |> String.split([",", ";"])
    |> Enum.reduce(@default_config, fn x, acc -> 
      {color, n} = parse_cube(x)
      Map.update!(acc, color, &(if &1<n, do: n, else: &1))
    end)
  end

  defp parse_cube(cube) do
    [n, color] = cube |> String.trim() |> String.split(" ", trim: true)
    { String.to_atom(color), String.to_integer(n) }
  end

end

case File.read("input") do
  {:ok, file} -> IO.puts AdventOfCode.Day2.games(file)
  {:error, _} -> throw "File not found"
end
