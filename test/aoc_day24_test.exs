defmodule AoCDay24Test do
  use ExUnit.Case

  # import AoC.Day24

  @input """
  inp w
  mul x 0
  add x z
  mod x 26
  div z 1
  add x 12
  eql x w
  eql x 0
  mul y 0
  add y 25
  mul y x
  add y 1
  mul z y
  mul y 0
  add y w
  add y 7
  mul y x
  add z y
  inp w
  mul x 0
  add x z
  mod x 26
  div z 1
  add x 11
  eql x w
  eql x 0
  mul y 0
  add y 25
  mul y x
  add y 1
  mul z y
  mul y 0
  add y w
  add y 15
  mul y x
  add z y
  inp w
  mul x 0
  add x z
  mod x 26
  div z 1
  add x 12
  eql x w
  eql x 0
  mul y 0
  add y 25
  mul y x
  add y 1
  mul z y
  mul y 0
  add y w
  add y 2
  mul y x
  add z y
  inp w
  mul x 0
  add x z
  mod x 26
  div z 26
  add x -3
  eql x w
  eql x 0
  mul y 0
  add y 25
  mul y x
  add y 1
  mul z y
  mul y 0
  add y w
  add y 15
  mul y x
  add z y
  inp w
  mul x 0
  add x z
  mod x 26
  div z 1
  add x 10
  eql x w
  eql x 0
  mul y 0
  add y 25
  mul y x
  add y 1
  mul z y
  mul y 0
  add y w
  add y 14
  mul y x
  add z y
  inp w
  mul x 0
  add x z
  mod x 26
  div z 26
  add x -9
  eql x w
  eql x 0
  mul y 0
  add y 25
  mul y x
  add y 1
  mul z y
  mul y 0
  add y w
  add y 2
  mul y x
  add z y
  inp w
  mul x 0
  add x z
  mod x 26
  div z 1
  add x 10
  eql x w
  eql x 0
  mul y 0
  add y 25
  mul y x
  add y 1
  mul z y
  mul y 0
  add y w
  add y 15
  mul y x
  add z y
  inp w
  mul x 0
  add x z
  mod x 26
  div z 26
  add x -7
  eql x w
  eql x 0
  mul y 0
  add y 25
  mul y x
  add y 1
  mul z y
  mul y 0
  add y w
  add y 1
  mul y x
  add z y
  inp w
  mul x 0
  add x z
  mod x 26
  div z 26
  add x -11
  eql x w
  eql x 0
  mul y 0
  add y 25
  mul y x
  add y 1
  mul z y
  mul y 0
  add y w
  add y 15
  mul y x
  add z y
  inp w
  mul x 0
  add x z
  mod x 26
  div z 26
  add x -4
  eql x w
  eql x 0
  mul y 0
  add y 25
  mul y x
  add y 1
  mul z y
  mul y 0
  add y w
  add y 15
  mul y x
  add z y
  inp w
  mul x 0
  add x z
  mod x 26
  div z 1
  add x 14
  eql x w
  eql x 0
  mul y 0
  add y 25
  mul y x
  add y 1
  mul z y
  mul y 0
  add y w
  add y 12
  mul y x
  add z y
  inp w
  mul x 0
  add x z
  mod x 26
  div z 1
  add x 11
  eql x w
  eql x 0
  mul y 0
  add y 25
  mul y x
  add y 1
  mul z y
  mul y 0
  add y w
  add y 2
  mul y x
  add z y
  inp w
  mul x 0
  add x z
  mod x 26
  div z 26
  add x -8
  eql x w
  eql x 0
  mul y 0
  add y 25
  mul y x
  add y 1
  mul z y
  mul y 0
  add y w
  add y 13
  mul y x
  add z y
  inp w
  mul x 0
  add x z
  mod x 26
  div z 26
  add x -10
  eql x w
  eql x 0
  mul y 0
  add y 25
  mul y x
  add y 1
  mul z y
  mul y 0
  add y w
  add y 13
  mul y x
  add z y
  """

  # @invert_input """
  # inp x
  # mul x -1
  # """

  # @is_three_times_input """
  # inp z
  # inp x
  # mul z 3
  # eql z x
  # """

  # @binary_input """
  # inp w
  # add z w
  # mod z 2
  # div w 2
  # add y w
  # mod y 2
  # div w 2
  # add x w
  # mod x 2
  # div w 2
  # mod w 2
  # """

  # describe "alu" do
  #   test "invert" do
  #     instructions = parse(@invert_input)

  #     assert execute(instructions, [1])["x"] == -1
  #     assert execute(instructions, [9])["x"] == -9
  #   end

  #   test "three times" do
  #     instructions = parse(@is_three_times_input)

  #     assert execute(instructions, [1, 3])["z"] == 1
  #     assert execute(instructions, [3, 9])["z"] == 1
  #     assert execute(instructions, [1, 2])["z"] == 0
  #     assert execute(instructions, [3, 1])["z"] == 0
  #   end

  #   test "binary" do
  #     instructions = parse(@binary_input)

  #     vars = execute(instructions, [7])
  #     assert vars["w"] == 0
  #     assert vars["x"] == 1
  #     assert vars["y"] == 1
  #     assert vars["z"] == 1

  #     vars = execute(instructions, [0])
  #     assert vars["w"] == 0
  #     assert vars["x"] == 0
  #     assert vars["y"] == 0
  #     assert vars["z"] == 0

  #     vars = execute(instructions, [5])
  #     assert vars["w"] == 0
  #     assert vars["x"] == 1
  #     assert vars["y"] == 0
  #     assert vars["z"] == 1
  #   end
  # end

  @tag timeout: :infinity
  test "part1" do
    assert AoC.Day24.part1(@input) == 65_984_919_997_939
  end

  test "part2" do
    assert AoC.Day24.part2(@input) == 11_211_619_541_713
  end
end
