defmodule Aoc.Year2022.Day16.ProboscideaVolcaniumTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2022.Day16.ProboscideaVolcanium, import: true

  alias Aoc.Year2022.Day16.ProboscideaVolcanium, as: Day16

  @example """
  Valve AA has flow rate=0; tunnels lead to valves DD, II, BB
  Valve BB has flow rate=13; tunnels lead to valves CC, AA
  Valve CC has flow rate=2; tunnels lead to valves DD, BB
  Valve DD has flow rate=20; tunnels lead to valves CC, AA, EE
  Valve EE has flow rate=3; tunnels lead to valves FF, DD
  Valve FF has flow rate=0; tunnels lead to valves EE, GG
  Valve GG has flow rate=0; tunnels lead to valves FF, HH
  Valve HH has flow rate=22; tunnel leads to valve GG
  Valve II has flow rate=0; tunnels lead to valves AA, JJ
  Valve JJ has flow rate=21; tunnel leads to valve II
  """

  describe "part_1/1" do
    test "examples" do
      assert Day16.part_1(@example) == 1651
    end

    @tag day: 16, year: 2022
    test "input", %{input: input} do
      assert input |> Day16.part_1() == 1595
    end
  end

  describe "part_2/1" do
    @tag day: 16, year: 2022
    test "input", %{input: input} do
      assert input |> Day16.part_2() == 2189
    end
  end

  describe "Parser" do
    test "translates input into a graph and a map of values" do
      result = Day16.Parser.parse(@example)
      assert result
    end
  end
end
