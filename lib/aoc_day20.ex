defmodule AoC.Day20 do
  @moduledoc false

  def part1(input) do
    {enhancement, image} = parse(input)

    enhance_steps(enhancement, image, 2)
  end

  def part2(input) do
    {enhancement, image} = parse(input)

    enhance_steps(enhancement, image, 50)
  end

  def enhance_steps(enhancement, image, steps) do
    fill =
      if elem(enhancement, 0) == 1 and elem(enhancement, 511) == 0,
        do: fn step -> rem(step, 2) end,
        else: fn _step -> 0 end

    0..(steps - 1)
    |> Enum.reduce(image, fn step, acc -> enhance_image(acc, enhancement, fill.(step)) end)
    |> Enum.count(fn {_k, v} -> v == 1 end)
  end

  def enhance_image(image, enhancement, fill) do
    image
    |> bounding_box()
    |> enhancing_image(enhancement, fill)
  end

  def enhancing_image({{xmin, xmax}, {ymin, ymax}, image}, enhancement, fill) do
    for(y <- ymin..ymax, x <- xmin..xmax, do: {x, y})
    |> Enum.reduce(%{}, fn pos, acc ->
      idx = enchance_pixel(image, pos, fill)

      Map.put(acc, pos, elem(enhancement, idx))
    end)
  end

  def enchance_pixel(image, {x, y} = _pos, fill) do
    for(yd <- -1..1, xd <- -1..1, do: Map.get(image, {x + xd, y + yd}, fill))
    |> Integer.undigits(2)
  end

  def bounding_box(image) do
    coords = Map.keys(image)
    x_coords = Enum.map(coords, fn {x, _y} -> x end)
    y_coords = Enum.map(coords, fn {_x, y} -> y end)
    {xmin, xmax} = Enum.min_max(x_coords)
    {ymin, ymax} = Enum.min_max(y_coords)

    {{xmin - 1, xmax + 1}, {ymin - 1, ymax + 1}, image}
  end

  def print(image) do
    image
    |> bounding_box()
    |> print_box()
  end

  def print_box({{xmin, xmax}, {ymin, ymax}, image}) do
    for y <- ymin..ymax do
      for x <- xmin..xmax do
        if Map.get(image, {x, y}) == 1,
          do: IO.write("#"),
          else: IO.write(" ")
      end

      IO.write("\n")
    end
  end

  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&to_charlist/1)
    |> parser()
  end

  def parser([enhancement | image]) do
    enhancement = Enum.map(enhancement, fn c -> if c == ?#, do: 1, else: 0 end)
    parser(%{}, Enum.with_index(image), List.to_tuple(enhancement))
  end

  def parser(coords, [], enhancement), do: {enhancement, coords}

  def parser(coords, [{line, y} | image], enhancement) do
    line
    |> Enum.with_index()
    |> Enum.reduce(coords, fn {char, x}, acc ->
      Map.put(acc, {x, y}, if(char == ?#, do: 1, else: 0))
    end)
    |> parser(image, enhancement)
  end
end
