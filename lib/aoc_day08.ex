defmodule AoC.Day08 do
  @moduledoc false

  def part1(filename) do
    filename
    |> parse()
    |> find_visible_trees()
  end

  def part2(filename) do
    filename
    |> parse()
    |> tree_view()
  end

  defp tree_view(map) do
    {xmax, ymax} = get_size(map)

    for x <- 1..(xmax - 1), y <- 1..(ymax - 1) do
      tree_sight(map, x, xmax, y, ymax)
    end
    |> Enum.max()
  end

  defp tree_sight(map, x, xmax, y, ymax) do
    [
      find_sight_x(map, (x - 1)..0, x, y),
      find_sight_x(map, (x + 1)..xmax, x, y),
      find_sight_y(map, (y - 1)..0, x, y),
      find_sight_y(map, (y + 1)..ymax, x, y)
    ]
    |> Enum.product()
  end

  defp find_sight_y(map, yrange, x, y) do
    start = map[{x, y}]

    Enum.reduce_while(yrange, 0, fn y, n ->
      if start <= map[{x, y}], do: {:halt, n + 1}, else: {:cont, n + 1}
    end)
  end

  defp find_sight_x(map, xrange, x, y) do
    start = map[{x, y}]

    Enum.reduce_while(xrange, 0, fn x, n ->
      if start <= map[{x, y}], do: {:halt, n + 1}, else: {:cont, n + 1}
    end)
  end

  defp find_visible_trees(map) do
    {xmax, ymax} = get_size(map)

    [
      find_visible_x(map, 0..xmax, 0..ymax),
      find_visible_x(map, xmax..0, 0..ymax),
      find_visible_y(map, 0..xmax, 0..ymax),
      find_visible_y(map, 0..xmax, ymax..0)
    ]
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.count()
  end

  defp find_visible_y(map, xrange, yrange) do
    Enum.map(xrange, fn x ->
      Enum.reduce(yrange, {-1, []}, fn y, {max, trees} ->
        a = map[{x, y}]
        if a > max, do: {a, [{x, y} | trees]}, else: {max, trees}
      end)
      |> elem(1)
    end)
  end

  defp find_visible_x(map, xrange, yrange) do
    Enum.map(yrange, fn y ->
      Enum.reduce(xrange, {-1, []}, fn x, {max, trees} ->
        a = map[{x, y}]

        if a > max, do: {a, [{x, y} | trees]}, else: {max, trees}
      end)
      |> elem(1)
    end)
  end

  defp parse(filename) do
    filename
    |> File.stream!()
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {x_line, y_index}, acc ->
      x_line
      |> String.trim()
      |> String.split("", trim: true)
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {value, x_index}, x_acc ->
        Map.put(x_acc, {x_index, y_index}, String.to_integer(value))
      end)
    end)
  end

  defp get_size(map) do
    map
    |> Map.keys()
    |> Enum.reduce({0, 0}, fn {x, y}, {xmax, ymax} ->
      {max(xmax, x), max(ymax, y)}
    end)
  end
end
