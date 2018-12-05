defmodule Aoc.Year2018.Day04.ReposeRecordTest do
  use Aoc.DayCase
  doctest Aoc.Year2018.Day04.ReposeRecord, import: true

  alias Aoc.Year2018.Day04.ReposeRecord

  @example """
  [1518-11-01 00:00] Guard #10 begins shift
  [1518-11-01 00:05] falls asleep
  [1518-11-01 00:25] wakes up
  [1518-11-01 00:30] falls asleep
  [1518-11-01 00:55] wakes up
  [1518-11-01 23:58] Guard #99 begins shift
  [1518-11-02 00:40] falls asleep
  [1518-11-02 00:50] wakes up
  [1518-11-03 00:05] Guard #10 begins shift
  [1518-11-03 00:24] falls asleep
  [1518-11-03 00:29] wakes up
  [1518-11-04 00:02] Guard #99 begins shift
  [1518-11-04 00:36] falls asleep
  [1518-11-04 00:46] wakes up
  [1518-11-05 00:03] Guard #99 begins shift
  [1518-11-05 00:45] falls asleep
  [1518-11-05 00:55] wakes up
  """

  describe "part_1/1" do
    test "examples" do
      assert ReposeRecord.part_1(@example) == {10, 24}
    end

    @tag day: 04, year: 2018
    test "input", %{input: input} do
      assert input |> ReposeRecord.part_1() == {1439, 42}
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert ReposeRecord.part_2(@example) == {99, 45}
    end

    @tag day: 04, year: 2018
    test "input", %{input: input} do
      assert input |> ReposeRecord.part_2() == {1297, 37}
    end
  end
end
