defmodule Aoc.Year2018.Day12.SubterraneanSustainabilityTest do
  use Aoc.DayCase
  doctest Aoc.Year2018.Day12.SubterraneanSustainability, import: true

  alias Aoc.Year2018.Day12.SubterraneanSustainability

  @example """
  initial state: #..#.#..##......###...###

  ...## => #
  ..#.. => #
  .#... => #
  .#.#. => #
  .#.## => #
  .##.. => #
  .#### => #
  #.#.# => #
  #.### => #
  ##.#. => #
  ##.## => #
  ###.. => #
  ###.# => #
  ####. => #
  """

  describe "new/1" do
    test "parses input initial state and patterns" do
      expected = %SubterraneanSustainability{
        generation: {0, 20},
        patterns: [
          "...##",
          "..#..",
          ".#...",
          ".#.#.",
          ".#.##",
          ".##..",
          ".####",
          "#.#.#",
          "#.###",
          "##.#.",
          "##.##",
          "###..",
          "###.#",
          "####."
        ],
        pots: "#..#.#..##......###...###",
        total: 145,
        view: {-3, 36}
      }

      assert ^expected = SubterraneanSustainability.new(@example)
    end
  end

  describe "part_1/1" do
    test "examples" do
    end

    @tag day: 12, year: 2018
    test "input", %{input: input} do
      assert input |> SubterraneanSustainability.part_1() == input
    end
  end

  describe "part_2/1" do
    test "examples" do
    end

    @tag day: 12, year: 2018
    test "input", %{input: input} do
      assert input |> SubterraneanSustainability.part_2() == input
    end
  end
end
