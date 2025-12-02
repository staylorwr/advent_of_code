defmodule Aoc.Year2025.Day02.GiftShop do
  alias __MODULE__.Parser
  require Integer

  defmodule Parser do
    def parse(input) do
      input
      |> String.split(",", trim: true)
      |> Enum.map(fn range ->
        [start_val, end_val] =
          range
          |> String.split("-", trim: true)
          |> Enum.map(&String.to_integer/1)

        Range.new(start_val, end_val)
      end)
    end
  end

  @doc """
  Checks if a given integer is valid according to Part 1 rules.

  Part 1: An ID is invalid if it contains pairs of identical adjacent digits.

  ## Parameters
  - integer: The integer to check
  - num_parts: The number of parts to check (default is 2)

  ## Returns
  - true if the integer is valid, false otherwise

  ## Examples

      iex> is_valid?(11)
      false

      iex> is_valid?(12)
      true

      iex> is_valid?(111)
      true

      iex> is_valid?(1188511885)
      false

      iex> is_valid?(446446)
      false

      iex> is_valid?(121212, 3)
      false

      iex> is_valid?(2121212121, 5)
      false

      iex> is_valid?(111, 1)
      false
  """
  def is_valid?(integer, num_parts \\ 2)

  def is_valid?(integer, 1) do
    integer
    |> Integer.to_string()
    |> has_multiple_unique_digits?()
  end

  def is_valid?(integer, num_parts) do
    integer
    |> Integer.to_string()
    |> check_chunks(num_parts)
  end

  @doc """
  Determines if any pattern repeats in the integer (Part 2 rules).

  Part 2: An ID is invalid if it is made only of some sequence of digits
  repeated at least twice (e.g., 1212, 123123, 111).

  ## Examples

    iex> is_fully_valid?(11)
    false

    iex> is_fully_valid?(22)
    false

    iex> is_fully_valid?(1010)
    false

    iex> is_fully_valid?(565656)
    false

    iex> is_fully_valid?(111)
    false
  """
  def is_fully_valid?(integer) do
    integer
    |> Integer.to_string()
    |> has_no_repeating_patterns?()
  end

  def part_1(input) do
    input
    |> Parser.parse()
    |> Enum.flat_map(fn range ->
      Enum.reject(range, &is_valid?/1)
    end)
    |> Enum.sum()
  end

  def part_2(input) do
    input
    |> Parser.parse()
    |> Enum.flat_map(&Range.to_list/1)
    |> Enum.reject(&is_fully_valid?/1)
    |> Enum.sum()
  end

  defp has_multiple_unique_digits?(str) do
    str
    |> String.codepoints()
    |> Enum.uniq()
    |> length() > 1
  end

  defp check_chunks(str, num_parts) do
    length_of_string = String.length(str)
    chunk_size = div(length_of_string, num_parts)

    cond do
      chunk_size < 1 -> true
      coprime_and_long?(length_of_string, num_parts) -> true
      true -> str |> chunks_are_different?(chunk_size)
    end
  end

  defp coprime_and_long?(length, num_parts) do
    Integer.gcd(length, num_parts) == 1 and length > 2
  end

  defp chunks_are_different?(str, chunk_size) do
    str
    |> String.codepoints()
    |> Enum.chunk_every(chunk_size)
    |> MapSet.new()
    |> MapSet.size()
    |> Kernel.>(1)
  end

  defp has_no_repeating_patterns?(str) when byte_size(str) < 2, do: true

  defp has_no_repeating_patterns?(str) do
    str_length = String.length(str)

    1..div(str_length, 2)
    |> Enum.all?(&pattern_not_repeated?(str, str_length, &1))
  end

  defp pattern_not_repeated?(str, str_length, pattern_length) do
    cond do
      rem(str_length, pattern_length) != 0 ->
        true

      true ->
        str
        |> build_expected_repetition(pattern_length, str_length)
        |> Kernel.!=(str)
    end
  end

  defp build_expected_repetition(str, pattern_length, str_length) do
    str
    |> String.slice(0, pattern_length)
    |> String.duplicate(div(str_length, pattern_length))
  end
end
