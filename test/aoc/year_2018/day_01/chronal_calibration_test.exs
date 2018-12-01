defmodule Aoc.Year2018.Day01.ChronalCalibrationTest do
  use Aoc.DayCase
  doctest Aoc.Year2018.Day01.ChronalCalibration, import: true

  alias Aoc.Year2018.Day01.ChronalCalibration

  describe "part_1/1" do
    test "examples" do
      assert ChronalCalibration.part_1("+1 +1 +1") == 3
      assert ChronalCalibration.part_1("+1 +1 -2") == 0
      assert ChronalCalibration.part_1("-1 -2 -3") == -6
    end

    @tag day: 01, year: 2018
    test "input", %{input: input} do
      assert input |> ChronalCalibration.part_1() == 561
    end
  end

  describe "part_2/1" do
    test "examples" do
    end

    @tag day: 01, year: 2018
    test "input", %{input: input} do
      assert input |> ChronalCalibration.part_2() == input
    end
  end
end
