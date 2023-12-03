defmodule Aoc.Year2023.Day03.GearRatiosTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2023.Day03.GearRatios, import: true

  alias Aoc.Year2023.Day03.GearRatios, as: Day03

  @example """
  467..114..
  ...*......
  ..35..633.
  ......#...
  617*......
  .....+.58.
  ..592.....
  ......755.
  ...$.*....
  .664.598..
  """

  describe "part_1/1" do
    test "examples" do
      first_two_rows = """
      467..114..
      ...*......
      """

      assert Day03.part_1(first_two_rows) == 467
      assert Day03.part_1(@example) == 4361
    end

    @tag day: 03, year: 2023
    test "input", %{input: input} do
      assert input |> Day03.part_1() == input
    end
  end

  describe "part_2/1" do
    test "examples" do
      single_gear = """
      467.114...
      ...*......
      """

      assert Day03.part_2(single_gear) == 467 * 114
      assert Day03.part_2(@example) == 467_835
    end

    @tag day: 03, year: 2023
    test "input", %{input: input} do
      assert input |> Day03.part_2() == 81_709_807
    end
  end

  describe "Part1" do
    test "surrounds" do
      assert Day03.surrounds({0, 0}, 1) ==
               MapSet.new([
                 {0, -1},
                 {0, 1},
                 {-1, 0},
                 {1, 0},
                 {-1, -1},
                 {1, -1},
                 {-1, 1},
                 {1, 1}
               ])

      # ....
      # .xx.
      # ....
      length_of_two = Day03.surrounds({1, 1}, 2)
      assert MapSet.member?(length_of_two, {0, 0})
      assert MapSet.member?(length_of_two, {3, 0})
      refute MapSet.member?(length_of_two, {4, 0})
      assert Enum.count(length_of_two) == 10

      #   01234
      # 0 .....
      # 0 .xxx.
      # 0 .....
      length_of_three = Day03.surrounds({1, 1}, 3)
      assert Enum.count(length_of_three) == 12
      assert MapSet.member?(length_of_three, {0, 0})
    end
  end

  describe "Parser" do
    test "returns two values" do
      {[p1, p2], grid} = Day03.Parser.parse("467..114..")
      assert p1 == {{0, 0}, 467}
      assert p2 == {{5, 0}, 114}

      assert grid == %{
               {0, 0} => "4",
               {1, 0} => "6",
               {2, 0} => "7",
               {3, 0} => ".",
               {4, 0} => ".",
               {5, 0} => "1",
               {6, 0} => "1",
               {7, 0} => "4",
               {8, 0} => ".",
               {9, 0} => "."
             }
    end
  end
end
