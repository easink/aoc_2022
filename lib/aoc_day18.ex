defmodule AoC.Day18 do
  @moduledoc false

  def part1(input) do
    input
    |> parse()
    |> add_lines()
    |> magnitude([])
  end

  def part2(input) do
    input
    |> parse()
    |> find_biggest_pair()
  end

  def find_biggest_pair(lines) do
    for(line <- lines, second_line <- lines, line != second_line, do: [line, second_line])
    |> Enum.map(fn dual_lines ->
      dual_lines
      |> add_lines()
      |> magnitude([])
    end)
    |> Enum.max()
  end

  def add_lines([line | lines]), do: add_lines(lines, balance(line))
  def add_lines([], output), do: output

  def add_lines([line | lines], output) do
    output = (["["] ++ output ++ line ++ ["]"]) |> balance()

    add_lines(lines, output)
  end

  def magnitude([], [a]), do: a

  def magnitude(["[" | input], stack),
    do: magnitude(input, stack)

  def magnitude(["]" | input], [b, a | stack]),
    do: magnitude(input, [a * 3 + b * 2 | stack])

  def magnitude([num | input], stack),
    do: magnitude(input, [num | stack])

  def balance(input) do
    with ^input <- action_explode(input, 0, []),
         ^input <- action_split(input, []),
         do: input,
         else: (output -> balance(output))
  end

  def explode([], _num, acc), do: Enum.reverse(acc)
  def explode([a | list], num, acc) when is_integer(a), do: Enum.reverse([a + num | acc]) ++ list
  def explode([a | list], num, acc), do: explode(list, num, [a | acc])

  def action_explode([], _depth, output), do: Enum.reverse(output)

  def action_explode(["[", left, right, "]" | input], 4, output) do
    input = explode(input, right, [])
    output = explode(output, left, [])

    Enum.reverse(output) ++ [0 | input]
  end

  def action_explode(["[" | input], depth, output),
    do: action_explode(input, depth + 1, ["[" | output])

  def action_explode(["]" | input], depth, output),
    do: action_explode(input, depth - 1, ["]" | output])

  def action_explode([a | input], depth, output),
    do: action_explode(input, depth, [a | output])

  def action_split([], output), do: Enum.reverse(output)

  def action_split([num | input], output) when is_integer(num) and num > 9 do
    a = floor(num / 2.0)
    b = ceil(num / 2.0)
    pair = ["[", a, b, "]"]

    Enum.reverse(output) ++ pair ++ input
  end

  def action_split([a | input], output), do: action_split(input, [a | output])

  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.graphemes()
      |> Enum.filter(fn x -> x != "," end)
      |> Enum.map(fn
        "[" -> "["
        "]" -> "]"
        num -> String.to_integer(num)
      end)
    end)
  end
end
