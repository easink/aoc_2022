defmodule AoCDay23Test do
  use ExUnit.Case

  @test_input """
  #############
  #...........#
  ###B#C#B#D###
    #A#D#C#A#
    #########
  """

  @input """
  #############
  #...........#
  ###A#C#C#D###
    #B#D#A#B#
    #########
  """

  @test_input_part2 """
  #############
  #...........#
  ###B#C#B#D###
    #D#C#B#A#
    #D#B#A#C#
    #A#D#C#A#
    #########
  """

  @input_part2 """
  #############
  #...........#
  ###A#C#C#D###
    #D#C#B#A#
    #D#B#A#C#
    #B#D#A#B#
    #########
  """

  @tag timeout: :infinity
  test "part1" do
    assert AoC.Day23.part1(@test_input) == 12521
    assert AoC.Day23.part1(@input) == 13066
  end

  @tag timeout: :infinity
  test "part2" do
    assert AoC.Day23Part2.part2(@test_input_part2) == 44169
    assert AoC.Day23Part2.part2(@input_part2) == 47328
  end
end
