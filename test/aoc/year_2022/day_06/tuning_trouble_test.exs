defmodule Aoc.Year2022.Day06.TuningTroubleTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2022.Day06.TuningTrouble, import: true

  alias Aoc.Year2022.Day06.TuningTrouble, as: Day06

  describe "part_1/1" do
    test "examples" do
      assert Day06.part_1("mjqjpqmgbljsphdztnvjfqwrcgsmlb") == 7
      assert Day06.part_1("bvwbjplbgvbhsrlpgdmjqwftvncz") == 5
      assert Day06.part_1("nppdvjthqldpwncqszvftbrmjlhg") == 6
      assert Day06.part_1("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg") == 10
      assert Day06.part_1("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw") == 11
    end

    @tag day: 06, year: 2022
    test "input", %{input: input} do
      assert input |> Day06.part_1() == 1
    end
  end

  describe "part_2/1" do
    test "examples" do
    end

    @tag day: 06, year: 2022
    test "input", %{input: input} do
      assert input |> Day06.part_2() == input
    end
  end
end
