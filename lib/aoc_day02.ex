defmodule AoC.Day02 do
  @moduledoc false

  def part1(filename) do
    filename
    |> parse()
    |> Enum.map(&calc_round/1)
    |> Enum.sum()
  end

  def part2(filename) do
    filename
    |> parse()
    |> Enum.map(fn round ->
      round
      |> correction()
      |> calc_round()
    end)
    |> Enum.sum()
  end

  defp calc_round(["A", "X"]), do: 1 + 3
  defp calc_round(["A", "Y"]), do: 2 + 6
  defp calc_round(["A", "Z"]), do: 3 + 0
  defp calc_round(["B", "X"]), do: 1 + 0
  defp calc_round(["B", "Y"]), do: 2 + 3
  defp calc_round(["B", "Z"]), do: 3 + 6
  defp calc_round(["C", "X"]), do: 1 + 6
  defp calc_round(["C", "Y"]), do: 2 + 0
  defp calc_round(["C", "Z"]), do: 3 + 3

  defp correction(["A", "X"]), do: ["A", "Z"]
  defp correction(["A", "Y"]), do: ["A", "X"]
  defp correction(["A", "Z"]), do: ["A", "Y"]
  defp correction(["B", "X"]), do: ["B", "X"]
  defp correction(["B", "Y"]), do: ["B", "Y"]
  defp correction(["B", "Z"]), do: ["B", "Z"]
  defp correction(["C", "X"]), do: ["C", "Y"]
  defp correction(["C", "Y"]), do: ["C", "Z"]
  defp correction(["C", "Z"]), do: ["C", "X"]

  defp parse(filename) do
    filename
    |> File.stream!()
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.split(&1, " "))
  end
end
