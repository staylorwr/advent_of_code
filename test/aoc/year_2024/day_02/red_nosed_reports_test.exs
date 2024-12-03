defmodule Aoc.Year2024.Day02.RedNosedReportsTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2024.Day02.RedNosedReports, import: true

  alias Aoc.Year2024.Day02.RedNosedReports, as: Day02

  @example """
  7 6 4 2 1
  1 2 7 8 9
  9 7 6 2 1
  1 3 2 4 5
  8 6 4 4 1
  1 3 6 7 9
  """

  describe "count_safe/1" do
    test "examples" do
      assert Day02.count_safe(@example) == 2
    end

    @tag day: 02, year: 2024
    test "input", %{input: input} do
      assert input |> Day02.count_safe() == 631
    end
  end

  describe "dampened_safe/1" do
    test "examples" do
      assert Day02.dampened_safe(@example) == 4
    end

    @tag day: 02, year: 2024
    test "input", %{input: input} do
      assert input |> Day02.dampened_safe() == 665
    end
  end
end
