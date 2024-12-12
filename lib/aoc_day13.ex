defmodule AoC.Day13 do
  @moduledoc false

  def part1(input) do
    input
    |> parse()
    |> fold_first()
    |> length
  end

  def part2(input) do
    input
    |> parse()
    |> fold()
    |> print()
  end

  def print(coords) do
    {max_x, max_y} =
      Enum.reduce(coords, {0, 0}, fn
        {x, y}, {x_max, y_max} -> {max(x, x_max), max(y, y_max)}
      end)

    for y <- 0..max_y do
      for x <- 0..max_x do
        if {x, y} in coords, do: ?#, else: ?.
      end
    end
  end

  def fold_first({coords, [op | _ops]}) do
    coords
    |> fold(op)
    |> Enum.uniq()
  end

  def fold({coords, ops}) do
    ops
    |> Enum.reduce(coords, fn coord, acc -> fold(acc, coord) end)
    |> Enum.uniq()
  end

  def fold(coords, {:x, x_pos}) do
    coords
    |> Enum.filter(fn {x, _y} -> x != x_pos end)
    |> Enum.map(fn
      {x, y} when x > x_pos -> {x_pos - (x - x_pos), y}
      {x, y} -> {x, y}
    end)
  end

  def fold(coords, {:y, y_pos}) do
    coords
    |> Enum.filter(fn {_x, y} -> y != y_pos end)
    |> Enum.map(fn
      {x, y} when y > y_pos -> {x, y_pos - (y - y_pos)}
      {x, y} -> {x, y}
    end)
  end

  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce({[], []}, fn line, {coords, ops} ->
      case parse_line(line) do
        {:x, x} -> {coords, ops ++ [{:x, x}]}
        {:y, y} -> {coords, ops ++ [{:y, y}]}
        {x, y} -> {coords ++ [{x, y}], ops}
      end
    end)
  end

  def parse_line("fold along x=" <> x), do: {:x, String.to_integer(x)}
  def parse_line("fold along y=" <> y), do: {:y, String.to_integer(y)}

  def parse_line(coords),
    do: String.split(coords, ",") |> Enum.map(&String.to_integer/1) |> List.to_tuple()
end
