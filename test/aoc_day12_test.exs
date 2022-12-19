defmodule AoCDay12Test do
  use ExUnit.Case

  test "part1" do
    assert AoC.Day12.part1("inputs/day12.sample") == 31
    assert AoC.Day12.part1("inputs/day12") == 520
  end

  test "part2" do
    assert AoC.Day12.part2("inputs/day12.sample") == 29
    assert AoC.Day12.part2("inputs/day12") == 508
  end
end
