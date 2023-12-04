defmodule Calorie do
  def fattest_elf(list) do
    list
    |> split_groups()
    |> Enum.map(&Enum.sum(&1))
    |> Enum.max()
  end

  def total_calories(list) do
    list
    |> split_groups()
    |> Enum.map(&Enum.sum(&1))
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.sum()
  end

  defp split_groups([], [], acc), do: acc
  defp split_groups(list), do: split_groups(String.split(list, "\n"), [], [])

  defp split_groups([head | tail], group, acc) do
    case Integer.parse(head) do
      {x, _} -> split_groups(tail, [x | group], acc)
      _ -> split_groups(tail, [], [group | acc])
    end
  end
end

{:ok, file} = File.read("input")
IO.puts(Calorie.fattest_elf(file))
IO.puts(Calorie.total_calories(file))
