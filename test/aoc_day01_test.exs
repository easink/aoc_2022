defmodule AoCDay01Test do
  use ExUnit.Case

  test "part1" do
    assert AoC.Day01.part1("inputs/day01.sample") == 24000
    assert AoC.Day01.part1("inputs/day01") == 73211
  end

  test "part2" do
    assert AoC.Day01.part2("inputs/day01.sample") == 45000
    assert AoC.Day01.part2("inputs/day01") == 213958
  end
end
