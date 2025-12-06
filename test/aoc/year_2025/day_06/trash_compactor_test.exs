defmodule Aoc.Year2025.Day06.TrashCompactorTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2025.Day06.TrashCompactor, import: true

  alias Aoc.Year2025.Day06.TrashCompactor, as: Day06

  @example """
  123 328  51 64
   45 64  387 23
    6 98  215 314
  *   +   *   +
  """

  describe "Parser.parse/1" do
    test "examples" do
      assert Day06.Parser.parse(@example) == [
               {:*, [123, 45, 6]},
               {:+, [328, 64, 98]},
               {:*, [51, 387, 215]},
               {:+, [64, 23, 314]}
             ]
    end
  end

  describe "part_1/1" do
    test "examples" do
      assert Day06.part_1(@example) == 4_277_556
    end

    @tag day: 06, year: 2025
    test "input", %{input: input} do
      assert input |> Day06.part_1() == 5_524_274_308_182
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert Day06.part_2(@example) == 3_263_827
    end

    @tag day: 06, year: 2025
    test "input", %{input: input} do
      assert input |> Day06.part_2() == 8_843_673_199_391
    end
  end
end
