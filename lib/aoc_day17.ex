defmodule AoC.Day17 do
  @moduledoc false

  def part1(input) do
    input
    |> parse()
    |> trajectory()
    |> Enum.max_by(fn {:hit, max_y, _velocity} -> max_y end)
    |> elem(1)
  end

  def part2(input) do
    input
    |> parse()
    |> trajectory()
    |> Enum.map(fn {:hit, _max_y, velocity} -> velocity end)
    |> length
  end

  def trajectory({{_xs, xe}, {ys, _ye}} = target) do
    for(y <- 150..ys, x <- 0..xe, do: {x, y})
    |> Enum.map(fn velocity -> trajectory(target, velocity, velocity, velocity, 0) end)
    |> Enum.filter(fn hit -> match?({:hit, _max_y, _velocity}, hit) end)
  end

  def trajectory({{xs, xe}, {ys, ye}} = _target, {x, y} = _position, _velocity, start_velocity, max_y)
      when x >= xs and x <= xe and y >= ys and y <= ye do
    {:hit, max_y, start_velocity}
  end

  def trajectory({{_xs, xe}, {ys, _ye}} = _target, {x, y} = _position, _velocity, _start_velocity, _max_y)
      when x > xe or y < ys,
      do: :miss

  def trajectory(target, position, velocity, start_velocity, max_y) do
    velocity = next_velocity(velocity)
    {_x, y} = position = next_position(position, velocity)

    trajectory(target, position, velocity, start_velocity, max(y, max_y))
  end

  def next_velocity({x, y}), do: {max(0, x - 1), y - 1}
  def next_position({x, y}, {xd, yd}), do: {x + xd, y + yd}

  def parse("target area: " <> target_area) do
    [x_range, y_range] = String.split(target_area, ", ")
    x_range = parse_range(x_range)
    y_range = parse_range(y_range)

    {x_range, y_range}
  end

  def parse_range(input) do
    [_axis, range] = String.split(input, "=")
    [from, to] = String.split(range, "..")
    {String.to_integer(from), String.to_integer(to)}
  end
end
