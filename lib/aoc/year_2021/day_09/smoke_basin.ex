defmodule Aoc.Year2021.Day09.SmokeBasin do
  @doc """
  Find all of the smoke filled low points on the
  input which represents the heightmap of your cave.

  Returns the sum of all of the values of those heightmaps
  """
  def part_1(input) do
    input
    |> parse()
    |> low_points()
    |> Enum.map(fn {_pos, val} -> val + 1 end)
    |> Enum.sum()
  end

  defp low_points(grid) do
    Enum.filter(grid, fn {{row, col}, value} ->
      up = grid[{row - 1, col}]
      down = grid[{row + 1, col}]
      left = grid[{row, col - 1}]
      right = grid[{row, col + 1}]
      value < up and value < down and value < left and value < right
    end)
  end

  @doc """
  A basin is all locations that eventually flow downward to a single low point.
  Therefore, every low point has a basin, although some basins are very small.
  Locations of height 9 do not count as being in any basin, and all other
  locations will always be part of exactly one basin.

  The size of a basin is the number of locations within the basin,
  including the low point. The example above has four basins.

  Find the three largest basins and multiply their sizes together.
  """
  def part_2(input) do
    grid = parse(input)

    grid
    |> low_points()
    |> Enum.map(fn {point, _} ->
      point
      |> fill_basin(grid)
      |> MapSet.size()
    end)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.product()
  end

  def fill_basin(low_point, grid) do
    fill_basin(MapSet.new(), low_point, grid)
  end

  def fill_basin(set, {row, col} = point, grid) do
    if grid[point] in [9, nil] or point in set do
      set
    else
      set
      |> MapSet.put(point)
      |> fill_basin({row - 1, col}, grid)
      |> fill_basin({row + 1, col}, grid)
      |> fill_basin({row, col - 1}, grid)
      |> fill_basin({row, col + 1}, grid)
    end
  end

  defp parse(input) do
    for {row, row_num} <- input |> String.split("\n") |> Enum.with_index(),
        {col, col_num} <- row |> String.to_charlist() |> Enum.with_index(),
        into: %{} do
      {{row_num, col_num}, col - ?0}
    end
  end
end
