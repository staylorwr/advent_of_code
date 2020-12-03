defmodule Aoc.Year2020.Day03.TobogganTrajectoryTest do
  use Aoc.DayCase
  doctest Aoc.Year2020.Day03.TobogganTrajectory, import: true

  alias Aoc.Year2020.Day03.TobogganTrajectory, as: Day03

  @example """
  ..##.......
  #...#...#..
  .#....#..#.
  ..#.#...#.#
  .#...##..#.
  ..#.##.....
  .#.#.#....#
  .#........#
  #.##...#...
  #...##....#
  .#..#...#.#
  """

  describe "part_1/1" do
    test "examples" do
      assert Day03.part_1(@example) == 7
    end

    @tag day: 03, year: 2020
    test "input", %{input: input} do
      assert input |> Day03.part_1() == 268
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert Day03.part_2(@example) == 336
    end

    @tag day: 03, year: 2020
    test "input", %{input: input} do
      assert input |> Day03.part_2() == 3_093_068_400
    end
  end

  test "parse_map returns a list of lists" do
    map = Day03.parse_map(@example)
    assert map.size == {11, 11}
    assert hd(map.data) == ~w(. . # # . . . . . . .)
  end

  test "has_tree_at?" do
    map = Day03.parse_map(@example)
    refute Day03.has_tree_at?(map, {0, 0})
    assert Day03.has_tree_at?(map, {0, 1})
    assert Day03.has_tree_at?(map, {14, 0})
  end
end
