defmodule Aoc.Year2022.Day14.RegolithReservoir do
  alias __MODULE__.{Parser, Part1}

  def part_1(input) do
    input
    |> Parser.parse()
    |> Part1.solve()
  end

  def part_2(input) do
    input
    |> Parser.parse()
    |> Part1.solve_2()
  end

  defmodule Part1 do
    @sand_source {0, 500}
    def solve(input) do
      {highest_row, _lowest_col} = Enum.max(input)

      stop_func = fn {row, _col} -> row >= highest_row end

      {{_rock, sand, _floor}, _ticks} =
        tick({input, MapSet.new(), nil}, stop_func, @sand_source, 0)

      MapSet.size(sand)
    end

    def solve_2(input) do
      {highest_row, _lowest_col} = Enum.max(input)
      stop_func = fn position -> position == @sand_source end

      {{_rock, sand, _floor}, _ticks} =
        tick({input, MapSet.new(), highest_row + 2}, stop_func, @sand_source, 0)

      MapSet.size(sand) + 1
    end

    defp tick({rock, sand, floor}, stop_func, current_sand, seconds) do
      next = next_position({rock, sand, floor}, current_sand)

      cond do
        stop_func.(next) ->
          {{rock, sand, floor}, seconds}

        next == current_sand ->
          # This sand is now at rest.
          tick(
            {rock, MapSet.put(sand, current_sand), floor},
            stop_func,
            @sand_source,
            seconds + 1
          )

        true ->
          tick({rock, sand, floor}, stop_func, next, seconds + 1)
      end
    end

    defp next_position(state, {row, col}) do
      move(state, {row + 1, col}) || move(state, {row + 1, col - 1}) ||
        move(state, {row + 1, col + 1}) || {row, col}
    end

    defp move({rock, sand, floor_row}, {row, _} = position) do
      if MapSet.member?(rock, position) || MapSet.member?(sand, position) || row == floor_row do
        false
      else
        position
      end
    end

    def display_grid({rock, sand}, position) do
      {{_, min_col}, {_, max_col}} = Enum.min_max_by(rock, fn {_, col} -> col end)
      {{min_row, _}, {max_row, _}} = Enum.min_max_by(rock, fn {row, _} -> row end)

      Enum.each((min_row - 10)..(max_row + 10), fn row ->
        Enum.reduce((min_col - 10)..(max_col + 10), [], fn col, acc ->
          char =
            cond do
              MapSet.member?(rock, {row, col}) -> "#"
              MapSet.member?(sand, {row, col}) -> "o"
              {row, col} == position -> "x"
              true -> " "
            end

          [char | acc]
        end)
        |> Enum.reverse()
        |> List.to_string()
        |> IO.puts()
      end)

      :timer.sleep(10)
    end
  end

  defmodule Parser do
    def parse(input) do
      input
      |> String.split("\n")
      |> Enum.reduce(MapSet.new(), &parse_row/2)
    end

    def parse_row(row, rocks) do
      row
      |> String.split(" -> ")
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.reduce(rocks, &parse_line/2)
    end

    def parse_line([from, to], rocks) do
      [from_col, from_row] = to_elems(from)
      [to_col, to_row] = to_elems(to)

      line_pts = for x <- from_row..to_row, y <- from_col..to_col, do: {x, y}

      line_pts
      |> MapSet.new()
      |> MapSet.union(rocks)
    end

    def to_elems(elem) do
      elem
      |> String.split(",", parts: 2)
      |> Enum.map(&String.to_integer/1)
    end
  end
end
