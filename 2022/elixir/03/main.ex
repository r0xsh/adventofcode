defmodule Rucksack do
  def parse(buffer) do
    buffer
    |> String.split("\n", trim: true)
    |> Enum.map(&backpack(&1))
    |> Enum.sum()
  end

  defp backpack(content) do
    length = String.length(content)

    {comp1, comp2} =
      content
      |> String.split_at(trunc(length / 2))
      |> parse_items()

    comp1
    |> Enum.filter(&(&1 in comp2))
    |> List.first()
    |> score()
  end

  defp parse_items({comp1, comp2}), do: {parse_items(comp1), parse_items(comp2)}

  defp parse_items(comp) do
    comp
    |> String.codepoints()
    |> Enum.uniq()
  end

  defp score(item) do
    char = :binary.first(item)

    cond do
      ?a <= char && char <= ?z -> char - 96
      ?A <= char && char <= ?Z -> char - 38
    end
  end

  def group(buffer) do
    buffer
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_items(&1))
    |> Enum.chunk_every(3)
    |> Enum.map(fn group ->
      result =
        group
        |> List.flatten()
        |> Enum.sort()
        |> group_score()
        |> dbg()

      if length(result) == 3 do
        score(List.first(result))
      else
        0
      end
    end)
    |> Enum.sum()
  end

  defp group_score([a, b, c]), do: a == b && a == c

  defp group_score(list) when length(list) >= 3 do
    list
    |> Enum.chunk_every(3)
    |> Enum.filter(&group_score(&1))
    |> List.flatten()
  end

  defp group_score(_), do: false
end

{:ok, file} = File.read("input")
IO.puts(Rucksack.group(file))
