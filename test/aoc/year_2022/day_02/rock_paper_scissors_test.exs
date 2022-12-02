defmodule Aoc.Year2022.Day02.RockPaperScissorsTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2022.Day02.RockPaperScissors, import: true

  alias Aoc.Year2022.Day02.RockPaperScissors, as: Day02

  @example """
  A Y
  B X
  C Z
  """

  describe "part_1/1" do
    test "examples" do
      assert Day02.part_1(@example) == 15
    end

    @tag day: 02, year: 2022
    test "input", %{input: input} do
      assert input |> Day02.part_1() == 14531
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert Day02.part_2(@example) == 12
    end

    @tag day: 02, year: 2022
    test "input", %{input: input} do
      assert input |> Day02.part_2() == 11258
    end
  end
end
