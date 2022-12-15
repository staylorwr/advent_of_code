defmodule Aoc.Year2022.Day13.DistressSignalTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2022.Day13.DistressSignal, import: true

  alias Aoc.Year2022.Day13.DistressSignal, as: Day13

  @example """
  [1,1,3,1,1]
  [1,1,5,1,1]

  [[1],[2,3,4]]
  [[1],4]

  [9]
  [[8,7,6]]

  [[4,4],4,4]
  [[4,4],4,4,4]

  [7,7,7,7]
  [7,7,7]

  []
  [3]

  [[[]]]
  [[]]

  [1,[2,[3,[4,[5,6,7]]]],8,9]
  [1,[2,[3,[4,[5,6,0]]]],8,9]

  """

  describe "part_1/1" do
    test "examples" do
      assert Day13.part_1(@example) == 13
    end

    @tag day: 13, year: 2022
    test "input", %{input: input} do
      assert input |> Day13.part_1() == 6086
    end

    test "ord?/2" do
      assert Day13.Part1.ord?(1, 3)
      refute Day13.Part1.ord?(3, 1)
      assert Day13.Part1.ord?(1, 1) == :continue
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert Day13.part_2(@example) == 140
    end

    @tag day: 13, year: 2022
    test "input", %{input: input} do
      assert input |> Day13.part_2() == 27930
    end
  end
end
