defmodule Rucksack do
  def parse_input(input) do
    Enum.chunk(input, 2)
    |> Enum.map(&String.graphemes/1)
  end

  def find_common_items(rucksacks) do
    Enum.reduce(rucksacks, hd(rucksacks), &find_common_items_in_rucksack/2)
  end

  def find_common_items_in_rucksack(rucksack, common_items) do
    Enum.filter(rucksack, &Enum.member?(common_items, &1))
    |> Enum.uniq()
  end

  def calculate_priorities(common_items) do
    Enum.map(common_items, &calculate_priority/1)
    |> Enum.sum()
  end

  def calculate_priority(item) do
    if String.downcase?(item) do
      String.to_charlist(item) |> hd() |> (&(&1 - ?a + 1))
    else
      String.to_charlist(item) |> hd() |> (&(&1 - ?A + 27))
    end
  end

  def solve_part_one(input) do
    rucksacks = parse_input(input)
    common_items = find_common_items(rucksacks)
    calculate_priorities(common_items)
  end

  def group_rucksacks(input) do
    Enum.chunk(input, 3)
    |> Enum.map(&parse_input/1)
  end

  def find_badge_items(groups) do
    Enum.map(groups, &find_common_items/1)
  end

  def solve_part_two(input) do
    groups = group_rucksacks(input)
    badge_items = find_badge_items(groups)
    calculate_priorities(badge_items)
  end
end

{:ok, input} = File.read("input")
IO.puts(Rucksack.solve_part_one(input))
IO.puts(Rucksack.solve_part_two(input))
