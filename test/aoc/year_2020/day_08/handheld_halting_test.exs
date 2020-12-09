defmodule Aoc.Year2020.Day08.HandheldHaltingTest do
  use Aoc.DayCase
  doctest Aoc.Year2020.Day08.HandheldHalting, import: true

  alias Aoc.Year2020.Day08.HandheldHalting, as: Day08

  @example """
  nop +0
  acc +1
  jmp +4
  acc +3
  jmp -3
  acc -99
  acc +1
  jmp -4
  acc +6
  """

  describe "part_1/1" do
    test "examples" do
      assert Day08.part_1(@example) == 5
    end

    @tag day: 08, year: 2020
    test "input", %{input: input} do
      assert input |> Day08.part_1() == 1217
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert Day08.part_2(@example) == 8
    end

    @tag day: 08, year: 2020
    test "input", %{input: input} do
      assert input |> Day08.part_2() == 501
    end
  end
end
