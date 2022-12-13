defmodule AoC.Day11 do
  @moduledoc false

  def part1(filename) do
    filename
    |> parse()
    |> divisor()
    |> rounds(20)
    |> inspects()
  end

  def part2(filename) do
    filename
    |> parse()
    |> divisor()
    |> rounds(10000)
    |> inspects()
  end

  defp inspects(monkeys) do
    monkeys
    |> Enum.map(fn {_m, monkey} -> monkey.inspect end)
    |> Enum.sort(:desc)
    |> Enum.take(2)
    |> Enum.product()
  end

  defp rounds(monkeys, 0), do: monkeys

  defp rounds(monkeys, round) do
    monkeys
    |> Enum.sort_by(fn {n, _m} -> n end)
    |> Enum.reduce(monkeys, fn {n, _monkey}, acc ->
      round(acc, acc[n])
    end)
    |> rounds(round - 1)
  end

  defp round(monkeys, monkey) do
    monkey.items
    |> Enum.reduce(monkeys, fn item, acc ->
      worry =
        item
        |> worry(monkey)
        |> rem(monkey.divisor)

      to_monkey = to_monkey(worry, monkey)

      acc
      |> add_item_to_monkey(to_monkey, worry)
      |> inc_inspect(monkey)
    end)
    |> put_in([monkey.name, :items], [])
  end

  defp divisor(monkeys) do
    divisor =
      Enum.reduce(monkeys, 1, fn
        {_m, monkey}, acc -> acc * monkey.div
      end)

    Map.new(monkeys, fn {m, monkey} ->
      {m, Map.put(monkey, :divisor, divisor)}
    end)
  end

  defp worry(item, monkey) do
    _worry =
      case monkey.op do
        {:mul, :old} -> item * item
        {:mul, val} -> item * val
        {:add, val} -> item + val
      end

    # div(worry, 3)
  end

  defp to_monkey(worry, monkey) do
    %{div: div, true: m1, false: m2} = monkey
    if 0 == rem(worry, div), do: m1, else: m2
  end

  defp add_item_to_monkey(monkeys, name, item) do
    update_in(monkeys, [name, :items], &(&1 ++ [item]))
  end

  defp inc_inspect(monkeys, monkey) do
    update_in(monkeys, [monkey.name, :inspect], &(&1 + 1))
  end

  defp parse(filename) do
    filename
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.replace(&1, ":", ""))
    |> Stream.map(&String.replace(&1, ",", ""))
    |> Stream.map(&String.split(&1, " ", trim: true))
    |> Enum.to_list()
    |> parse_monkeys(%{}, %{})
  end

  defp parse_monkeys([], m, monkeys),
    do: Map.put(monkeys, m.name, m)

  defp parse_monkeys([[] | input], m, monkeys),
    do: parse_monkeys(input, nil, Map.put(monkeys, m.name, m))

  defp parse_monkeys([entry | input], m, monkeys) do
    case entry do
      ["Monkey", m] ->
        parse_monkeys(input, %{name: String.to_integer(m), inspect: 0}, monkeys)

      ["Starting", "items" | items] ->
        items = Enum.map(items, &String.to_integer/1)
        m = Map.put(m, :items, items)
        parse_monkeys(input, m, monkeys)

      ["Operation", "new", "=", "old", "*", "old"] ->
        m = Map.put(m, :op, {:mul, :old})
        parse_monkeys(input, m, monkeys)

      ["Operation", "new", "=", "old", "*", val] ->
        m = Map.put(m, :op, {:mul, String.to_integer(val)})
        parse_monkeys(input, m, monkeys)

      ["Operation", "new", "=", "old", "+", val] ->
        m = Map.put(m, :op, {:add, String.to_integer(val)})
        parse_monkeys(input, m, monkeys)

      ["Test", "divisible", "by", val] ->
        m = Map.put(m, :div, String.to_integer(val))
        parse_monkeys(input, m, monkeys)

      ["If", "true", "throw", "to", "monkey", monkey] ->
        m = Map.put(m, true, String.to_integer(monkey))
        parse_monkeys(input, m, monkeys)

      ["If", "false", "throw", "to", "monkey", monkey] ->
        m = Map.put(m, false, String.to_integer(monkey))
        parse_monkeys(input, m, monkeys)
    end
  end
end
