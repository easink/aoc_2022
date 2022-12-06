defmodule AoC.Day06 do
  @moduledoc false

  def part1(input) do
    input
    |> to_charlist
    |> find_marker(4, 0)
  end

  def part2(input) do
    input
    |> to_charlist
    |> find_marker(14, 0)
  end

  defp find_marker([_a | inp] = input, n, idx) do
    input
    |> Enum.take(n)
    |> Enum.uniq()
    |> length()
    |> case do
      ^n -> idx + n
      _ -> find_marker(inp, n, idx + 1)
    end
  end

  # only for part1
  # defp find_marker([a, b, c, d | _input], idx)
  #      when a != b and a != c and a != d and b != c and b != d and c != d do
  #   idx + 4
  # end

  # defp find_marker([_a | input], idx),
  #   do: find_marker(input, idx + 1)
end
