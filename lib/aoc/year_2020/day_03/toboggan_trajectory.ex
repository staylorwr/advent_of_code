defmodule Aoc.Year2020.Day03.TobogganTrajectory do
  @moduledoc """
  ## --- Day 3: Toboggan Trajectory ---

  With the toboggan login problems resolved, you set off toward the airport. While
  travel by toboggan might be easy, it's certainly not safe: there's very minimal
  steering and the area is covered in trees. You'll need to see which angles will
  take you near the fewest trees.

  Due to the local geology, trees in this area only grow on exact integer
  coordinates in a grid. You make a map (your puzzle input) of the open squares
  (`.`) and trees (`#`) you can see. For example:

  ```
  ..##.......
  #...#...#..
  .#....#..#.
  ..#.#...#.#
  .#...##..#.
  ..#.##.....
  .#.#.#....#
  .#........#
  #.##...#...
  #...##....#
  .#..#...#.#
  ```
  These aren't the only trees, though; due to something you read about once
  involving arboreal genetics and biome stability, the same pattern repeats to the
  right many times:

  ```
  *..##.......*..##.........##.........##.........##.........##.......  --->
  *#...#...#..*#...#...#..#...#...#..#...#...#..#...#...#..#...#...#..
  *.#....#..#.*.#....#..#..#....#..#..#....#..#..#....#..#..#....#..#.
  *..#.#...#.#*..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#
  *.#...##..#.*.#...##..#..#...##..#..#...##..#..#...##..#..#...##..#.
  *..#.##.....*..#.##.......#.##.......#.##.......#.##.......#.##.....  --->
  *.#.#.#....#*.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#
  *.#........#*.#........#.#........#.#........#.#........#.#........#
  *#.##...#...*#.##...#...#.##...#...#.##...#...#.##...#...#.##...#...
  *#...##....#*#...##....##...##....##...##....##...##....##...##....#
  *.#..#...#.#*.#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#  --->
  ```

  You start on the open square (`.`) in the top-left corner and need to reach the
  bottom (below the bottom-most row on your map).

  The toboggan can only follow a few specific slopes (you opted for a cheaper
  model that prefers rational numbers); start by *counting all the trees* you
  would encounter for the slope *right 3, down 1*:

  From your starting position at the top-left, check the position that is right 3
  and down 1. Then, check the position that is right 3 and down 1 from there, and
  so on until you go past the bottom of the map.

  The locations you'd check in the above example are marked here with `*O*` where
  there was an open square and `*X*` where there was a tree:

  ```
  ..##.........##.........##.........##.........##.........##.......  --->
  #..*O*#...#..#...#...#..#...#...#..#...#...#..#...#...#..#...#...#..
  .#....*X*..#..#....#..#..#....#..#..#....#..#..#....#..#..#....#..#.
  ..#.#...#*O*#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#
  .#...##..#..*X*...##..#..#...##..#..#...##..#..#...##..#..#...##..#.
  ..#.##.......#.*X*#.......#.##.......#.##.......#.##.......#.##.....  --->
  .#.#.#....#.#.#.#.*O*..#.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#
  .#........#.#........*X*.#........#.#........#.#........#.#........#
  #.##...#...#.##...#...#.*X*#...#...#.##...#...#.##...#...#.##...#...
  #...##....##...##....##...#*X*....##...##....##...##....##...##....#
  .#..#...#.#.#..#...#.#.#..#...*X*.#.#..#...#.#.#..#...#.#.#..#...#.#  --->
  ```
  In this example, traversing the map using this slope would cause you to
  encounter `*7*` trees.

  Starting at the top-left corner of your map and following a slope of right 3 and
  down 1, *how many trees would you encounter?*
  """

  @doc """
  Count the number of trees encountered traversing the map to the bottom on a
  right 3, down 1 slope.
  """
  def part_1(input) do
    start = %{position: {0, 0}, velocity: {3, 1}, trees_encountered: 0}
    map = parse_map(input)

    result = traverse_map(start, map)
    result.trees_encountered
  end

  @doc """

  """
  def part_2(input) do
    map = parse_map(input)

    [{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}]
    |> Enum.map(fn velocity ->
      %{position: {0, 0}, velocity: velocity, trees_encountered: 0}
      |> traverse_map(map)
      |> Map.get(:trees_encountered)
    end)
    |> Enum.reduce(fn x, acc -> x * acc end)
  end

  def parse_map(input) do
    rows = String.split(input, "\n", trim: true)
    matrix = Enum.map(rows, &String.codepoints/1)
    %{size: {length(hd(matrix)), length(rows)}, data: matrix}
  end

  def traverse_map(%{position: {_px, y}} = pos, %{size: {_mx, my}} = map) do
    if y == my - 1 do
      pos
    else
      move(pos, map)
    end
  end

  def move(%{position: pos, velocity: vel, trees_encountered: trees}, map) do
    {x1, y1} = pos
    {vx, vy} = vel

    new_position = {x1 + vx, y1 + vy}

    trees = if has_tree_at?(map, new_position), do: trees + 1, else: trees
    traverse_map(%{position: new_position, velocity: vel, trees_encountered: trees}, map)
  end

  def has_tree_at?(%{size: {dx, _dy}, data: data}, {x, y}) do
    value = data |> Enum.at(y) |> Enum.at(Integer.mod(x, dx))
    value == "#"
  end
end
