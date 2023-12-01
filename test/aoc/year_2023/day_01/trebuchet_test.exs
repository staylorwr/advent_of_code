defmodule Aoc.Year2023.Day01.TrebuchetTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2023.Day01.Trebuchet, import: true

  alias Aoc.Year2023.Day01.Trebuchet, as: Day01

  describe "part_1/1" do
    test "examples" do
      example = [
        "1abc2",
        "pqr3stu8vwx",
        "a1b2c3d4e5f",
        "treb7uchet"
      ]

      assert Day01.part_1(example) == 142
    end

    @tag day: 01, year: 2023, as_lines: true
    test "input", %{input: input} do
      assert input |> Day01.part_1() == 54667
    end
  end

  describe "part_2/1" do
    test "examples" do
      example = [
        "two1nine",
        "eightwothree",
        "abcone2threexyz",
        "xtwone3four",
        "4nineeightseven2",
        "zoneight234",
        "7pqrstsixteen"
      ]

      assert Day01.part_2(example) == 281
    end

    @tag day: 01, year: 2023, as_lines: true
    test "input", %{input: input} do
      assert input |> Day01.part_2() == 54203
    end
  end
end
