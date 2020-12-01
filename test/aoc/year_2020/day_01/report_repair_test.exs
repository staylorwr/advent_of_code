defmodule Aoc.Year2020.Day01.ReportRepairTest do
  use Aoc.DayCase
  doctest Aoc.Year2020.Day01.ReportRepair, import: true

  alias Aoc.Year2020.Day01.ReportRepair, as: Day01

  def ex_1,
    do:
      """
      1721
      979
      366
      299
      675
      1456
      """
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_integer/1)

  describe "part_1/1" do
    test "examples" do
      assert Day01.part_1(ex_1()) == 514_579
    end

    @tag day: 01, year: 2020, as_int_list: true
    test "input", %{input: input} do
      assert input |> Day01.part_1() == input
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert Day01.part_2(ex_1()) == 241_861_950
    end

    @tag day: 01, year: 2020, as_int_list: true
    test "input", %{input: input} do
      assert input |> Day01.part_2() == 278_064_990
    end
  end
end
