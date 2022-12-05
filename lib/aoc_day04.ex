defmodule AoC.Day04 do
  @moduledoc false

  def part1(filename) do
    filename
    |> parse()
    |> Enum.filter(fn {a, b} -> a -- b == [] || b -- a == [] end)
    |> length()
  end

  def part2(filename) do
    filename
    |> parse()
    |> Enum.filter(fn {a, b} -> a -- b != a end)
    |> length()
  end

  defp parse(filename) do
    filename
    |> File.stream!()
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.split(&1, ","))
    |> Enum.map(fn [a, b] ->
      {to_list(a), to_list(b)}
    end)
  end

  defp to_list(str) do
    [a, b] = String.split(str, "-")

    Range.new(String.to_integer(a), String.to_integer(b))
    |> Enum.to_list()
  end
end
