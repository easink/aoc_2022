defmodule AoCDay04Test do
  use ExUnit.Case

  test "part1" do
    assert AoC.Day04.part1("inputs/day04.sample") == 2
    assert AoC.Day04.part1("inputs/day04") == 542
  end

  test "part2" do
    assert AoC.Day04.part2("inputs/day04.sample") == 4
    assert AoC.Day04.part2("inputs/day04") == 900
  end
end
