defmodule Aoc.Year2025.Day03.Lobby do
  alias __MODULE__.Parser

  defmodule Parser do
    def parse(input) do
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn row ->
        row
        |> String.codepoints()
        |> Enum.map(&String.to_integer/1)
      end)
    end
  end

  def part_1(input) do
    input
    |> Parser.parse()
    |> Enum.map(&find_max_pair/1)
    |> Enum.sum()
  end

  def part_2(input) do
    input
    |> Parser.parse()
    |> Enum.map(&max_joltage_of_length(&1, 12))
    |> Enum.sum()
  end

  @doc """
  Find the two numbers in the row that when combined in order produce the largest number.

  ## Examples

      iex> find_max_pair([1, 2, 3, 4, 5])
      45

      iex> find_max_pair([9, 8, 7, 6, 5, 4, 3, 2, 1])
      98

      iex> find_max_pair([8, 1, 1, 1, 1, 1, 9])
      89

      iex> find_max_pair([2, 3, 2, 3, 2, 3, 7, 8])
      78

      iex> find_max_pair([8, 1,8,1,8,1,9,1,1,1,1,2])
      92
  """
  def find_max_pair(row) do
    max_joltage_of_length(row, 2)
  end

  @doc """
  Find the largest number that can be formed by selecting `len` digits from `row`
  while maintaining their relative order.

  The algorithm greedily selects the largest available digit at each step,
  ensuring enough digits remain for future selections.

  ## Examples

      iex> max_joltage_of_length([1, 2, 3, 4, 5], 2)
      45

      iex> max_joltage_of_length([9, 8, 7, 6, 5, 4, 3, 2, 1], 3)
      987

      iex> max_joltage_of_length([2, 3, 2, 3, 2, 3, 7, 8], 4)
      3378
  """
  def max_joltage_of_length(row, len, acc \\ [])

  def max_joltage_of_length(_row, 0, acc) do
    acc
    |> Enum.reverse()
    |> Integer.undigits()
  end

  def max_joltage_of_length(row, len, acc) do
    {searchable, reserved} = split_search_range(row, len)

    largest = Enum.max(searchable)
    remaining = drop_through_first(searchable, largest)

    max_joltage_of_length(remaining ++ reserved, len - 1, [largest | acc])
  end

  # Splits the row into digits we can search and digits we must reserve.
  # We need to reserve (len - 1) digits for future selections.
  defp split_search_range(row, 1), do: {row, []}
  defp split_search_range(row, len), do: Enum.split(row, -(len - 1))

  # Drops elements up to and including the first occurrence of `target`.
  defp drop_through_first(list, target) do
    list
    |> Enum.drop_while(&(&1 != target))
    |> tl()
  end
end
