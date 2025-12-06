defmodule Aoc.Year2025.Day05.CafeteriaTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2025.Day05.Cafeteria, import: true

  alias Aoc.Year2025.Day05.Cafeteria, as: Day05

  @example """
  3-5
  10-14
  16-20
  12-18

  1
  5
  8
  11
  17
  32
  """

  describe "part_1/1" do
    test "examples" do
      assert Day05.part_1(@example) == 3
    end

    @tag day: 05, year: 2025
    test "input", %{input: input} do
      assert input |> Day05.part_1() == 652
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert Day05.part_2(@example) == 14
    end

    @tag day: 05, year: 2025
    test "input", %{input: input} do
      assert input |> Day05.part_2() == 341_753_674_214_273
    end
  end
end
