defmodule Aoc.Year2020.Day05.BinaryBoardingTest do
  use Aoc.DayCase
  doctest Aoc.Year2020.Day05.BinaryBoarding, import: true

  alias Aoc.Year2020.Day05.BinaryBoarding, as: Day05
  alias Aoc.Year2020.Day05.Seat

  @example """
  BFFFBBFRRR
  FFFBBBFRRR
  BBFFBBFRLL
  """

  describe "part_1/1" do
    test "examples" do
      assert Seat.new("FBFBBFFRLR") == %Seat{
               row: 44,
               seat: 5,
               score: 357
             }

      assert Day05.part_1(@example) == %Seat{row: 102, seat: 4, score: 820}
    end

    @tag day: 05, year: 2020
    test "input", %{input: input} do
      assert input |> Day05.part_1() == %Seat{row: 120, score: 965, seat: 5}
    end
  end

  describe "part_2/1" do
    @tag day: 05, year: 2020
    test "input", %{input: input} do
      assert input |> Day05.part_2() == 524
    end
  end
end
