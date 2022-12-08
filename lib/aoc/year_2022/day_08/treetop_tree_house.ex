defmodule Aoc.Year2022.Day08.TreetopTreeHouse do
  alias __MODULE__.{Parser, Part1, Part2, State}

  def part_1(input) do
    input
    |> Parser.parse()
    |> State.new()
    |> Part1.solve()
  end

  def part_2(input) do
    input
    |> Parser.parse()
  end

  defmodule Part1 do
    def solve(state) do
      state.grid
      |> Enum.count(&tallest_tree?(&1, state))
    end

    def tallest_tree?({{0, _y}, _height}, _state), do: true
    def tallest_tree?({{_x, 0}, _height}, _state), do: true
    def tallest_tree?({{x, _y}, _height}, %{max: %{x: x}}), do: true
    def tallest_tree?({{_y, y}, _height}, %{max: %{y: y}}), do: true

    def tallest_tree?({point, height}, %{grid: grid, max: max}) do
      # consider the tree at pos 3, 2 in a 5x5 grid:
      #   0 1 2 3 4
      # 0 . . . . .
      # 1 . . . . .
      # 2 . . . X .
      # 3 . . . . .
      # 4 . . . . .
      #
      #
      # west check would include: {0, 2}, {1, 2}, {2, 2}
      # east check would include: {4, 2}
      # north check would include: {3, 0}, {3, 1}
      # south check would include: {3, 3}, {3, 4}

      ~w(north east south west)a
      |> Enum.map(fn dir ->
        dir
        |> points(point, max)
        |> Enum.map(fn {x, y} -> grid[{x, y}] end)
        |> Enum.all?(&(&1 < height))
      end)
      |> Enum.any?()
    end

    def points(:north, {x, y}, _) do
      Enum.map(0..(y - 1), fn y -> {x, y} end)
    end

    def points(:east, {x, y}, %{x: max_x}) do
      Enum.map((x + 1)..max_x, fn x -> {x, y} end)
    end

    def points(:south, {x, y}, %{y: max_y}) do
      Enum.map((y + 1)..max_y, fn y -> {x, y} end)
    end

    def points(:west, {x, y}, _) do
      Enum.map(0..(x - 1), fn x -> {x, y} end)
    end
  end

  defmodule Part2 do
    def solve(state) do
      state
    end
  end

  defmodule State do
    @enforce_keys [:grid, :max]
    defstruct grid: %{}, max: %{x: 0, y: 0}

    def new(grid) do
      x = grid |> Enum.max_by(fn {{x, _}, _} -> x end) |> elem(0) |> elem(0)
      y = grid |> Enum.max_by(fn {{_, y}, _} -> y end) |> elem(0) |> elem(1)
      %__MODULE__{grid: Map.new(grid), max: %{x: x, y: y}}
    end
  end

  defmodule Parser do
    def parse(input) do
      input
      |> String.split("\n", trim: true)
      |> Enum.with_index()
      |> Enum.flat_map(&parse_line/1)
    end

    def parse_line({line, y}) do
      line
      |> to_charlist()
      |> Enum.with_index()
      |> Enum.map(fn {val, x} -> {{x, y}, val - ?0} end)
    end
  end
end
