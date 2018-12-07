defmodule Aoc.Year2018.Day06.ChronalCoordinatesTest do
  use Aoc.DayCase
  doctest Aoc.Year2018.Day06.ChronalCoordinates, import: true

  alias Aoc.Year2018.Day06.ChronalCoordinates

  @input """
  1, 1
  1, 6
  8, 3
  3, 4
  5, 5
  8, 9
  """
  describe "part_1/1" do
    test "examples" do
      assert ChronalCoordinates.part_1(@input) == 17
    end

    @tag day: 06, year: 2018
    test "input", %{input: input} do
      assert input |> ChronalCoordinates.part_1() == 3006
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert ChronalCoordinates.part_2(@input, 32) == 16
    end

    @tag day: 06, year: 2018
    test "input", %{input: input} do
      assert ChronalCoordinates.part_2(input, 10_000) == 42998
    end
  end
end
