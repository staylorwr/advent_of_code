defmodule Aoc.Year2022.Day09.RopeBridgeTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2022.Day09.RopeBridge, import: true

  alias Aoc.Year2022.Day09.RopeBridge, as: Day09

  @example """
  R 4
  U 4
  L 3
  D 1
  R 4
  D 1
  L 5
  R 2
  """

  @large_example """
  R 5
  U 8
  L 8
  D 3
  R 17
  D 10
  L 25
  U 20
  """

  describe "part_1/1" do
    test "examples" do
      assert Day09.part_1(@example) == 13
    end

    @tag day: 09, year: 2022
    test "input", %{input: input} do
      assert input |> Day09.part_1() == 6057
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert Day09.part_2(@large_example) == 36
    end

    @tag day: 09, year: 2022
    test "input", %{input: input} do
      assert input |> Day09.part_2() == 2514
    end
  end

  describe "State.move_tail/2" do
    test "tail must always be touching head" do
      assert Day09.State.move_tail({1, 0}, {0, 0}) == {0, 0}
      assert Day09.State.move_tail({1, 1}, {0, 0}) == {0, 0}
      assert Day09.State.move_tail({0, 1}, {0, 0}) == {0, 0}
    end

    test "tail moves on axes to keep up" do
      assert Day09.State.move_tail({2, 0}, {0, 0}) == {1, 0}
      assert Day09.State.move_tail({0, 2}, {0, 0}) == {0, 1}
      assert Day09.State.move_tail({0, -2}, {0, 0}) == {0, -1}
      assert Day09.State.move_tail({-2, 0}, {0, 0}) == {-1, 0}
    end
  end
end
