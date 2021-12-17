defmodule Aoc.Year2021.Day14.ExtendedPolymerizationTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2021.Day14.ExtendedPolymerization, import: true

  alias Aoc.Year2021.Day14.ExtendedPolymerization, as: Day14

  @example """
  NNCB

  CH -> B
  HH -> N
  CB -> H
  NH -> C
  HB -> C
  HC -> B
  HN -> C
  NN -> C
  BH -> H
  NC -> B
  NB -> B
  BN -> B
  BB -> N
  BC -> B
  CC -> N
  CN -> C
  """

  describe "react/1" do
    test "examples" do
      assert Day14.react(@example, 10) == 1588
      assert Day14.react(@example, 40) == 2_188_189_693_529
    end

    @tag day: 14, year: 2021
    test "input", %{input: input} do
      assert Day14.react(input, 10) == 2937
      assert Day14.react(input, 40) == 3_390_034_818_249
    end
  end
end
