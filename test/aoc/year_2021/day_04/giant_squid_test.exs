defmodule Aoc.Year2021.Day04.GiantSquidTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2021.Day04.GiantSquid, import: true

  alias Aoc.Year2021.Day04.GiantSquid, as: Day04

  describe "part_1/1" do
    @tag day: 04, year: 2021
    test "input", %{input: input} do
      assert input |> Day04.part_1() == 38_913
    end
  end

  describe "part_2/1" do
    @tag day: 04, year: 2021
    test "input", %{input: input} do
      assert input |> Day04.part_2() == 16_836
    end
  end
end
