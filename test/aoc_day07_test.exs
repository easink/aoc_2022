defmodule AoCDay07Test do
  use ExUnit.Case

  @input File.read!("inputs/day07")

  test "part1" do
    assert AoC.Day07.part1("inputs/day07.sample") == 95437
    assert AoC.Day07.part1("inputs/day07") == 1_490_523
  end

  test "part2" do
    assert AoC.Day07.part2("inputs/day07.sample") == 24_933_642
    assert AoC.Day07.part2("inputs/day07") == 12_390_492
  end
end
