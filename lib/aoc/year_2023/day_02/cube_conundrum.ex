defmodule Aoc.Year2023.Day02.CubeConundrum do
  alias __MODULE__.{Parser, Part1, Part2}

  def part_1(input, scenario) do
    input
    |> Parser.parse()
    |> Part1.solve(scenario)
  end

  def part_2(input) do
    input
    |> Parser.parse()
    |> Part2.solve()
  end

  defmodule Part1 do
    def solve(input, scenario) do
      input
      |> Enum.map(fn {game_index, games} ->
        {game_index, max_seen(games)}
      end)
      |> Enum.filter(fn {_index, result} ->
        result.red <= scenario.red and
          result.green <= scenario.green and
          result.blue <= scenario.blue
      end)
      |> Enum.map(fn {index, _result} -> index end)
      |> Enum.sum()
    end

    def max_seen(games) do
      Enum.reduce(games, &Map.merge(&1, &2, fn _, l, r -> max(l, r) end))
    end
  end

  defmodule Part2 do
    def solve(input) do
      input
      |> Enum.map(fn {_, games} ->
        games
        |> max_seen()
        |> Map.values()
        |> Enum.product()
      end)
      |> Enum.sum()
    end

    def max_seen(games) do
      Enum.reduce(games, &Map.merge(&1, &2, fn _, l, r -> max(l, r) end))
    end
  end

  defmodule Parser do
    def parse(input) do
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&parse_line/1)
      |> Map.new()
    end

    defp parse_line(line) do
      [game, cubes] = String.split(line, ": ")

      cubes =
        cubes
        |> String.split("; ", trim: true)
        |> Enum.map(&parse_cubes/1)

      game_index = game |> String.replace("Game ", "") |> String.to_integer()
      {game_index, cubes}
    end

    defp parse_cubes(cubes) do
      cubes
      |> String.split(", ", trim: true)
      |> Enum.map(fn cube ->
        [count, color] = String.split(cube, " ")

        {String.to_existing_atom(color), String.to_integer(count)}
      end)
      |> Map.new()
    end
  end
end
