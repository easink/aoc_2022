defmodule AoC.Day09 do
  @moduledoc false

  def part1(filename) do
    tails = [{0, 0}]

    filename
    |> parse()
    |> walk_head({0, 0}, tails, [{0, 0}])
    |> length()
  end

  def part2(filename) do
    tails = for _n <- 0..8, do: {0, 0}

    filename
    |> parse()
    |> walk_head({0, 0}, tails, [{0, 0}])
    |> length()
  end

  # defp print(head, tails) do
  #   knots = [head | tails]

  #   for y <- 20..-20 do
  #     for x <- -20..20 do
  #       if {x, y} in knots,
  #         do: IO.write("*"),
  #         else: IO.write(" ")
  #     end

  #     IO.write("\n")
  #   end
  # end

  defp walk_head([], _head, _tails, pos), do: pos |> Enum.uniq()

  defp walk_head([{_dir, 0} | input], head, tails, pos) do
    walk_head(input, head, tails, pos)
  end

  defp walk_head([{dir, n} | input], {hx, hy} = _head, tails, pos) do
    # print(head, tails)
    # IO.read(:line)

    input = [{dir, n - 1} | input]

    case dir do
      :u -> walk_tails(input, {hx, hy + 1}, tails, pos)
      :d -> walk_tails(input, {hx, hy - 1}, tails, pos)
      :l -> walk_tails(input, {hx - 1, hy}, tails, pos)
      :r -> walk_tails(input, {hx + 1, hy}, tails, pos)
    end
  end

  defp walk_tails(input, head, tails, pos) do
    {last_tail, new_tails} =
      Enum.reduce(tails, {head, []}, fn tail, {head, tails} ->
        new_tail = walk_tail(head, tail)
        {new_tail, [new_tail | tails]}
      end)

    new_pos = if last_tail in pos, do: pos, else: [last_tail | pos]

    walk_head(input, head, Enum.reverse(new_tails), new_pos)
  end

  defp walk_tail({hx, hy} = _head, {tx, ty} = tail) do
    diff_x = hx - tx
    diff_y = hy - ty
    dir_x = if diff_x == 0, do: 0, else: div(diff_x, abs(diff_x))
    dir_y = if diff_y == 0, do: 0, else: div(diff_y, abs(diff_y))

    cond do
      abs(diff_x) + abs(diff_y) > 2 -> {tx + dir_x, ty + dir_y}
      abs(diff_x) == 2 -> {tx + dir_x, ty}
      abs(diff_y) == 2 -> {tx, ty + dir_y}
      true -> tail
    end
  end

  defp parse(filename) do
    filename
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.split(&1, " ", trim: true))
    |> Stream.map(fn [dir, n] ->
      {String.to_atom(String.downcase(dir)), String.to_integer(n)}
    end)
    |> Enum.to_list()
  end
end
