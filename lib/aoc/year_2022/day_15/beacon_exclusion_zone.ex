defmodule Aoc.Year2022.Day15.BeaconExclusionZone do
  alias __MODULE__.{Parser, Part1, Part2, Sensor}

  def part_1(input, y) do
    input
    |> Parser.parse()
    |> Part1.solve(y)
  end

  def part_2(input, max) do
    input
    |> Parser.parse()
    |> Part2.solve(max)
  end

  defmodule Part1 do
    def solve(sensors, y) do
      all_beacons = sensors |> Enum.map(& &1.closest_beacon) |> MapSet.new()

      sensors
      |> Enum.reduce(MapSet.new(), fn sensor, common_points ->
        MapSet.union(
          common_points,
          sensor |> Sensor.in_range_at(y) |> MapSet.new()
        )
      end)
      |> MapSet.difference(all_beacons)
      |> MapSet.size()
    end
  end

  defmodule Part2 do
    def solve(sensors, max) do
      indexed_sensors = Enum.with_index(sensors)
      {x, y} = solve(indexed_sensors, {sensors, max}, nil)
      x * 4_000_000 + y
    end

    def solve(_sensors, _context, solution) when not is_nil(solution), do: solution

    def solve([{sensor, i} | others], context, nil) do
      result =
        sensor
        |> run_sensor_perimeter(i, context)
        |> Enum.reject(&is_nil/1)
        |> Enum.at(0)

      solve(others, context, result)
    end

    def run_sensor_perimeter(sensor, i, {all_sensors, max}) do
      extended = Sensor.extended_perimeter(sensor)
      {_sensor, other_sensors} = List.pop_at(all_sensors, i)

      for pt <- extended,
          true == in_bounds?(pt, max) do
        on_perimeter_of =
          other_sensors
          |> Enum.filter(fn other ->
            Sensor.distance(other.center, pt) == other.distance + 1
          end)
          |> Enum.count()

        inside_of_one =
          Enum.any?(all_sensors, fn other ->
            Sensor.distance(other.center, pt) <= other.distance
          end)

        if on_perimeter_of >= 3 && !inside_of_one, do: pt, else: nil
      end
    end

    def in_bounds?({14, 11}, _), do: true
    def in_bounds?({x, y}, max), do: x >= 0 and x <= max and y >= 0 and y <= max
  end

  defmodule Sensor do
    @enforce_keys [:center, :distance]
    defstruct [:center, :closest_beacon, :distance]

    alias __MODULE__

    def new({bx, by, cx, cy}) do
      %Sensor{
        center: {bx, by},
        closest_beacon: {cx, cy},
        distance: distance({bx, by}, {cx, cy})
      }
    end

    def in_range_at(%Sensor{center: {cx, cy} = c, distance: dist}, y) do
      distance_from_center_to_y = abs(y - cy)

      if distance_from_center_to_y > dist do
        []
      else
        Range.new(cx - dist, cx + dist)
        |> Enum.map(&{&1, y})
        |> Enum.filter(fn point -> distance(point, c) <= dist end)
      end
    end

    @doc """
    The perimeter surrounding a center point {cx, cy} at manhattan distance d
    is composed of four lines:

    -  first quartile (A): y = -x + dist, where: x goes from cx+dist to cx
    - second quartile (B): y =  x + dist, where: x goes from cx-1 to cx-dist
    -  third quartile (C): y = -x - dist, where: x goes from cx-dist to cx
    - fourth quartile (D): y =  x - dist, where: x goes from cx+1 to cx+dist-1

    ie: the perimeter centered at the origin with a dist of 4


        x x x x x | x x x x x
                  |
        x x x x x A x x x x x
                  |
        x x x x B | A x x x x
                  |
        x x x B x | x A x x x
                  |
        x x B x x | x x A x x
                  |
        --B---------------A--
                  |
        x x C x x | x x D x x
                  |
        x x x C x | x D x x x
                  |
        x x x x C | D x x x x
                  |
        x x x x x C x x x x x
                  |
        x x x x x | x x x x x

    The union of the points representing these four lines is the perimeter
    """
    def points_at_distance({cx, cy}, dist) do
      line_a = for x <- dist..0, do: {x, dist - x}
      line_b = for x <- -1..-dist, do: {x, x + dist}
      line_c = for x <- -dist..0, do: {x, -x - dist}
      line_d = for x <- 1..(dist - 1), do: {x, x - dist}

      [line_a, line_b, line_c, line_d]
      |> List.flatten()
      |> Enum.map(fn {x, y} -> {cx + x, cy + y} end)
      |> MapSet.new()
    end

    def extended_perimeter(sensor) do
      points_at_distance(sensor.center, sensor.distance + 1)
    end

    def distance({ax, ay}, {bx, by}), do: abs(ax - bx) + abs(ay - by)

    def contains?(sensor, point) do
      distance(sensor.center, point) <= sensor.distance
    end
  end

  defmodule Parser do
    def parse(input) do
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&parse_line/1)
    end

    def parse_line(line) do
      line
      |> then(&Regex.scan(~r/-?\d+/, &1))
      |> List.flatten()
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()
      |> Sensor.new()
    end
  end
end
