defmodule AoCDay05Test do
  use ExUnit.Case

  test "part1" do
    assert AoC.Day05.part1("inputs/day05.sample") == "CMZ"
    assert AoC.Day05.part1("inputs/day05") == "ZBDRNPMVH"
  end

  test "part2" do
    assert AoC.Day05.part2("inputs/day05.sample") == "MCD"
    assert AoC.Day05.part2("inputs/day05") == "WDLPFNNNB"
  end
end
