defmodule Aoc.Year2024.Day04.CeresSearchTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2024.Day04.CeresSearch, import: true

  alias Aoc.Year2024.Day04.CeresSearch, as: Day04

  @example """
  MMMSXXMASM
  MSAMXMSMSA
  AMXSXMAAMM
  MSAMASMSMX
  XMASAMXAMM
  XXAMMXXAMA
  SMSMSASXSS
  SAXAMASAAA
  MAMMMXMMMM
  MXMXAXMASX
  """

  @small_example """
  ..X...
  .SAMX.
  .A..A.
  XMAS.S
  .X....
  """

  describe "part_1/1" do
    test "examples" do
      assert Day04.part_1(@small_example) == 4
      assert Day04.part_1(@example) == 18
    end

    @tag day: 04, year: 2024
    test "input", %{input: input} do
      assert input |> Day04.part_1() == 2507
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert Day04.part_2(@example) == 9
    end

    @tag day: 04, year: 2024
    test "input", %{input: input} do
      assert input |> Day04.part_2() == input
    end
  end
end
