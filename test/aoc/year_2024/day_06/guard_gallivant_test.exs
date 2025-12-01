defmodule Aoc.Year2024.Day06.GuardGallivantTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2024.Day06.GuardGallivant, import: true

  alias Aoc.Year2024.Day06.GuardGallivant, as: Day06

  @example """
  ....#.....
  .........#
  ..........
  ..#.......
  .......#..
  ..........
  .#..^.....
  ........#.
  #.........
  ......#...
  """

  describe "part_1/1" do
    test "examples" do
      assert Day06.part_1(@example) == 41
    end

    @tag day: 06, year: 2024
    test "input", %{input: input} do
      assert input |> Day06.part_1() == 4977
    end
  end

  describe "part_2/1" do
    test "examples" do
    end

    @tag day: 06, year: 2024
    test "input", %{input: input} do
      assert input |> Day06.part_2() == input
    end
  end
end
