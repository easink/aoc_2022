defmodule AoCDay11Test do
  use ExUnit.Case

  test "part1" do
    # assert AoC.Day11.part1("inputs/day11.sample") == 10605
    # assert AoC.Day11.part1("inputs/day11") == 66802
  end

  test "part2" do
    assert AoC.Day11.part2("inputs/day11.sample") == 2_713_310_158
    assert AoC.Day11.part2("inputs/day11") == 21_800_916_620
  end
end
