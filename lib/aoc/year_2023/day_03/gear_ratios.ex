defmodule Aoc.Year2023.Day03.GearRatios do
  alias __MODULE__.Parser

  def part_1(input) do
    input
    |> Parser.parse()
    |> points()
    |> Enum.reject(fn {_, value} -> value == 0 end)
    |> Enum.map(&elem(&1, 1))
    |> Enum.sum()
  end

  def part_2(input) do
    {pts, grid} = Parser.parse(input)

    {pts, grid}
    |> points()
    |> Enum.reject(fn {_, value} -> value == 0 end)
    |> Enum.filter(fn {pt, _} ->
      point = Map.get(grid, pt, ".")
      point == "*"
    end)
    |> Enum.group_by(&elem(&1, 0), &elem(&1, 1))
    |> Enum.filter(fn {_, values} -> length(values) == 2 end)
    |> Enum.map(fn {_pt, values} ->
      Enum.product(values)
    end)
    |> Enum.sum()
  end

  def points({pts, grid}) do
    Enum.flat_map(pts, fn {pt, value} ->
      length = String.length("#{value}")
      coords = surrounds(pt, length)

      coords
      |> MapSet.to_list()
      |> Enum.map(fn elem ->
        point = Map.get(grid, elem, ".")
        symbol = Regex.match?(~r/[^\d.]/, point)

        if symbol do
          {elem, value}
        else
          {elem, 0}
        end
      end)
    end)
  end

  def surround(x, y),
    do: [
      {x, y - 1},
      {x, y + 1},
      {x - 1, y},
      {x + 1, y},
      {x - 1, y - 1},
      {x + 1, y - 1},
      {x - 1, y + 1},
      {x + 1, y + 1}
    ]

  def surrounds({x, y}, length) do
    x_coords = Range.new(x, x + length - 1)

    local = x_coords |> Enum.map(&{&1, y}) |> MapSet.new()

    x_coords
    |> Enum.flat_map(&surround(&1, y))
    |> MapSet.new()
    |> MapSet.difference(local)
  end

  defmodule Parser do
    def parse(input) do
      lines =
        input
        |> String.split("\n")
        |> Enum.with_index()

      grid =
        lines
        |> Enum.flat_map(fn {line, y} ->
          line
          |> String.codepoints()
          |> Enum.with_index()
          |> Enum.map(fn {char, x} ->
            {{x, y}, char}
          end)
        end)
        |> Map.new()

      points =
        lines
        |> Enum.flat_map(fn {line, y} ->
          matches = Regex.scan(~r/\d+/, line, return: :index)

          Enum.map(matches, fn [{byte_index, len}] ->
            value =
              line
              |> String.slice(byte_index, len)
              |> String.to_integer()

            {{byte_index, y}, value}
          end)
        end)

      {points, grid}
    end
  end
end
