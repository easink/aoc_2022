defmodule AoC.Day22 do
  @moduledoc false

  def part1(input) do
    input
    |> parse()
    |> naive_reboot()
    |> MapSet.size()
  end

  def part2(input) do
    input
    |> parse()
    |> reboot()
  end

  def reboot(cubes) do
    cubes
    |> reboot([])
    |> calc_cubes()
  end

  def calc_cubes(cuboid) do
    cuboid
    |> Enum.reduce(0, fn {{xa, xb}, {ya, yb}, {za, zb}}, acc ->
      acc + (xb - xa + 1) * (yb - ya + 1) * (zb - za + 1)
    end)
  end

  def reboot([], cuboid), do: cuboid

  def reboot([{on_off, cube} | cubes], cuboid) do
    cuboid
    |> split_colliding(cube)
    |> handle_collided(cube)
    |> apply_cubes(on_off, cubes, cube)
  end

  def apply_cubes(non_collided, "on", cubes, cube),
    do: reboot(cubes, [cube | non_collided])

  def apply_cubes(non_collided, "off", cubes, _cube),
    do: reboot(cubes, non_collided)

  def handle_collided({collided, non_collided}, cube),
    do: handle_collided(collided, non_collided, cube)

  def handle_collided([], non_collided, _cube), do: non_collided

  def handle_collided([collided_cube | collided], non_collided, cube) do
    if within?(cube, collided_cube) do
      # remove whole cube
      handle_collided(collided, non_collided, cube)
    else
      updated_non_collided = split_cube(collided_cube, cube) ++ non_collided
      handle_collided(collided, updated_non_collided, cube)
    end
  end

  def split_cube(cube1, cube2) do
    {
      {c1_x_a, c1_x_b} = c1_x,
      {c1_y_a, c1_y_b} = c1_y,
      {c1_z_a, c1_z_b} = c1_z
    } = cube1

    {
      {c2_x_a, c2_x_b},
      {c2_y_a, c2_y_b},
      {c2_z_a, c2_z_b}
    } = cube2

    c2_x = {max(c1_x_a, c2_x_a), min(c1_x_b, c2_x_b)}
    c2_y = {max(c1_y_a, c2_y_a), min(c1_y_b, c2_y_b)}
    c2_z = {max(c1_z_a, c2_z_a), min(c1_z_b, c2_z_b)}

    x_ranges = range_split(c1_x, c2_x)
    y_ranges = range_split(c1_y, c2_y)
    z_ranges = range_split(c1_z, c2_z)

    for x <- x_ranges,
        y <- y_ranges,
        z <- z_ranges,
        {x, y, z} != {c2_x, c2_y, c2_z},
        do: {x, y, z}
  end

  def range_split({r1a, r1b}, {r2a, r2b}) do
    [{r2a, r2b}] |> add_if_pos(r1a, r2a - 1) |> add_if_pos(r2b + 1, r1b)
  end

  def add_if_pos(lst, a, b) when b - a >= 0, do: [{a, b} | lst]
  def add_if_pos(lst, _a, _b), do: lst

  def within?(cube1, cube2) do
    {{c1_x_a, c1_x_b}, {c1_y_a, c1_y_b}, {c1_z_a, c1_z_b}} = cube1
    {{c2_x_a, c2_x_b}, {c2_y_a, c2_y_b}, {c2_z_a, c2_z_b}} = cube2

    c2_x_a >= c1_x_a and c2_x_b <= c1_x_b and
      c2_y_a >= c1_y_a and c2_y_b <= c1_y_b and
      c2_z_a >= c1_z_a and c2_z_b <= c1_z_b
  end

  def collide?(cube1, cube2) do
    {{c1_x_a, c1_x_b}, {c1_y_a, c1_y_b}, {c1_z_a, c1_z_b}} = cube1
    {{c2_x_a, c2_x_b}, {c2_y_a, c2_y_b}, {c2_z_a, c2_z_b}} = cube2

    not Range.disjoint?(c1_x_a..c1_x_b, c2_x_a..c2_x_b) and
      not Range.disjoint?(c1_y_a..c1_y_b, c2_y_a..c2_y_b) and
      not Range.disjoint?(c1_z_a..c1_z_b, c2_z_a..c2_z_b)
  end

  def split_colliding(cubes, cube) do
    Enum.split_with(cubes, fn c -> collide?(c, cube) end)
  end

  ### naive

  def naive_reboot(cuboid_specs) do
    naive_reboot(MapSet.new(), cuboid_specs)
  end

  def naive_reboot(cuboid, []), do: cuboid

  def naive_reboot(cuboid, [{on_off, cube} | cubes]) do
    cube
    |> naive_cubes()
    |> naive_apply_cubes(on_off, cuboid)
    |> naive_reboot(cubes)
  end

  def naive_apply_cubes(cubes, "on", cuboid), do: MapSet.union(cuboid, cubes)
  def naive_apply_cubes(cubes, "off", cuboid), do: MapSet.difference(cuboid, cubes)

  def naive_cubes(cube) do
    {{x_a, x_b}, {y_a, y_b}, {z_a, z_b}} = cube

    xs = Enum.filter(x_a..x_b, fn x -> x >= -50 and x <= 50 end)
    ys = Enum.filter(y_a..y_b, fn y -> y >= -50 and y <= 50 end)
    zs = Enum.filter(z_a..z_b, fn z -> z >= -50 and z <= 50 end)

    for(x <- xs, y <- ys, z <- zs, do: {x, y, z})
    |> MapSet.new()
  end

  ### parse

  def parse(input) do
    input
    |> String.split()
    |> parser([])
  end

  def parser([], cuboid), do: Enum.reverse(cuboid)

  def parser([on_off, cube | rest], cuboid) do
    parser(rest, [{on_off, parse_cube(cube)} | cuboid])
  end

  def parse_cube(input) do
    input
    |> String.split(",")
    |> Enum.map(&parse_range/1)
    |> List.to_tuple()
  end

  def parse_range(input) do
    [_axis, range] = input |> String.split("=")

    range
    |> String.split("..")
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end
end
