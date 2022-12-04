defmodule AoC.Day03 do
  @moduledoc false

  def part1(filename) do
    filename
    |> parse()
    |> Enum.map(&parse_compartments/1)
    |> Enum.map(&share_items/1)
    |> Enum.map(&char_to_int/1)
    |> Enum.sum()
  end

  def part2(filename) do
    filename
    |> parse()
    |> Enum.chunk_every(3)
    |> Enum.map(&share_items/1)
    |> Enum.map(&char_to_int/1)
    |> Enum.sum()
  end

  defp parse(filename) do
    filename
    |> File.stream!()
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_charlist/1)
  end

  defp parse_compartments(line) do
    n_items = length(line)

    Enum.chunk_every(line, div(n_items, 2))
  end

  defp share_items([a, b]) do
    a = MapSet.new(a)
    b = MapSet.new(b)

    [x] = MapSet.intersection(a, b) |> MapSet.to_list()
    x
  end

  defp share_items([a, b, c]) do
    a = MapSet.new(a)
    b = MapSet.new(b)
    c = MapSet.new(c)

    [x] =
      a
      |> MapSet.intersection(b)
      |> MapSet.intersection(c)
      |> MapSet.to_list()

    x
  end

  defp char_to_int(a) when a in ?a..?z, do: a - ?a + 1
  defp char_to_int(a) when a in ?A..?Z, do: a - ?A + 27
end
