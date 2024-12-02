defmodule Aoc.Year2024.Day01.HistorianHysteria do
  alias __MODULE__.Parser

  def total_sorted_distance(input) do
    input
    |> Parser.parse()
    |> Enum.map(&Enum.sort/1)
    |> Enum.zip()
    |> Enum.map(fn {x, y} ->
      abs(x - y)
    end)
    |> Enum.sum()
  end

  def similarity_score(input) do
    [sources, weights] =
      input
      |> Parser.parse()

    counted_weights = Enum.frequencies(weights)

    sources
    |> Enum.map(fn x ->
      x * Map.get(counted_weights, x, 0)
    end)
    |> Enum.sum()
  end

  defmodule Parser do
    def parse(input) do
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&parse_line/1)
      |> split_into_lists()
    end

    defp split_into_lists(lines) do
      left_list = Enum.map(lines, fn [x, _y] -> x end)
      right_list = Enum.map(lines, fn [_x, y] -> y end)

      [left_list, right_list]
    end

    defp parse_line(line) do
      line
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)
    end
  end
end
