defmodule Aoc.Year2022.Day08.TreetopTreeHouseTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2022.Day08.TreetopTreeHouse, import: true

  alias Aoc.Year2022.Day08.TreetopTreeHouse, as: Day08

  @example """
  30373
  25512
  65332
  33549
  35390
  """

  describe "part_1/1" do
    test "examples" do
      assert Day08.part_1(@example) == 21
    end

    @tag day: 08, year: 2022
    test "input", %{input: input} do
      assert input |> Day08.part_1() == 1679
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert Day08.part_2(@example) == 8
    end

    @tag day: 08, year: 2022
    test "input", %{input: input} do
      assert input |> Day08.part_2() == 536_625
    end
  end

  describe "Part2.score_for_point" do
    test "returns values from example" do
      state = @example |> Day08.Parser.parse() |> Day08.State.new()

      result =
        ~w(north east south west)a
        |> Enum.map(fn dir ->
          {dir, Day08.Part2.score_for_point(dir, {{2, 3}, 5}, state)}
        end)

      assert [north: 2, east: 2, south: 1, west: 2] == result

      result =
        ~w(north east south west)a
        |> Enum.map(fn dir ->
          {dir, Day08.Part2.score_for_point(dir, {{2, 1}, 5}, state)}
        end)

      assert [north: 1, east: 2, south: 2, west: 1] == result
    end
  end
end
