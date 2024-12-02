defmodule Aoc.Year2024.Day01.HistorianHysteriaTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2024.Day01.HistorianHysteria, import: true

  alias Aoc.Year2024.Day01.HistorianHysteria, as: Day01

  @example """
  3   4
  4   3
  2   5
  1   3
  3   9
  3   3
  """

  describe "total_sorted_distance/1" do
    test "examples" do
      assert Day01.total_sorted_distance(@example) == 11
    end

    @tag day: 01, year: 2024
    test "input", %{input: input} do
      assert input |> Day01.total_sorted_distance() == 1_879_048
    end
  end

  describe "similarity_score/1" do
    test "examples" do
      assert Day01.similarity_score(@example) == 31
    end

    @tag day: 01, year: 2024
    test "input", %{input: input} do
      assert input |> Day01.similarity_score() == 21_024_792
    end
  end
end
