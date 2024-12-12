defmodule AoCDay21Test do
  use ExUnit.Case

  test "part1" do
    assert AoC.Day21.part1(4, 8) == 739_785
    assert AoC.Day21.part1(8, 3) == 412_344
  end

  test "part2" do
    assert AoC.Day21.part2(4, 8) == 444_356_092_776_315
    assert AoC.Day21.part2(8, 3) == 214_924_284_932_572
  end
end
