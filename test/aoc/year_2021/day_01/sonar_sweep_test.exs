defmodule Aoc.Year2021.Day01.SonarSweepTest do
  use Aoc.DayCase
  doctest Aoc.Year2021.Day01.SonarSweep, import: true

  alias Aoc.Year2021.Day01.SonarSweep, as: Day01

  describe "part_1/1" do
    @tag day: 01, year: 2021, as_int_list: true
    test "input", %{input: input} do
      assert input |> Day01.part_1() == 1548
    end
  end

  describe "part_2/1" do
    @tag day: 01, year: 2021, as_int_list: true
    test "input", %{input: input} do
      assert input |> Day01.part_2() == 1589
    end
  end
end
