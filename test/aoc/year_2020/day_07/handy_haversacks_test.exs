defmodule Aoc.Year2020.Day07.HandyHaversacksTest do
  use Aoc.DayCase
  doctest Aoc.Year2020.Day07.HandyHaversacks, import: true

  alias Aoc.Year2020.Day07.HandyHaversacks, as: Day07

  @example """
  light red bags contain 1 bright white bag, 2 muted yellow bags.
  dark orange bags contain 3 bright white bags, 4 muted yellow bags.
  bright white bags contain 1 shiny gold bag.
  muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
  shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
  dark olive bags contain 3 faded blue bags, 4 dotted black bags.
  vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
  faded blue bags contain no other bags.
  dotted black bags contain no other bags.
  """

  @second """
  shiny gold bags contain 2 dark red bags.
  dark red bags contain 2 dark orange bags.
  dark orange bags contain 2 dark yellow bags.
  dark yellow bags contain 2 dark green bags.
  dark green bags contain 2 dark blue bags.
  dark blue bags contain 2 dark violet bags.
  dark violet bags contain no other bags.
  """

  describe "part_1/1" do
    test "examples" do
      assert Day07.part_1(@example) == 4
    end

    @tag day: 07, year: 2020
    test "input", %{input: input} do
      assert input |> Day07.part_1() == 248
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert Day07.part_2(@second) == 126
    end

    @tag day: 07, year: 2020
    test "input", %{input: input} do
      assert input |> Day07.part_2() == 57281
    end
  end

  test "parse" do
    assert Day07.parse("light red bags contain 1 bright white bag, 2 muted yellow bags.") == [
             {"light red", [{1, "bright white"}, {2, "muted yellow"}]}
           ]
  end
end
