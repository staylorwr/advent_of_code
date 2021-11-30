defmodule Aoc.Year2020.Day10.AdapterArrayTest do
  use Aoc.DayCase
  doctest Aoc.Year2020.Day10.AdapterArray, import: true

  alias Aoc.Year2020.Day10.AdapterArray, as: Day10

  @example [
    28,
    33,
    18,
    42,
    31,
    14,
    46,
    20,
    48,
    47,
    24,
    23,
    49,
    45,
    19,
    38,
    39,
    11,
    1,
    32,
    25,
    35,
    8,
    17,
    7,
    9,
    4,
    2,
    34,
    10,
    3
  ]

  @small_example [
    16,
    10,
    15,
    5,
    1,
    11,
    7,
    19,
    6,
    12,
    4
  ]

  describe "part_1/1" do
    test "examples" do
      assert Day10.part_1(@example) == 220
    end

    @tag day: 10, year: 2020, as_int_list: true
    test "input", %{input: input} do
      assert input |> Day10.part_1() == input
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert Day10.part_2(@small_example) == 8
    end

    @tag day: 10, year: 2020, as_int_list: true
    test "input", %{input: input} do
      assert input |> Day10.part_2() == input
    end
  end
end
