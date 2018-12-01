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
      assert ChronalCalibration.part_2("+1 -1") == 0
      assert ChronalCalibration.part_2("+3 +3 +4 -2 -4") == 10
      assert ChronalCalibration.part_2("-6 +3 +8 +5 -6") == 5
      assert ChronalCalibration.part_2("+7 +7 -2 -7 -4") == 14
    end

    @tag day: 01, year: 2018
    test "input", %{input: input} do
      assert input |> ChronalCalibration.part_2() == 563
    end
  end
end
