defmodule AdventOfCode.Day2 do

  @config %{:red => 12, :green => 13, :blue => 14}

  def games(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&game_round/1)
    |> Enum.sum() 
  end

  defp game_round(game) do
    [<<"Game "::binary, gid::binary>>, round] = String.split(game, ":", trim: true)

    case game_possible?(round) do
      true -> String.to_integer(gid) 
      false -> 0
    end
  end

  defp game_possible?(sets) do
    sets
    |> String.split([",", ";"])
    |> Enum.any?(&exceed_config?/1)
    |> Kernel.not()
  end

  defp exceed_config?(cubes) do
    [n, color] = cubes |> String.trim() |> String.split(" ", trim: true)
    Map.get(@config, String.to_atom(color)) < n |> String.to_integer()
  end

end

case File.read("input") do
  {:ok, file} -> IO.puts AdventOfCode.Day2.games(file)
  {:error, _} -> throw "File not found"
end
