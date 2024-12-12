defmodule AoC.Day14 do
  @moduledoc false

  # naive solution
  def part1(input, steps) do
    input
    |> parse()
    |> insertions(steps)
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.min_max()
    |> then(fn {min, max} -> max - min end)
  end

  # improved solution
  def part2(input, steps) do
    {rules, templates} = parse(input)
    first = List.first(templates)

    {rules, templates}
    |> calc_freq(steps)
    |> count_chars(first)
    |> Enum.map(fn {_pair, counter} -> counter end)
    |> Enum.min_max()
    |> then(fn {min, max} -> max - min end)
  end

  def count_chars(pair_counter, first) do
    Enum.reduce(pair_counter, %{first => 1}, fn {{_a, b}, pair_count}, acc ->
      Map.update(acc, b, pair_count, fn count -> pair_count + count end)
    end)
  end

  def calc_freq({rules, template}, step) do
    template
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn [a, b] -> {{a, b}, 1} end)
    |> Enum.into(%{})
    |> calc_freq(rules, step)
  end

  def calc_freq(pair_counter, _rules, 0), do: pair_counter

  def calc_freq(pair_counter, rules, step) do
    pair_counter
    |> Enum.reduce(%{}, fn {{a, b}, pair_count}, acc ->
      c = rules[{a, b}]

      acc
      |> Map.update({a, c}, pair_count, fn count -> pair_count + count end)
      |> Map.update({c, b}, pair_count, fn count -> pair_count + count end)
    end)
    |> calc_freq(rules, step - 1)
  end

  def insertions({_rules, template}, 0), do: template

  def insertions({rules, template}, steps) do
    polymer = insertion(rules, template, '')
    insertions({rules, polymer}, steps - 1)
  end

  def insertion(_rules, [a], polymer), do: Enum.reverse([a | polymer])

  def insertion(rules, [a, b | template], polymer) do
    c = rules[{a, b}]
    insertion(rules, [b | template], [c, a | polymer])
  end

  def parse(input) do
    [template | rules] = String.split(input, "\n", trim: true)
    template = String.to_charlist(template)

    parsed_rules =
      Enum.reduce(rules, %{}, fn rule, acc ->
        {a, b, c} = parse_rule(rule)
        Map.put(acc, {a, b}, c)
      end)

    {parsed_rules, template}
  end

  def parse_rule(<<a, b, " -> ", c>>), do: {a, b, c}
end
