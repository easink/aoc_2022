defmodule AoC.Day16 do
  @moduledoc """
  """
  use Bitwise

  @sum_op 0
  @prod_op 1
  @min_op 2
  @max_op 3
  @value_type 4
  @gt_op 5
  @lt_op 6
  @eq_op 7

  @operations %{
    @sum_op => &Enum.sum/1,
    @prod_op => &Enum.product/1,
    @min_op => &Enum.min/1,
    @max_op => &Enum.max/1,
    @gt_op => &__MODULE__.gt/1,
    @lt_op => &__MODULE__.lt/1,
    @eq_op => &__MODULE__.eq/1
  }

  @len15_type 0
  @len11_type 1

  def part1(input) do
    input
    |> parse()
    |> add_versions()
  end

  def part2(input) do
    input
    |> parse()
    |> calculator()
  end

  def calculator(%{type: :value, contain: value}), do: value

  def calculator(%{op: operation, contain: packets}),
    do: @operations[operation].(Enum.map(packets, &calculator/1))

  def gt([a, b]), do: if(a > b, do: 1, else: 0)
  def lt([a, b]), do: if(a < b, do: 1, else: 0)
  def eq([a, b]), do: if(a == b, do: 1, else: 0)

  def add_versions(packet) do
    %{version: version, type: type, contain: contain} = packet

    case type do
      :value -> version
      :operation -> version + (Enum.map(contain, &add_versions/1) |> Enum.sum())
    end
  end

  def parse(input) do
    input
    |> Base.decode16!()
    |> packet_parser()
    |> elem(0)
  end

  def packet_parser(<<version::3, @value_type::3, rest::bitstring>>) do
    {value, rest} = value_parser(0, rest)

    {%{version: version, type: :value, contain: value}, rest}
  end

  def packet_parser(<<version::3, type_id::3, @len15_type::1, len::15, data::bitstring-size(len), rest::bitstring>>) do
    packets = packets(data, [])
    {%{version: version, type: :operation, op: type_id, contain: packets}, rest}
  end

  def packet_parser(<<version::3, type_id::3, @len11_type::1, n::11, rest::bitstring>>) do
    {packets, rest} =
      Enum.reduce(1..n, {[], rest}, fn _n, {packets_acc, rest_acc} ->
        {packet, rest} = packet_parser(rest_acc)
        {[packet | packets_acc], rest}
      end)

    packets = Enum.reverse(packets)

    {%{version: version, type: :operation, op: type_id, contain: packets}, rest}
  end

  def value_parser(value, <<continue::1, val::4, rest::bitstring>>) do
    value = (value <<< 4) + val

    if continue == 1,
      do: value_parser(value, rest),
      else: {value, rest}
  end

  def packets(data, packets) do
    case packet_parser(data) do
      {packet, <<>>} -> Enum.reverse([packet | packets])
      {packet, rest} -> packets(rest, [packet | packets])
    end
  end
end
