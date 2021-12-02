defmodule Aoc.Year2021.Day02.DiveTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2021.Day02.Dive, import: true

  alias Aoc.Year2021.Day02.Dive, as: Day02

  @example [
    "forward 5",
    "down 5",
    "forward 8",
    "up 3",
    "down 8",
    "forward 2"
  ]

  describe "part_1/1" do
    test "returns the final depth and distance traveled" do
      assert %{depth: 10, distance: 15} == Day02.part_1(@example)
    end

    @tag day: 02, year: 2021, as_lines: true
    test "input", %{input: input} do
      assert input |> Day02.part_1() == %{depth: 741, distance: 1998}
    end
  end

  describe "part_2/1" do
    test "examples" do
    end

    @tag day: 02, year: 2021
    test "input", %{input: input} do
      assert input |> Day02.part_2() == input
    end
  end
end
