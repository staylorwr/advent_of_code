defmodule Aoc.Year2025.Day04.PrintingDepartment do
  @moduledoc """
  Day 4: Printing Department

  A grid puzzle where we need to pick up toilet paper rolls (@) from a warehouse.
  A roll can only be picked up if it has fewer than 4 neighboring rolls
  (i.e., it's accessible from at least one side).

  Part 1: Count how many rolls can be picked up in a single pass.
  Part 2: Count total rolls that can be removed by repeatedly picking up
          accessible rolls until no more can be removed.
  """

  alias __MODULE__.Parser

  @type position :: {integer(), integer()}
  @type cell :: :empty | :roll
  @type grid :: %{position() => cell()}

  @doc "Count rolls that can be picked up in a single pass"
  def part_1(input) do
    grid = Parser.parse(input)

    grid
    |> rolls()
    |> Enum.count(&accessible?(&1, grid))
  end

  @doc "Count total rolls removed after repeatedly picking up accessible rolls"
  def part_2(input) do
    grid = Parser.parse(input)
    original_count = count_rolls(grid)
    final_count = grid |> remove_until_stable() |> count_rolls()

    original_count - final_count
  end

  defp rolls(grid) do
    for {pos, :roll} <- grid, do: pos
  end

  defp count_rolls(grid) do
    Enum.count(grid, fn {_, cell} -> cell == :roll end)
  end

  defp accessible?(pos, grid) do
    neighboring_rolls = pos |> neighbors() |> Enum.count(&(grid[&1] == :roll))
    neighboring_rolls < 4
  end

  defp neighbors({x, y}) do
    for dx <- -1..1, dy <- -1..1, {dx, dy} != {0, 0} do
      {x + dx, y + dy}
    end
  end

  defp remove_until_stable(grid), do: remove_until_stable(grid, count_rolls(grid))

  defp remove_until_stable(grid, previous_count) do
    new_grid = remove_accessible_rolls(grid)
    remove_until_stable(new_grid, count_rolls(new_grid), previous_count)
  end

  defp remove_until_stable(grid, count, count), do: grid
  defp remove_until_stable(grid, new_count, _prev), do: remove_until_stable(grid, new_count)

  defp remove_accessible_rolls(grid) do
    to_remove =
      grid
      |> rolls()
      |> Enum.filter(&accessible?(&1, grid))
      |> Map.new(fn pos -> {pos, :empty} end)

    Map.merge(grid, to_remove)
  end

  defmodule Parser do
    @moduledoc false

    @spec parse(String.t()) :: Aoc.Year2025.Day04.PrintingDepartment.grid()
    def parse(input) do
      input
      |> String.split("\n", trim: true)
      |> Enum.with_index()
      |> Enum.flat_map(&parse_row/1)
      |> Map.new()
    end

    defp parse_row({row, y}) do
      row
      |> String.codepoints()
      |> Enum.with_index()
      |> Enum.map(fn {char, x} -> {{x, y}, to_cell(char)} end)
    end

    defp to_cell("."), do: :empty
    defp to_cell("@"), do: :roll
  end
end
