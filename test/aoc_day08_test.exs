defmodule AoCDay08Test do
  use ExUnit.Case

  test "part1" do
    assert AoC.Day08.part1("inputs/day08.sample") == 21
    assert AoC.Day08.part1("inputs/day08") == 1843
  end

  test "part2" do
    assert AoC.Day08.part2("inputs/day08.sample") == 8
    assert AoC.Day08.part2("inputs/day08") == 180_000
  end
end
