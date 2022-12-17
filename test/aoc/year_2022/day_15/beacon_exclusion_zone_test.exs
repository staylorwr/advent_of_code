defmodule Aoc.Year2022.Day15.BeaconExclusionZoneTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2022.Day15.BeaconExclusionZone, import: true

  alias Aoc.Year2022.Day15.BeaconExclusionZone, as: Day15

  @example """
  Sensor at x=2, y=18: closest beacon is at x=-2, y=15
  Sensor at x=9, y=16: closest beacon is at x=10, y=16
  Sensor at x=13, y=2: closest beacon is at x=15, y=3
  Sensor at x=12, y=14: closest beacon is at x=10, y=16
  Sensor at x=10, y=20: closest beacon is at x=10, y=16
  Sensor at x=14, y=17: closest beacon is at x=10, y=16
  Sensor at x=8, y=7: closest beacon is at x=2, y=10
  Sensor at x=2, y=0: closest beacon is at x=2, y=10
  Sensor at x=0, y=11: closest beacon is at x=2, y=10
  Sensor at x=20, y=14: closest beacon is at x=25, y=17
  Sensor at x=17, y=20: closest beacon is at x=21, y=22
  Sensor at x=16, y=7: closest beacon is at x=15, y=3
  Sensor at x=14, y=3: closest beacon is at x=15, y=3
  Sensor at x=20, y=1: closest beacon is at x=15, y=3
  """

  describe "part_1/1" do
    test "examples" do
      assert Day15.part_1(@example, 10) == 26
    end

    @tag day: 15, year: 2022
    test "input", %{input: input} do
      assert input |> Day15.part_1(2_000_000) == 4_424_278
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert Day15.part_2(@example, 20) == 56_000_011
    end

    @tag day: 15, year: 2022
    test "input", %{input: input} do
      assert input |> Day15.part_2(4_000_000) == 10_382_630_753_392
    end
  end

  describe "Sensor" do
    test "new/1" do
      assert Day15.Sensor.new({2, 18, -2, 15}) == %Day15.Sensor{
               center: {2, 18},
               closest_beacon: {-2, 15},
               distance: 7
             }
    end

    test "in_range_at/2" do
      sensor = Day15.Sensor.new({0, 0, 4, 0})
      assert sensor.distance == 4

      assert Day15.Sensor.in_range_at(sensor, 5) == []
      assert Day15.Sensor.in_range_at(sensor, -6) == []
      assert Day15.Sensor.in_range_at(sensor, 4) == [{0, 4}]
      assert Day15.Sensor.in_range_at(sensor, 3) == [{-1, 3}, {0, 3}, {1, 3}]
    end

    test "points_at_distance" do
      assert Day15.Sensor.points_at_distance({0, 0}, 1) ==
               MapSet.new([{1, 0}, {0, 1}, {-1, 0}, {0, -1}])

      if false, do: graph(Day15.Sensor.points_at_distance({1, 0}, 4))

      sizes =
        Enum.map(1..5, fn x ->
          {0, 0}
          |> Day15.Sensor.points_at_distance(x)
          |> MapSet.size()
        end)

      assert sizes == [4, 8, 12, 16, 20]
    end

    test "points_at_distance with offset centers" do
      offset_sensor = Day15.Sensor.points_at_distance({2, 2}, 4)
      assert MapSet.member?(offset_sensor, {5, 3})
    end

    defp graph(perim) do
      for y <- 20..-20 do
        part =
          for x <- -20..20 do
            cond do
              MapSet.member?(perim, {x, y}) -> "X"
              {x, y} == {0, 0} -> "O"
              true -> " "
            end
          end

        IO.puts(part)
      end
    end
  end
end
