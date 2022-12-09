defmodule AoCDay09Test do
  use ExUnit.Case

  test "part1" do
    assert AoC.Day09.part1("inputs/day09.sample") == 13
    assert AoC.Day09.part1("inputs/day09") == 6745
  end

  test "part2" do
    assert AoC.Day09.part2("inputs/day09.sample") == 1
    # assert AoC.Day09.part2("inputs/day09.sample2") == 8
    assert AoC.Day09.part2("inputs/day09") == 2793
  end
end
