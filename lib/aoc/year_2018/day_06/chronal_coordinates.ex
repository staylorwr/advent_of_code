defmodule Aoc.Year2018.Day06.ChronalCoordinates do
  @moduledoc """
  ## --- Day 6: Chronal Coordinates ---

  The device on your wrist beeps several times, and once again you feel like
  you're falling.

  "Situation critical," the device announces. "Destination indeterminate. Chronal
  interference detected. Please specify new target coordinates."

  The device then produces a list of coordinates (your puzzle input). Are they
  places it thinks are safe or dangerous? It recommends you check manual page 729.
  The Elves did not give you a manual.

  *If they're dangerous,* maybe you can minimize the danger by finding the
  coordinate that gives the largest distance from the other points.

  Using only the Manhattan distance, determine the *area* around each coordinate
  by counting the number of integer X,Y locations that are *closest* to that
  coordinate (and aren't *tied in distance* to any other coordinate).

  Your goal is to find the size of the *largest area* that isn't infinite. For
  example, consider the following list of coordinates:

  ```
  1, 1
  1, 6
  8, 3
  3, 4
  5, 5
  8, 9
  ```
  If we name these coordinates `A` through `F`, we can draw them on a grid,
  putting `0,0` at the top left:

  ```
  ..........
  .A........
  ..........
  ........C.
  ...D......
  .....E....
  .B........
  ..........
  ..........
  ........F.
  ```

  This view is partial - the actual grid extends infinitely in all directions.
  Using the Manhattan distance, each location's closest coordinate can be
  determined, shown here in lowercase:

  ```
  aaaaa.cccc
  a*A*aaa.cccc
  aaaddecccc
  aadddecc*C*c
  ..d*D*deeccc
  bb.de*E*eecc
  b*B*b.eeee..
  bbb.eeefff
  bbb.eeffff
  bbb.ffff*F*f
  ```

  Locations shown as `.` are equally far from two or more coordinates, and so they
  don't count as being closest to any.

  In this example, the areas of coordinates A, B, C, and F are infinite - while
  not shown here, their areas extend forever outside the visible grid. However,
  the areas of coordinates D and E are finite: D is closest to 9 locations, and E
  is closest to 17 (both including the coordinate's location itself). Therefore,
  in this example, the size of the largest area is *17*.

  *What is the size of the largest area* that isn't infinite?

  ## --- Part Two ---

  On the other hand, *if the coordinates are safe*, maybe the best you can do is
  try to find a *region* near as many coordinates as possible.

  For example, suppose you want the sum of the Manhattan distance to all of the
  coordinates to be *less than 32*. For each location, add up the distances to all
  of the given coordinates; if the total of those distances is less than 32, that
  location is within the desired region. Using the same coordinates as above, the
  resulting region looks like this:

  ```
  ..........
  .A........
  ..........
  ...#*#*#..C.
  ..#D###...
  ..###E#...
  .B.###....
  ..........
  ..........
  ........F.
  ```

  In particular, consider the highlighted location `4,3` located at the top middle
  of the region. Its calculation is as follows, where `abs()` is the absolute
  value function:

  - Distance to coordinate A: `abs(4-1) + abs(3-1) =  5`
  - Distance to coordinate B: `abs(4-1) + abs(3-6) =  6`
  - Distance to coordinate C: `abs(4-8) + abs(3-3) =  4`
  - Distance to coordinate D: `abs(4-3) + abs(3-4) =  2`
  - Distance to coordinate E: `abs(4-5) + abs(3-5) =  3`
  - Distance to coordinate F: `abs(4-8) + abs(3-9) = 10`
  - Total distance: `5 + 6 + 4 + 2 + 3 + 10 = 30`

  Because the total distance to all coordinates (`30`) is less than 32, the
  location is *within* the region.

  This region, which also includes coordinates D and E, has a total size of *16*.

  Your actual region will need to be much larger than this example, though,
  instead including all locations with a total distance of less than *10000*.

  *What is the size of the region containing all locations which have a total
  distance to all given coordinates of less than 10000?*
  """

  @doc """
  Returns the largest finite area for one coordinate.
  """
  def part_1(input) do
    coordinates = parse_coordinates(input)
    {x_range, y_range} = bounding_box(coordinates)

    closest_grid = closest_grid(coordinates, x_range, y_range)
    infinite_coordinates = infinite_coordinates(closest_grid, x_range, y_range)

    finite_count =
      Enum.reduce(closest_grid, %{}, fn {_, coordinate}, acc ->
        if coordinate == nil or coordinate in infinite_coordinates do
          acc
        else
          Map.update(acc, coordinate, 1, &(&1 + 1))
        end
      end)

    {_coordinate, count} = Enum.max_by(finite_count, fn {_coordinate, count} -> count end)

    count
  end

  @doc """
  Builds a sum grid, calculating the number of points within a maximum total distance of all points.
  """
  def part_2(input, maximum_distance) do
    coordinates = parse_coordinates(input)
    {x_range, y_range} = bounding_box(coordinates)

    x_range
    |> Task.async_stream(&accumulate_distances(&1, y_range, coordinates, maximum_distance))
    |> Enum.reduce(0, fn {:ok, count}, acc -> count + acc end)
  end

  defp accumulate_distances(x, y_range, coordinates, maximum_distance) do
    Enum.reduce(y_range, 0, fn y, count ->
      point = {x, y}
      if sum_distances(coordinates, point) < maximum_distance, do: count + 1, else: count
    end)
  end

  defp sum_distances(coordinates, point) do
    coordinates
    |> Enum.map(&manhattan_distance(&1, point))
    |> Enum.sum()
  end

  @doc """
  ## Examples

      iex> parse_coordinate("1, 3")
      {1, 3}
  """
  def parse_coordinate(str) when is_binary(str) do
    [x, y] = String.split(str, ", ")
    {String.to_integer(x), String.to_integer(y)}
  end

  def parse_coordinates(str) do
    str
    |> String.trim()
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_coordinate/1)
  end

  @doc """
  Gets the bounding box for a list of coordinates.
      iex> bounding_box([
      ...>   {1, 1},
      ...>   {1, 6},
      ...>   {8, 3},
      ...>   {3, 4},
      ...>   {5, 5},
      ...>   {8, 9}
      ...> ])
      {1..8, 1..9}
  """
  def bounding_box(coordinates) do
    {{min_x, _}, {max_x, _}} = Enum.min_max_by(coordinates, &elem(&1, 0))
    {{_, min_y}, {_, max_y}} = Enum.min_max_by(coordinates, &elem(&1, 1))
    {min_x..max_x, min_y..max_y}
  end

  @doc """
      iex> closest_grid([{1, 1}, {3, 3}], 1..3, 1..3)
      %{
        {1, 1} => {1, 1},
        {1, 2} => {1, 1},
        {1, 3} => nil,
        {2, 1} => {1, 1},
        {2, 2} => nil,
        {2, 3} => {3, 3},
        {3, 1} => nil,
        {3, 2} => {3, 3},
        {3, 3} => {3, 3}
      }
  """
  def closest_grid(coordinates, x_range, y_range) do
    for x <- x_range,
        y <- y_range,
        point = {x, y},
        do: {point, classify_point(coordinates, point)},
        into: %{}
  end

  defp classify_point(coordinates, point) do
    coordinates
    |> Enum.map(&{manhattan_distance(&1, point), &1})
    |> Enum.sort()
    |> case do
      [{0, coordinate} | _] -> coordinate
      [{distance, _}, {distance, _} | _] -> nil
      [{_, coordinate} | _] -> coordinate
    end
  end

  @doc """
  Returns coordinates that to go infinity.
      iex> grid = closest_grid([{1, 1}, {3, 3}, {5, 5}], 1..5, 1..5)
      iex> set = infinite_coordinates(grid, 1..5, 1..5)
      iex> Enum.sort(set)
      [{1, 1}, {5, 5}]
  """
  def infinite_coordinates(closest_grid, x_range, y_range) do
    infinite_for_x =
      for y <- [y_range.first, y_range.last],
          x <- x_range,
          closest = closest_grid[{x, y}],
          do: closest

    infinite_for_y =
      for x <- [x_range.first, x_range.last],
          y <- y_range,
          closest = closest_grid[{x, y}],
          do: closest

    MapSet.new(infinite_for_x ++ infinite_for_y)
  end

  defp manhattan_distance({x1, y1}, {x2, y2}) do
    abs(x1 - x2) + abs(y1 - y2)
  end
end
