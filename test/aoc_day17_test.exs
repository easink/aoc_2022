defmodule AoCDay17Test do
  use ExUnit.Case

  @test_input "target area: x=20..30, y=-10..-5"
  @input "target area: x=135..155, y=-102..-78"

  test "part1" do
    assert AoC.Day17.part1(@test_input) == 45
    assert AoC.Day17.part1(@input) == 5151
  end

  test "part2" do
    assert AoC.Day17.part2(@test_input) == 112
    assert AoC.Day17.part2(@input) == 968
  end
end
