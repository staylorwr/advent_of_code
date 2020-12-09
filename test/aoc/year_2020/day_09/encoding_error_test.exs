defmodule Aoc.Year2020.Day09.EncodingErrorTest do
  use Aoc.DayCase
  doctest Aoc.Year2020.Day09.EncodingError, import: true

  alias Aoc.Year2020.Day09.EncodingError, as: Day09

  @example [
    35,
    20,
    15,
    25,
    47,
    40,
    62,
    55,
    65,
    95,
    102,
    117,
    150,
    182,
    127,
    219,
    299,
    277,
    309,
    576
  ]

  describe "part_1/1" do
    test "examples" do
      assert Day09.part_1(@example, 5) == 127
    end

    @tag day: 09, year: 2020, as_int_list: true
    test "input", %{input: input} do
      assert input |> Day09.part_1() == 552_655_238
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert Day09.part_2(@example, 127) == 62
    end

    @tag day: 09, year: 2020, as_int_list: true
    test "input", %{input: input} do
      assert input |> Day09.part_2(552_655_238) == 70_672_245
    end
  end
end
