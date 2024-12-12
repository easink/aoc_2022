defmodule AoC.Day25 do
  @moduledoc """
  could speed up if target found in dijkstra_traverse
  """

  def part1(input) do
    input
    |> parse()
    |> steps(0)
  end

  def steps({_max, _east, _south, _emptyset, 0}, n), do: n

  def steps({_max, _east, _south, _emptyset, _changed} = map, n) do
    map
    |> step_east()
    |> step_south()
    |> steps(n + 1)
  end

  def step_east({max, east, south, emptyset, _changed}) do
    old_east =
      east
      |> Enum.filter(fn coord ->
        MapSet.member?(emptyset, next_east_coord(coord, max))
      end)

    new_east = Enum.map(old_east, fn coord -> next_east_coord(coord, max) end)
    updated_east = (east -- old_east) ++ new_east

    changed_emptyset = change_emptyset(emptyset, old_east, new_east)
    {max, updated_east, south, changed_emptyset, length(old_east)}
  end

  def step_south({max, east, south, emptyset, changed}) do
    old_south =
      south
      |> Enum.filter(fn coord ->
        MapSet.member?(emptyset, next_south_coord(coord, max))
      end)

    new_south = Enum.map(old_south, fn coord -> next_south_coord(coord, max) end)
    updated_south = (south -- old_south) ++ new_south

    changed_emptyset = change_emptyset(emptyset, old_south, new_south)
    {max, east, updated_south, changed_emptyset, changed + length(old_south)}
  end

  def change_emptyset(emptyset, add_list, del_list) do
    add_set = MapSet.new(add_list)
    del_set = MapSet.new(del_list)

    emptyset
    |> MapSet.difference(del_set)
    |> MapSet.union(add_set)
  end

  def parse(input) do
    input
    |> String.split()
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {x_line, y_index}, acc ->
      x_line
      |> String.to_charlist()
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {value, x_index}, x_acc ->
        Map.put(x_acc, {x_index, y_index}, value)
      end)
    end)
    |> parse_max()
  end

  def parse_max(input) do
    {xmax, ymax} =
      input
      |> Map.keys()
      |> Enum.max()

    max = {xmax + 1, ymax + 1}

    east =
      input
      |> Enum.filter(fn {_coord, val} -> val == ?> end)
      |> Enum.map(&elem(&1, 0))

    south =
      input
      |> Enum.filter(fn {_coord, val} -> val == ?v end)
      |> Enum.map(&elem(&1, 0))

    emptyset =
      input
      |> Enum.filter(fn {_coord, val} -> val == ?. end)
      |> Enum.map(&elem(&1, 0))
      |> MapSet.new()

    {max, east, south, emptyset, nil}
  end

  def next_east_coord({x, y}, {xmax, _ymax}), do: {rem(x + 1, xmax), y}
  def next_south_coord({x, y}, {_xmax, ymax}), do: {x, rem(y + 1, ymax)}
end
