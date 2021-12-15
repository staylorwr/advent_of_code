defmodule Aoc.Year2021.Day13.TransparentOrigamiTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2021.Day13.TransparentOrigami, import: true

  alias Aoc.Year2021.Day13.TransparentOrigami, as: Day13

  @example """
  6,10
  0,14
  9,10
  0,3
  10,4
  4,11
  6,0
  6,12
  4,1
  0,13
  10,12
  3,4
  3,0
  8,4
  1,10
  2,14
  8,10
  9,0

  fold along y=7
  fold along x=5
  """

  describe "part_1/1" do
    test "examples" do
      assert Day13.part_1(@example) == 17
    end

    @tag day: 13, year: 2021
    test "input", %{input: input} do
      assert input |> Day13.part_1() == 720
    end
  end

  describe "part_2/1" do
    @tag day: 13, year: 2021
    test "input", %{input: input} do
      assert Day13.part_2(input)
    end
  end
end
