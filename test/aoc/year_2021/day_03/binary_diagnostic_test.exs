defmodule Aoc.Year2021.Day03.BinaryDiagnosticTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2021.Day03.BinaryDiagnostic, import: true

  alias Aoc.Year2021.Day03.BinaryDiagnostic, as: Day03

  @example """
  00100
  11110
  10110
  10111
  10101
  01111
  00111
  11100
  10000
  11001
  00010
  01010
  """

  describe "part_1/1" do
    test "examples" do
      assert Day03.part_1(@example) == 198
    end

    @tag day: 03, year: 2021
    test "input", %{input: input} do
      assert input |> Day03.part_1() == 1_082_324
    end
  end

  describe "life_support_rating/1" do
    @tag day: 03, year: 2021
    test "input", %{input: input} do
      assert input |> Day03.parse() |> Day03.life_support_rating() == 1_353_024
    end
  end
end
