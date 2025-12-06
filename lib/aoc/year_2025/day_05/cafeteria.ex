defmodule Aoc.Year2025.Day05.Cafeteria do
  alias __MODULE__.Parser

  defmodule State do
    defstruct [:fresh_ranges, :available_items]
  end

  defmodule Parser do
    def parse(input) do
      [ranges, items] = String.split(input, "\n\n", trim: true)

      ranges =
        ranges
        |> String.split("\n", trim: true)
        |> Enum.map(fn range ->
          [first, last] =
            range
            |> String.split("-", trim: true)
            |> Enum.map(&String.to_integer/1)

          Range.new(first, last)
        end)

      items =
        items
        |> String.split("\n", trim: true)
        |> Enum.map(&String.to_integer/1)

      %State{fresh_ranges: ranges, available_items: items}
    end
  end

  def part_1(input) do
    state = Parser.parse(input)

    Enum.count(state.available_items, fn item ->
      Enum.any?(state.fresh_ranges, fn range -> Enum.member?(range, item) end)
    end)
  end

  def part_2(input) do
    state = Parser.parse(input)

    state.fresh_ranges
    |> Enum.sort_by(& &1.first)
    |> Enum.reduce([], &merge_range/2)
    |> Enum.map(&Range.size/1)
    |> Enum.sum()
  end

  defp merge_range(range, []), do: [range]

  defp merge_range(range, [prev_range | rest]) when range.first <= prev_range.last + 1 do
    [Range.new(prev_range.first, max(prev_range.last, range.last)) | rest]
  end

  defp merge_range(range, acc), do: [range | acc]
end
