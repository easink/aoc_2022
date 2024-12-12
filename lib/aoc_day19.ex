defmodule AoC.Day19 do
  @moduledoc false

  def part1(input) do
    [coords0 | coords_rest] = parse(input)

    [coords0]
    |> overlap(coords_rest, [])
    |> elem(1)
    |> Enum.concat()
    |> Enum.uniq()
    |> length()
  end

  def part2(input) do
    [coords0 | coords_rest] = parse(input)

    [coords0]
    |> overlap(coords_rest, [])
    |> elem(0)
    |> max_distance(0)
  end

  def max_distance([{x0, y0, z0} | scanners], max) do
    new_max =
      scanners
      |> Enum.reduce(max, fn {xs, ys, zs}, acc ->
        max(acc, abs(x0 - xs) + abs(y0 - ys) + abs(z0 - zs))
      end)

    max_distance(scanners, new_max)
  end

  def max_distance([], max), do: max

  def overlap(founded_coords, [next | unmatched], scanners) do
    founded_coords
    |> Enum.find_value(fn found ->
      find_overlap(found, next)
      |> normalize_coords()
    end)
    |> case do
      nil -> overlap(founded_coords, unmatched ++ [next], scanners)
      {scanner, new} -> overlap([new | founded_coords], unmatched, [scanner | scanners])
    end
  end

  def overlap(found, [], scanners), do: {scanners, found}

  def find_overlap(coords0, coords1) do
    coords1
    |> all_coords()
    |> Enum.find_value(fn coords -> find_direction(coords0, coords) end)
  end

  def find_direction(coords0, coords1) do
    for {x0, y0, z0} <- coords0, {x1, y1, z1} <- coords1 do
      {x0 - x1, y0 - y1, z0 - z1}
    end
    |> Enum.frequencies()
    |> Enum.find(&(elem(&1, 1) >= 12))
    |> then(fn
      nil -> nil
      {diff, _count} -> {diff, coords1}
    end)
  end

  def normalize_coords({{xd, yd, zd} = scanner, coords}) do
    {scanner, Enum.map(coords, fn {x, y, z} -> {x + xd, y + yd, z + zd} end)}
  end

  def normalize_coords(nil), do: nil

  # def overlapping?(coords0, coords1) do
  #   for {x0, y0, z0} <- coords0, {x1, y1, z1} <- coords1 do
  #     {x1 - x0, y1 - y0, z1 - z0}
  #   end
  #   |> Enum.frequencies()
  #   |> IO.inspect(label: "RELATIVE_FILEPATH:52")
  #   |> Enum.find(&(elem(&1, 1) >= 12))
  #   |> IO.inspect(label: "RELATIVE_FILEPATH:57")
  #   |> then(fn
  #     nil -> nil
  #     {diff, _count} -> {diff, coords1} |> IO.inspect(label: :EEE)
  #   end)
  # end

  # def find_coord(coords0, coords1) do
  #   coords1
  #   |> all_coords()
  #   |> Enum.find(fn coords ->
  #     coords0
  #     |> Enum.find(fn {x0, y0, z0} ->
  #       # diffs = coords |> Enum.map(fn {x1, y1, z1} -> {x1 - x0, y1 - y0, z1 - z0} end)
  #       diffs = 
  #     for {x1, y1, z1} <- q1, {x0, y0, z0} <- q2 do                                     
  #       {x1 - x2, y1 - y2, z1 - z2}                                                     
  #     end

  #       diffs
  #       # |> Enum.map(
  #       # |> Enum.frequencies()
  #       |> IO.inspect()
  #     end)
  #   end)
  # end

  # def find_x_offset(coords0, coords1) do
  #   -2000..2000
  #   # [68]
  #   |> Enum.find(fn x_offset ->
  #     coords1
  #     |> all_coords()
  #     |> Enum.any?(fn coords ->
  #       correct_x_offset?(coords0, coords, x_offset)
  #     end)
  #   end)
  # end

  # def find_x_offset_test(coords0, coords1) do
  #   coords1
  #   # |> Enum.with_index()
  #   |> Enum.map(fn {x1, y1, z1} ->
  #     IO.binread(1)

  #     Enum.map(coords0, fn {x0, y0, z0} -> {x1 - x0, y1 - y0, z1 - z0} end)
  #     # |> Enum.frequencies()
  #     |> IO.inspect(label: "RELATIVE_FILEPATH:58")
  #   end)
  # end

  def correct_x_offset?(coords0, coords1, x_offset) do
    xs0 = Enum.map(coords0, fn {x, _y, _z} -> x end)
    xs1 = Enum.map(coords1, fn {x, _y, _z} -> x + x_offset end)

    length(xs0 -- xs0 -- xs1) >= 12
  end

  # [{1,2,3}, {4,5,6}, {7,8,9}]
  def all_coords(coords) do
    coords
    |> Enum.map(&all_rotations/1)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  def all_rotations({x, y, z}) do
    [{x, y, z}, {x, z, -y}, {-z, y, x}, {y, -x, z}, {x, -z, y}, {z, y, -x}, {-y, x, z}, {x, -y, -z}, {y, z, x}, {z, -x, -y}, {-y, z, -x}, {-z, x, -y}, {-x, y, -z}, {-z, -x, y}, {-y, -z, x}, {-x, -y, z}, {y, -z, -x}, {z, x, y}, {z, -y, x}, {-y, -x, -z}, {-z, -y, -x}, {y, x, -z}, {-x, z, y}, {-x, -z, -y}]
  end

  # @rs [
  #   &AoC.Day19.not_rotate/1,
  #   &AoC.Day19.rotate_x_cw/1,
  #   &AoC.Day19.rotate_y_cw/1,
  #   &AoC.Day19.rotate_z_cw/1,
  #   &AoC.Day19.rotate_x_ac/1,
  #   &AoC.Day19.rotate_y_ac/1,
  #   &AoC.Day19.rotate_z_ac/1
  # ]

  # def quadrants(beacons) do
  #   beacons
  #   |> Stream.map(fn beacon ->
  #     for r1 <- @rs, r2 <- @rs, r3 <- @rs do
  #       beacon |> r1.() |> r2.() |> r3.()
  #     end
  #     |> Enum.uniq()
  #   end)
  #   |> Stream.zip()
  #   |> Enum.map(&Tuple.to_list/1)
  # end

  # def directions() do
  #   [{1, 1, 1}, {1, 1, -1}, {1, -1, 1}, {1, -1, -1}, {-1, 1, 1}, {-1, 1, -1}, {-1, -1, 1}, {-1, -1, -1}]
  # end

  # def x_rotate(coord, n), do: Enum.reduce(0..n, coord, fn _n, {x, y, z} -> {x, z, -y} end)
  # def y_rotate(coord, n), do: Enum.reduce(0..n, coord, fn _n, {x, y, z} -> {z, y, -x} end)
  # def z_rotate(coord, n), do: Enum.reduce(0..n, coord, fn _n, {x, y, z} -> {y, -x, z} end)
  # # def z_rotate_flip(coord, n), do: Enum.reduce(0..n, coord, fn _n, {x, y, z} -> {y, -x, -z} end)

  # def x_rotate({x, y, z}), do: {x, -z, y}
  # def y_rotate({x, y, z}), do: {z, y, -x}
  # def z_rotate({x, y, z}), do: {y, -x, z}
  # # def invert({x, y, z}), do: {-x, -y, -z}

  def parse(input) do
    input
    |> String.split()
    |> parse_scanner(0, %{})
    |> Enum.sort()
    |> Enum.map(&elem(&1, 1))
  end

  # def parse_scanner(input, scanner_id \\ 0, scanners \\ %{})

  def parse_scanner([], _scanner_id, scanners), do: scanners

  def parse_scanner(["---", "scanner", id, "---" | rest], _scanner_id, scanners) do
    scanner_id = String.to_integer(id)

    # scanners = Map.put(scanners, scanner_id, [])
    parse_scanner(rest, scanner_id, scanners)
  end

  def parse_scanner([coord | rest], scanner_id, scanners) do
    {x, y, z} =
      coord
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()

    scanners = Map.update(scanners, scanner_id, [{x, y, z}], fn coords -> [{x, y, z} | coords] end)
    parse_scanner(rest, scanner_id, scanners)
  end
end
