defmodule Aoc.Year2023.Day01.Trebuchet do
  alias __MODULE__.{Part1, Part2}

  def part_1(input) do
    input
    |> Part1.solve()
    |> sum()
  end

  def part_2(input) do
    input
    |> Part2.solve()
    |> sum()
  end

  def sum(val) do
    val
    |> Enum.map(&[Enum.at(&1, 0), Enum.at(&1, -1)])
    |> Enum.map(&Integer.undigits/1)
    |> Enum.sum()
  end

  defmodule Part1 do
    def solve(input) do
      input
      |> Enum.map(&strip_and_parse/1)
    end

    defp strip_and_parse(line) do
      letters = MapSet.new(String.codepoints("abcdefghijklmnopqrstuvwxyz"))

      line
      |> String.trim()
      |> String.codepoints()
      |> Enum.reject(fn char ->
        MapSet.member?(letters, char)
      end)
      |> Enum.map(&String.to_integer/1)
    end
  end

  defmodule Part2 do
    @regex ~r/(?=(1|2|3|4|5|6|7|8|9|one|two|three|four|five|six|seven|eight|nine))/

    @word_to_number %{
      "one" => 1,
      "two" => 2,
      "three" => 3,
      "four" => 4,
      "five" => 5,
      "six" => 6,
      "seven" => 7,
      "eight" => 8,
      "nine" => 9
    }
    def solve(input) do
      input
      |> Enum.map(&Regex.scan(@regex, &1, capture: :all_but_first))
      |> Enum.map(&List.flatten/1)
      |> Enum.map(&convert_to_number/1)
    end

    defp convert_to_number(list) do
      Enum.map(list, fn
        value when is_map_key(@word_to_number, value) ->
          @word_to_number[value]

        value ->
          String.to_integer(value)
      end)
    end
  end
end
