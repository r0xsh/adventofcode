defmodule AdventOfCode.Day1 do
  
  def calibrate(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&calibration_value/1)
    |> Enum.sum()
  end

  def calibration_value(line) do
    # See: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Regular_expressions/Lookahead_assertion 
    Regex.scan(~r/(?=(?<digit>[1-9]|one|two|three|four|five|six|seven|eight|nine){1})/, line)
    |> Enum.map(&Enum.at(&1, 1))
    |> List.flatten()
    |> calibration_sum()
end
  
  defp calibration_sum(charlist) do
    [first | _rest] = charlist
    last = Enum.at(charlist, -1)

    case {first, last} do
      {nil, nil} -> throw("Empty charlist")
      {first, last} -> charval(first) * 10 + charval(last) 
    end
  end


  defp charval("one") do 1 end
  defp charval("two") do 2 end
  defp charval("three") do 3 end
  defp charval("four") do 4 end
  defp charval("five") do 5 end
  defp charval("six") do 6 end
  defp charval("seven") do 7 end
  defp charval("eight") do 8 end
  defp charval("nine") do 9 end
  defp charval(value) when byte_size(value) == 1 do
    case Integer.parse(value) do
      {val, ""} -> val
      _ -> throw("Malformed number")
    end
  end

end

{:ok, file} = File.read("input")
IO.puts AdventOfCode.Day1.calibrate(file)
