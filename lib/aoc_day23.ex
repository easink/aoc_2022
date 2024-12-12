defmodule AoC.Day23 do
  @moduledoc false

  def part1(input) do
    input
    |> parse()
    |> walk(0, :infinity, [])
  end

  def walk(_amphipods, energy, lowest)
      when energy >= lowest,
      do: lowest

  def walk(amphipods, energy, lowest, debug) do
    if Enum.all?(amphipods, fn amphipod -> amphipod_done?(amphipods, amphipod) end) do
      energy
    else
      amphipods
      |> Enum.reject(fn amphipod -> amphipod_done?(amphipods, amphipod) end)
      |> Enum.reduce(lowest, fn amphipod, lowest_acc ->
        # if length(debug) < 2 do
        #   IO.inspect({lowest_acc, Enum.find_index(amphipods, fn a -> a == amphipod end), length(amphipods)}, label: String.duplicate("  ", length(debug)))
        # end

        amphipods
        |> walk_amphipod(amphipod, energy, lowest_acc, debug)
        |> min(lowest_acc)
      end)
    end
  end

  def walk_amphipod(amphipods, {amp, _pos} = amphipod, energy, lowest, debug) do
    amphipods
    |> possible_moves(amphipod)
    |> Enum.reduce(lowest, fn {pos, nenergy} = _move, lowest_acc ->
      amphipods
      |> move_amphipod(amphipod, {amp, pos})
      |> walk(energy + nenergy, lowest_acc, [{amphipod, "->", {amp, pos}} | debug])
      |> min(lowest_acc)
    end)
  end

  def move_amphipod(amphipods, from, to),
    do: (amphipods -- [from]) ++ [to]

  def amphipod_done?(amphipods, {_amp, pos} = amphipod),
    do: amphipod_done?(amphipods, amphipod, pos)

  def amphipod_done?(amphipods, amphipod, _origpos) do
    # IO.inspect(amphipod, label: :DONETEST)
    {amp, pos} = amphipod
    [first_pos, second_pos] = room(amp)

    first_pos == pos or
      ({amp, first_pos} in amphipods and second_pos == pos)
  end

  def possible_moves(amphipods, amphipod) do
    {_amp, origpos} = amphipod
    occupied = Enum.map(amphipods, fn {_oamp, opos} -> opos end)

    occupied
    |> possible_moves(amphipod, 0, [{origpos, 0}])
    |> Enum.reject(fn {pos, _score} -> pos in illegal_pos() end)
    |> remove_hallway_if_in_hallway(amphipod)
    |> possible_room_pos(amphipod, amphipods)
    |> List.delete({origpos, 0})
  end

  def remove_hallway_if_in_hallway(positions, {_amp, origpos}) do
    Enum.reject(positions, fn {pos, _score} ->
      in_hallway?(origpos) and in_hallway?(pos)
    end)
  end

  def possible_room_pos(positions, {amp, origpos}, amphipods) do
    found =
      Enum.find(positions, fn {pos, _energy} ->
        amphipod_done?(amphipods, {amp, pos}, origpos)
      end)

    cond do
      found == origpos -> []
      found -> [found]
      true -> positions |> Enum.reject(fn {pos, _energy} -> pos in all_rooms() end)
    end
  end

  def possible_moves(occupied, {amp, {x, y}}, energy, moves) do
    nenergy = energy + calc_move(amp)

    [:left, :right, :up, :down]
    |> Enum.reduce(moves, fn
      :left, acc ->
        npos = {x - 1, y}

        if possible_move(occupied, {amp, npos}, moves),
          do: possible_moves(occupied, {amp, npos}, nenergy, [{npos, nenergy} | acc]),
          else: acc

      :right, acc ->
        npos = {x + 1, y}

        if possible_move(occupied, {amp, npos}, moves),
          do: possible_moves(occupied, {amp, npos}, nenergy, [{npos, nenergy} | acc]),
          else: acc

      :up, acc ->
        npos = {x, y - 1}

        if possible_move_up(occupied, npos, moves),
          do: possible_moves(occupied, {amp, npos}, nenergy, [{npos, nenergy} | acc]),
          else: acc

      :down, acc ->
        npos = {x, y + 1}

        if possible_move(occupied, {amp, npos}, moves),
          do: possible_moves(occupied, {amp, npos}, nenergy, [{npos, nenergy} | acc]),
          else: acc
    end)
  end

  def in_room?(pos), do: pos in all_rooms()
  def in_hallway?(pos), do: pos in hallway_pos()

  def possible_move(occupied, {amp, pos}, been) do
    !Enum.find(been, fn {apos, _energy} -> apos == pos end) and
      (pos in hallway_pos() or pos in room(amp)) and
      !Enum.find(occupied, fn opos -> opos == pos end)
  end

  def possible_move_up(occupied, pos, been) do
    !Enum.find(been, fn {apos, _energy} -> apos == pos end) and
      (pos in hallway_pos() or pos in all_rooms()) and
      !Enum.find(occupied, fn opos -> opos == pos end)
  end

  def calc_move("A"), do: 1
  def calc_move("B"), do: 10
  def calc_move("C"), do: 100
  def calc_move("D"), do: 1000

  @hallway_pos for x <- 1..11, do: {x, 1}
  def hallway_pos(), do: @hallway_pos
  def illegal_pos(), do: [{3, 1}, {5, 1}, {7, 1}, {9, 1}]
  def room("A"), do: [{3, 3}, {3, 2}]
  def room("B"), do: [{5, 3}, {5, 2}]
  def room("C"), do: [{7, 3}, {7, 2}]
  def room("D"), do: [{9, 3}, {9, 2}]

  def all_rooms(),
    do: room("A") ++ room("B") ++ room("C") ++ room("D")

  def print(amphipods) do
    apos = :proplists.get_all_values("A", amphipods)
    bpos = :proplists.get_all_values("B", amphipods)
    cpos = :proplists.get_all_values("C", amphipods)
    dpos = :proplists.get_all_values("D", amphipods)

    for y <- 0..4 do
      for x <- 0..12 do
        cond do
          {x, y} in apos -> "A"
          {x, y} in bpos -> "B"
          {x, y} in cpos -> "C"
          {x, y} in dpos -> "D"
          {x, y} in illegal_pos() -> ","
          {x, y} in hallway_pos() -> "."
          {x, y} in room("A") -> "."
          {x, y} in room("B") -> "."
          {x, y} in room("C") -> "."
          {x, y} in room("D") -> "."
          true -> "#"
        end
        |> IO.write()
      end

      IO.write("\n")
    end

    amphipods
  end

  def parse(input) do
    input
    |> String.split("\n")
    |> Enum.with_index()
    |> Enum.reduce([], fn {line, y}, acc ->
      line
      |> String.codepoints()
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {char, x}, acc ->
        if char in ["A", "B", "C", "D"],
          do: [{char, {x, y}} | acc],
          else: acc
      end)
    end)
  end
end
