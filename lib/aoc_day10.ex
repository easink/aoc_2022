defmodule AoC.Day10 do
  @moduledoc false

  def part1(filename) do
    filename
    |> parse()
    |> process(1, 1, &signal_strength/3, [])
    |> Enum.sum()
  end

  def part2(filename) do
    filename
    |> parse()
    |> process(1, 0, &print_crt/3, [])
    |> Enum.reverse()
    |> Enum.chunk_every(40)
  end

  defp process([], _x, _cycle, _fun, acc), do: acc

  defp process([op | input], x, cycle, fun, acc) do
    acc = fun.(x, cycle, acc)

    {input, x} =
      case op do
        :noop -> {input, x}
        {:addx, 1, val} -> {input, x + val}
        {:addx, 2, val} -> {[{:addx, 1, val} | input], x}
      end

    process(input, x, cycle + 1, fun, acc)
  end

  defp signal_strength(x, cycle, strengths) do
    if cycle in [20, 60, 100, 140, 180, 220],
      do: [x * cycle | strengths],
      else: strengths
  end

  defp print_crt(x, cycle, output) do
    sprite_pos = rem(cycle, 40)

    if x in [sprite_pos - 1, sprite_pos, sprite_pos + 1],
      do: [?# | output],
      else: [?. | output]
  end

  defp parse(filename) do
    filename
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.split(&1, " ", trim: true))
    |> Stream.map(fn
      ["addx", n] -> {:addx, 2, String.to_integer(n)}
      ["noop"] -> :noop
    end)
    |> Enum.to_list()
  end
end
