defmodule Aoc.Year2024.Day05.PrintQueueTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2024.Day05.PrintQueue, import: true

  alias Aoc.Year2024.Day05.PrintQueue, as: Day05

  @example """
  47|53
  97|13
  97|61
  97|47
  75|29
  61|13
  75|53
  29|13
  97|29
  53|29
  61|53
  97|53
  61|29
  47|13
  75|47
  97|75
  47|61
  75|61
  47|29
  75|13
  53|13

  75,47,61,53,29
  97,61,53,29,13
  75,29,13
  75,97,47,61,53
  61,13,29
  97,13,75,29,47
  """

  describe "part_1/1" do
    test "examples" do
      assert Day05.part_1(@example) == 143
    end

    @tag day: 05, year: 2024
    test "input", %{input: input} do
      assert input |> Day05.part_1() == input
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert Day05.part_2(@example) == 123
    end

    @tag day: 05, year: 2024
    test "input", %{input: input} do
      assert input |> Day05.part_2() == 6370
    end
  end
end
