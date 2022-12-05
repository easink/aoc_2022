defmodule AoC.Day05 do
  @moduledoc false

  def part1(filename) do
    filename
    |> parse()
    |> move_crates(&move_one_crate/2)
    |> pick_top()
  end

  def part2(filename) do
    filename
    |> parse()
    |> move_crates(&move_all_crates/2)
    |> pick_top()
  end

  defp pick_top(crates) do
    crates
    |> Map.keys()
    |> Enum.sort()
    |> Enum.reduce('', fn stack, top ->
      [crate | _] = crates[stack]
      [crate | top]
    end)
    |> Enum.reverse()
    |> to_string()
  end

  defp move_crates({crates, ops}, move_fun),
    do: move_crates(crates, ops, move_fun)

  defp move_crates(crates, [], _move_fun), do: crates

  defp move_crates(crates, [op | ops], move_fun) do
    crates
    |> move_fun.(op)
    |> move_crates(ops, move_fun)
  end

  defp move_one_crate(crates, {0, _, _}), do: crates

  defp move_one_crate(crates, {n, from, to}) do
    [crate | from_crates] = crates[from]
    to_crates = crates[to]

    %{crates | from => from_crates, to => [crate | to_crates]}
    |> move_one_crate({n - 1, from, to})
  end

  defp move_all_crates(crates, {n, from, to}) do
    {move_crates, from_crates} = Enum.split(crates[from], n)
    to_crates = crates[to]

    %{crates | from => from_crates, to => move_crates ++ to_crates}
  end

  defp parse(filename) do
    filename
    |> File.stream!()
    |> Enum.chunk_by(&(&1 == "\n"))
    |> then(fn [a, _b, c] -> {parse_tower(a), parse_ops(c)} end)
  end

  defp parse_tower(lines) do
    lines
    |> Enum.map(&to_charlist/1)
    |> Enum.reduce(%{}, fn line, crates ->
      parse_tower(line, crates, 1)
    end)
  end

  defp parse_tower([32, 32, 32, _ | line], crates, stack),
    do: parse_tower(line, crates, stack + 1)

  defp parse_tower([?[, crate, ?], _ | line], crates, stack) do
    crates =
      Map.update(crates, stack, [crate], fn stack_crates ->
        [crate | stack_crates]
      end)

    parse_tower(line, crates, stack + 1)
  end

  # EOL
  defp parse_tower([], crates, _stack), do: crates
  # num row
  defp parse_tower([32, ?1 | _line], crates, _stack) do
    for {stack, stack_crates} <- crates, into: %{} do
      {stack, Enum.reverse(stack_crates)}
    end
  end

  defp parse_ops(lines) do
    Enum.map(lines, fn line ->
      ["move", n, "from", from, "to", to] =
        line
        |> String.trim()
        |> String.split(" ")

      {String.to_integer(n), String.to_integer(from), String.to_integer(to)}
    end)
  end
end
