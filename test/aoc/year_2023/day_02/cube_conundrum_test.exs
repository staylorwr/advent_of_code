defmodule Aoc.Year2023.Day02.CubeConundrumTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2023.Day02.CubeConundrum, import: true

  alias Aoc.Year2023.Day02.CubeConundrum, as: Day02

  @example """
  Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
  Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
  Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
  Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
  Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
  """

  @scenario %{red: 12, green: 13, blue: 14}

  describe "part_1/1" do
    test "examples" do
      assert Day02.part_1(@example, @scenario) == 8
    end

    @tag day: 02, year: 2023
    test "input", %{input: input} do
      assert input |> Day02.part_1(@scenario) == 2239
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert Day02.part_2(@example) == 2286
    end

    @tag day: 02, year: 2023
    test "input", %{input: input} do
      assert input |> Day02.part_2() == 83435
    end
  end

  describe "Parser.parse/1" do
    test "examples" do
      result =
        "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"
        |> Day02.Parser.parse()

      assert result == %{
               1 => [
                 %{blue: 3, red: 4},
                 %{blue: 6, green: 2, red: 1},
                 %{green: 2}
               ]
             }
    end
  end
end
