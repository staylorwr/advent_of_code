defmodule Aoc.Year2025.Day01.SecretEntranceTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2025.Day01.SecretEntrance, import: true

  alias Aoc.Year2025.Day01.SecretEntrance, as: Day01

  @example """
  L68
  L30
  R48
  L5
  R60
  L55
  L1
  L99
  R14
  L82
  """

  describe "part_1/1" do
    test "examples" do
      assert Day01.part_1(@example) == 3
    end

    @tag day: 01, year: 2025
    test "input", %{input: input} do
      assert input |> Day01.part_1() == 992
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert Day01.part_2(@example) == 6
    end

    @tag day: 01, year: 2025
    test "input", %{input: input} do
      assert input |> Day01.part_2() == input
    end
  end
end
