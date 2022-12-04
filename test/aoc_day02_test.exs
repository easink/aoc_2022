defmodule AoCDay02Test do
  use ExUnit.Case

  test "part1" do
    assert AoC.Day02.part1("inputs/day02.sample") == 15
    assert AoC.Day02.part1("inputs/day02") == 12276
  end

  test "part2" do
    assert AoC.Day02.part2("inputs/day02.sample") == 12
    assert AoC.Day02.part2("inputs/day02") == 9975
  end
end
