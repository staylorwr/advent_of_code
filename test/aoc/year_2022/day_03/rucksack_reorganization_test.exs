defmodule Aoc.Year2022.Day03.RucksackReorganizationTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2022.Day03.RucksackReorganization, import: true

  alias Aoc.Year2022.Day03.RucksackReorganization, as: Day03

  @example """
  vJrwpWtwJgWrhcsFMMfFFhFp
  jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
  PmmdzqPrVvPwwTWBwg
  wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
  ttgJtRGJQctTZtZT
  CrZsJsPPZsGzwwsLwLmpwMDw
  """

  describe "part_1/1" do
    test "examples" do
      assert Day03.part_1(@example) == 157
    end

    @tag day: 03, year: 2022
    test "input", %{input: input} do
      assert input |> Day03.part_1() == 7872
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert Day03.part_2(@example) == 70
    end

    @tag day: 03, year: 2022
    test "input", %{input: input} do
      assert input |> Day03.part_2() == 2497
    end
  end
end
