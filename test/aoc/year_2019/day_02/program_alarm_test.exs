defmodule Aoc.Year2019.Day02.ProgramAlarmTest do
  use Aoc.DayCase
  doctest Aoc.Year2019.Day02.ProgramAlarm, import: true

  alias Aoc.Year2019.Day02.ProgramAlarm, as: Day02

  describe "part_1/1" do
    test "examples" do
    end

    @tag day: 02, year: 2019
    test "input", %{input: input} do
      assert input |> Day02.part_1() == input
    end
  end

  describe "part_2/1" do
    test "examples" do
    end

    @tag day: 02, year: 2019
    test "input", %{input: input} do
      assert input |> Day02.part_2() == input
    end
  end
end
