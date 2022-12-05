defmodule Aoc.Year2022.Day05.SupplyStacksTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2022.Day05.SupplyStacks, import: true

  alias Aoc.Year2022.Day05.SupplyStacks, as: Day05

  @example """
      [D]
  [N] [C]
  [Z] [M] [P]
   1   2   3

  move 1 from 2 to 1
  move 3 from 1 to 3
  move 2 from 2 to 1
  move 1 from 1 to 2
  """

  describe "part_1/1" do
    test "examples" do
      assert Day05.part_1(@example) == "CMZ"
    end

    @tag day: 05, year: 2022
    test "input", %{input: input} do
      assert input |> Day05.part_1() == "ABC"
    end
  end

  describe "part_2/1" do
    test "examples" do
    end

    @tag day: 05, year: 2022
    test "input", %{input: input} do
      assert input |> Day05.part_2() == input
    end
  end

  test "Parser.parse/1" do
    assert Day05.parse(@example) == %Day05.State{
             stacks: [
               ~w(N Z),
               ~w(D C M),
               ~w(P)
             ],
             instructions: [
               {1, 2, 1},
               {3, 1, 3},
               {2, 2, 1},
               {1, 1, 2}
             ]
           }
  end
end
