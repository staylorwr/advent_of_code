defmodule Aoc.Year2021.Day06.LanternfishTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2021.Day06.Lanternfish, import: true

  alias Aoc.Year2021.Day06.Lanternfish, as: Day06

  describe "part_1/1" do
    @tag day: 06, year: 2021
    test "input", %{input: input} do
      assert input |> Day06.part_1(80) == 391_671
      assert input |> Day06.part_1(256) == 1_754_000_560_399
    end
  end
end
