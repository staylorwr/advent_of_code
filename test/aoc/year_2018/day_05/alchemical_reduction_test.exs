defmodule Aoc.Year2018.Day05.AlchemicalReductionTest do
  use Aoc.DayCase
  doctest Aoc.Year2018.Day05.AlchemicalReduction, import: true

  alias Aoc.Year2018.Day05.AlchemicalReduction

  @example "dabAcCaCBAcCcaDA"

  describe "part_1/1" do
    test "examples" do
      assert AlchemicalReduction.part_1(@example) == 10
    end

    @tag day: 05, year: 2018
    test "input", %{input: input} do
      assert input |> AlchemicalReduction.part_1() == 9172
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert AlchemicalReduction.part_2(@example) == 4
    end

    @tag day: 05, year: 2018
    test "input", %{input: input} do
      assert input |> AlchemicalReduction.part_2() == 6550
    end
  end
end
