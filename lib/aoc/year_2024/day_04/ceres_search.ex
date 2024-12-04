defmodule Aoc.Year2024.Day04.CeresSearch do
  alias __MODULE__.{Parser, Part1, Part2}

  def part_1(input) do
    puzzle = Parser.parse(input)
    puzzle_hash = Enum.into(puzzle, %{})

    {{puzzle_x, _}, _} = Enum.max_by(puzzle, fn {{x, _y}, _} -> x end)
    {{_, puzzle_y}, _} = Enum.max_by(puzzle, fn {{_x, y}, _} -> y end)

    for x <- 0..puzzle_x,
        y <- 0..puzzle_y,
        "X" == Map.get(puzzle_hash, {x, y}) do
      Part1.count_xmas_at({x, y}, puzzle_hash)
    end
    |> Enum.sum()
  end

  def part_2(input) do
    puzzle = Parser.parse(input)
    puzzle_hash = Enum.into(puzzle, %{})

    {{puzzle_x, _}, _} = Enum.max_by(puzzle, fn {{x, _y}, _} -> x end)
    {{_, puzzle_y}, _} = Enum.max_by(puzzle, fn {{_x, y}, _} -> y end)

    for x <- 0..puzzle_x,
        y <- 0..puzzle_y,
        "A" == Map.get(puzzle_hash, {x, y}) do
      Part2.crossing_mas?({x, y}, puzzle_hash)
    end
    |> Enum.count(& &1)
  end

  defmodule Part2 do
    def crossing_mas?(pt, hash) do
      pos_slope = -1..1//1
      neg_slope = 1..-1//-1

      [
        word_at_slope(pt, {pos_slope, pos_slope}, hash),
        word_at_slope(pt, {neg_slope, pos_slope}, hash)
      ]
      |> Enum.all?(&valid_mas?/1)
    end

    def word_at_slope({x_0, y_0}, {x_rng, y_rng}, hash) do
      x_rng
      |> Enum.zip(y_rng)
      |> Enum.map(fn {x, y} ->
        Map.get(hash, {x_0 + x, y_0 + y})
      end)
    end

    def valid_mas?(["M", "A", "S"]), do: true
    def valid_mas?(["S", "A", "M"]), do: true
    def valid_mas?(_), do: false
  end

  defmodule Part1 do
    def count_xmas_at(pt, hash) do
      pt
      |> words_at_pt(hash)
      |> Enum.filter(&valid_xmas?/1)
      |> Enum.count()
    end

    @doc """
    Return a list of words (or partial words)
    from a specific point.

    Check in each cardinal direction from the pt and along
    each diagonal
    """
    def words_at_pt(pt, hash) do
      Enum.map(directions(), &word_at(pt, &1, hash))
    end

    def word_at({x_0, y_0}, {x_range, y_range}, hash) do
      x_range
      |> Enum.zip(y_range)
      |> Enum.map(fn {x, y} ->
        Map.get(hash, {x_0 + x, y_0 + y})
      end)
      |> Enum.reject(&is_nil/1)
    end

    def valid_xmas?(["X", "M", "A", "S"]), do: true
    def valid_xmas?(_), do: false

    def directions do
      z = [0, 0, 0, 0]
      p = 0..3//1
      n = 0..-3//-1

      [
        # +X
        {p, z},
        # +Y
        {z, p},
        # -X
        {n, z},
        # -Y
        {z, n},
        # Q1
        {p, p},
        # Q2
        {n, p},
        # Q3
        {n, n},
        # Q4
        {p, n}
      ]
    end
  end

  defmodule Parser do
    def parse(input) do
      input
      |> String.split("\n", trim: true)
      |> Enum.with_index()
      |> Enum.flat_map(fn {line, x} ->
        line
        |> String.codepoints()
        |> Enum.with_index()
        |> Enum.map(fn {pt, y} -> {{x, y}, pt} end)
      end)
    end
  end
end
