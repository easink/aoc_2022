defmodule AoCDay03Test do
  use ExUnit.Case

  test "part1" do
    assert AoC.Day03.part1("inputs/day03.sample") == 157
    assert AoC.Day03.part1("inputs/day03") == 8123
  end

  test "part2" do
    assert AoC.Day03.part2("inputs/day03.sample") == 70
    assert AoC.Day03.part2("inputs/day03") == 2620
  end
end
