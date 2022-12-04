defmodule AoC.Day01 do
  @moduledoc false

  def part1(filename) do
    filename
    |> parse()
    |> Enum.max()
  end

  def part2(filename) do
    filename
    |> parse()
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.take(3)
    |> Enum.sum()
  end

  defp parse(filename) do
    filename
    |> File.stream!()
    |> Enum.map(&String.trim/1)
    |> Enum.chunk_by(&(&1 == ""))
    |> Enum.reject(&(&1 == [""]))
    |> Enum.map(&Enum.map(&1, fn x -> String.to_integer(x) end))
    |> Enum.map(&Enum.sum/1)
  end
end
