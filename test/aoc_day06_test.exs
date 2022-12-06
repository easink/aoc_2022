defmodule AoCDay06Test do
  use ExUnit.Case

  @input File.read!("inputs/day06")

  test "part1" do
    assert AoC.Day06.part1("mjqjpqmgbljsphdztnvjfqwrcgsmlb") == 7
    assert AoC.Day06.part1("bvwbjplbgvbhsrlpgdmjqwftvncz") == 5
    assert AoC.Day06.part1("nppdvjthqldpwncqszvftbrmjlhg") == 6
    assert AoC.Day06.part1("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg") == 10
    assert AoC.Day06.part1("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw") == 11
    assert AoC.Day06.part1(@input) == 1578
  end

  test "part2" do
    assert AoC.Day06.part2("mjqjpqmgbljsphdztnvjfqwrcgsmlb") == 19
    assert AoC.Day06.part2("bvwbjplbgvbhsrlpgdmjqwftvncz") == 23
    assert AoC.Day06.part2("nppdvjthqldpwncqszvftbrmjlhg") == 23
    assert AoC.Day06.part2("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg") == 29
    assert AoC.Day06.part2("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw") == 26
    assert AoC.Day06.part2(@input) == 2178
  end
end
