defmodule Aoc.Year2021.Day07.TheTreacheryofWhalesTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2021.Day07.TheTreacheryofWhales, import: true

  alias Aoc.Year2021.Day07.TheTreacheryofWhales, as: Day07

  describe "part_1/1" do
    @tag day: 07, year: 2021
    test "input", %{input: input} do
      assert input |> Day07.part_1() == 352_707
    end
  end

  describe "part_2/1" do
    @tag day: 07, year: 2021
    test "input", %{input: input} do
      assert input |> Day07.part_2() == 95_519_693
    end
  end
end
