defmodule AdventOfCode.Day1 do
  
  def calibrate(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&calibration_value/1)
    |> Enum.sum()
  end

  def calibration_value(line) do
    String.to_charlist(line)
    |> Enum.filter(fn char -> char in ?0..?9 end)
    |> calibration_sum
  end
  
  defp calibration_sum(charlist) do
    [first | _rest] = charlist
    last = Enum.at(charlist, -1)

    case {first, last} do
      {nil, nil} -> throw("Empty charlist")
      {first, last} -> (first - 48) * 10 + (last - 48)
    end
  end

end

{:ok, file} = File.read("input")
IO.puts AdventOfCode.Day1.calibrate(file)
