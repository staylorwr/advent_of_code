defmodule Aoc.Year2024.Day03.MullItOver do
  alias __MODULE__.Parser

  def part_1(input) do
    input
    |> Parser.parse_muls()
    |> solve()
  end

  def part_2(input) do
    muls = Parser.parse_muls(input)
    dos = Parser.parse_dos(input)

    muls
    |> Enum.concat(dos)
    |> Enum.sort_by(fn tup -> elem(tup, 0) end)
    |> Enum.reduce({true, []}, &apply_do_filter/2)
    |> elem(1)
    |> solve()
  end

  defp apply_do_filter({_, bool}, {_prev, existing}) when is_boolean(bool) do
    {bool, existing}
  end

  defp apply_do_filter(val, {true, existing}) do
    {true, [val | existing]}
  end

  defp apply_do_filter(_val, acc), do: acc

  defp solve(list) do
    list
    |> Enum.map(fn {_start, x, y} -> x * y end)
    |> Enum.sum()
  end

  defmodule Parser do
    @mul_scan ~r/mul\((\d+),(\d+)\)/

    @do_scan ~r/do\(\)|don\'t\(\)/

    def parse_muls(input) do
      @mul_scan
      |> Regex.scan(input, return: :index)
      |> Enum.map(fn [{start, _length}, x, y] ->
        {start, parse_int(input, x), parse_int(input, y)}
      end)
    end

    def parse_dos(input) do
      @do_scan
      |> Regex.scan(input, return: :index)
      |> Enum.map(fn [{index, len}] -> {index, len == 4} end)
    end

    defp parse_int(input, {start, len}) do
      input
      |> String.slice(start, len)
      |> String.to_integer()
    end
  end
end
