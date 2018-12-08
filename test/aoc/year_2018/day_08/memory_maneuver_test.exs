defmodule Aoc.Year2018.Day08.MemoryManeuverTest do
  use Aoc.DayCase
  doctest Aoc.Year2018.Day08.MemoryManeuver, import: true

  alias Aoc.Year2018.Day08.MemoryManeuver

  @example "2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2"

  describe "part_1/1" do
    test "examples" do
      assert MemoryManeuver.part_1(@example) == 138
    end

    @tag day: 08, year: 2018
    test "input", %{input: input} do
      assert input |> MemoryManeuver.part_1() == input
    end
  end

  describe "part_2/1" do
    test "examples" do
    end

    @tag day: 08, year: 2018
    test "input", %{input: input} do
      assert input |> MemoryManeuver.part_2() == input
    end
  end
end
