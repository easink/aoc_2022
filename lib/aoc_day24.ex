defmodule AoC.Day24 do
  @moduledoc false

  def part1(data) do
    data
    |> parse()
    |> calc_chunks(9..1)

    # debug output | execute   | map  | 1120s
    # debug output | execute   | list | 1104s
    # debug output | optimized | list | 902s
    #              | optimized | list | 18s

    # |> build_ast()
  end

  def part2(input) do
    input
    |> parse()
    |> calc_chunks(1..9)
  end

  def calc_chunk(z, w, {x_add, y_add}) when x_add < 10 do
    if rem(z, 26) + x_add == w,
      do: div(z, 26),
      else: div(z, 26) * 26 + w + y_add
  end

  def calc_chunk(z, w, {_x_add, y_add}),
    do: z * 26 + w + y_add

  def calc_chunks(chunks, range) do
    caches = for _i <- 1..length(chunks), do: MapSet.new()

    calc_chunks(chunks, 0, caches, [], range)
    |> elem(2)
    |> Enum.reverse()
    |> Integer.undigits()
  end

  def calc_chunks([], z, caches, input, _range), do: {z, caches, input}

  def calc_chunks([chunk | chunks], prev_z, caches, input, range) do
    range
    |> Enum.reduce_while({prev_z, caches, input}, fn w, {_z, [cache_acc | caches_acc], _input} ->
      z = calc_chunk(prev_z, w, chunk)
      # %{"z" => z} = execute(chunk, %{"w" => 0, "x" => 0, "y" => 0, "z" => prev_z}, [w])

      if MapSet.member?(cache_acc, z) do
        # if length(input) < 5, do: IO.inspect("hit #{length(input)} #{inspect([w | input])} - #{z}")

        {:cont, {z, [cache_acc | caches_acc], input}}
      else
        {new_z, new_caches_acc, new_input} = calc_chunks(chunks, z, caches_acc, [w | input], range)

        updated_cache_acc = MapSet.put(cache_acc, z)

        if new_z == 0,
          do: {:halt, {new_z, [], new_input}},
          else: {:cont, {z, [updated_cache_acc | new_caches_acc], input}}
      end
    end)
  end

  # def build_ast(instructions) do
  #   build_ast(instructions, reset(), 0)
  # end

  # def build_ast([], variables, _input_pos), do: variables

  # def build_ast([{"inp", var} | instructions], variables, input_pos) do
  #   IO.binread(1)
  #   IO.inspect(variables)
  #   build_ast(instructions, %{variables | var => {"pos", input_pos}}, input_pos + 1)
  # end

  # def build_ast([{op, var, vi} | instructions], variables, input_pos) do
  #   # op = op |> String.to_atom()

  #   res =
  #     {op, get_ast(variables, var), get_ast(variables, vi)}
  #     |> optimize()

  #   build_ast(instructions, %{variables | var => res}, input_pos)
  # end

  # def optimize({op, i, j})
  #     when is_integer(i) and is_integer(j),
  #     do: operation(op, i, j)

  # def optimize({"add", var, 0}), do: var
  # def optimize({"add", 0, var}), do: var
  # def optimize({"mul", 0, _var}), do: 0
  # def optimize({"mul", _var, 0}), do: 0
  # def optimize({"mul", var, 1}), do: var
  # def optimize({"div", 0, _var}), do: 0
  # def optimize({"div", var, 1}), do: var
  # def optimize({"mod", 0, _var}), do: 0
  # def optimize({"eql", i, {"pos", _pos}}) when is_integer(i) and (i > 9 or i < 1), do: 0
  # def optimize({"eql", {"pos", _pos}, i}) when is_integer(i) and (i > 9 or i < 1), do: 0
  # def optimize({"eql", {"add", _ast, i}, {"pos", _pos}}) when is_integer(i) and i > 9, do: 0
  # def optimize(ast), do: ast |> IO.inspect(label: "AST", width: :infinity)

  # def get_ast(variables, var_or_int) do
  #   if is_var(var_or_int),
  #     do: variables[var_or_int],
  #     else: var_or_int
  # end

  def reset(), do: %{"w" => 0, "x" => 0, "y" => 0, "z" => 0}

  def execute(instructions, input),
    do: execute(instructions, reset(), input)

  def execute([], variables, _input), do: variables

  def execute([{"inp", var} | instructions], variables, [int | input]),
    do: execute(instructions, %{variables | var => int}, input)

  def execute([{op, var, vi} | instructions], variables, input) do
    res = operation(op, get(variables, var), get(variables, vi))
    execute(instructions, %{variables | var => res}, input)
  end

  def operation("add", a, b), do: a + b
  def operation("mul", a, b), do: a * b
  def operation("div", a, b), do: div(a, b)
  def operation("mod", a, b), do: rem(a, b)
  def operation("eql", a, b), do: if(a == b, do: 1, else: 0)

  def is_var(var_or_int), do: var_or_int in ["w", "x", "y", "z"]

  def get(variables, var_or_int) do
    if is_var(var_or_int),
      do: variables[var_or_int],
      else: var_or_int
  end

  def parse(input) do
    input
    |> String.split()
    |> parser([])
    |> parse_chunks()
  end

  def parse_var(var_or_int) do
    if is_var(var_or_int),
      do: var_or_int,
      else: String.to_integer(var_or_int)
  end

  def parser([], instructions), do: Enum.reverse(instructions)

  def parser(["inp", var | input], instructions),
    do: parser(input, [{"inp", var} | instructions])

  def parser([instruction, var, var_or_int | input], instructions),
    do: parser(input, [{instruction, var, parse_var(var_or_int)} | instructions])

  # def parse_chunks(instructions) do
  #   Enum.chunk_every(instructions, 18)
  # end

  def parse_chunks(instructions),
    do: parse_chunk(instructions, [])

  def parse_chunk([], chunks), do: Enum.reverse(chunks)

  def parse_chunk(
        [
          {"inp", "w"},
          {"mul", "x", 0},
          {"add", "x", "z"},
          {"mod", "x", 26},
          {"div", "z", _z_div},
          {"add", "x", x_add},
          {"eql", "x", "w"},
          {"eql", "x", 0},
          {"mul", "y", 0},
          {"add", "y", 25},
          {"mul", "y", "x"},
          {"add", "y", 1},
          {"mul", "z", "y"},
          {"mul", "y", 0},
          {"add", "y", "w"},
          {"add", "y", y_add},
          {"mul", "y", "x"},
          {"add", "z", "y"}
          | instructions
        ],
        chunks
      ),
      do: parse_chunk(instructions, [{x_add, y_add} | chunks])
end

# inp a - Read an input value and write it to variable a.
# add a b - Add the value of a to the value of b, then store the result in variable a.
# mul a b - Multiply the value of a by the value of b, then store the result in variable a.
# div a b - Divide the value of a by the value of b, truncate the result to an integer, then store the result in variable a. (Here, "truncate" means to round the value toward zero.)
# mod a b - Divide the value of a by the value of b, then store the remainder in variable a. (This is also called the modulo operation.)
# eql a b - If the value of a and b are equal, then store the value 1 in variable a. Otherwise, store the value 0 in variable a.
