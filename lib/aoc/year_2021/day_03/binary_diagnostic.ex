defmodule Aoc.Year2021.Day03.BinaryDiagnostic do
  @moduledoc """
  ## --- Day 3: Binary Diagnostic ---

  The submarine has been making some odd creaking noises, so you ask it to produce
  a diagnostic report just in case.

  The diagnostic report (your puzzle input) consists of a list of binary numbers
  which, when decoded properly, can tell you many useful things about the
  conditions of the submarine. The first parameter to check is the *power
  consumption*.

  You need to use the binary numbers in the diagnostic report to generate two new
  binary numbers (called the *gamma rate* and the *epsilon rate*). The power
  consumption can then be found by multiplying the gamma rate by the epsilon rate.

  Each bit in the gamma rate can be determined by finding the *most common bit in
  the corresponding position* of all numbers in the diagnostic report. For
  example, given the following diagnostic report:

  ```
  00100
  11110
  10110
  10111
  10101
  01111
  00111
  11100
  10000
  11001
  00010
  01010
  ```
  """

  @doc """
  Use the binary numbers in your diagnostic report to calculate the gamma rate and
  epsilon rate, then multiply them together. *What is the power consumption of the
  submarine?* (Be sure to represent your answer in decimal, not binary.)
  """
  def part_1(input) do
    {gamma, epislon} =
      input
      |> parsed()
      |> Enum.zip()
      |> Enum.map(fn col ->
        col
        |> Tuple.to_list()
        |> Enum.frequencies()
        |> gamma_and_epsilon()
      end)
      |> Enum.reduce({"", ""}, fn x, {gamma, epislon} ->
        {gamma <> Keyword.get(x, :gamma), epislon <> Keyword.get(x, :epsilon)}
      end)

    {g, ""} = Integer.parse(gamma, 2)
    {e, ""} = Integer.parse(epislon, 2)
    g * e
  end

  defp parsed(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
  end

  def parse(data) when is_binary(data) do
    data
    |> String.split("\n", trim: true)
    |> Enum.map(&to_charlist/1)
  end

  defp gamma_and_epsilon(%{"0" => x, "1" => y}) when x > y, do: [gamma: "0", epsilon: "1"]
  defp gamma_and_epsilon(%{"0" => x, "1" => y}) when x < y, do: [gamma: "1", epsilon: "0"]

  @doc ~S"""
  Compute the life support rating of a submarine.

  ## Examples
      iex> report = parse("00100\n11110\n10110\n10111\n10101\n01111\n00111\n11100\n10000\n11001\n00010\n01010")
      iex> life_support_rating(report)
      230
  """
  def life_support_rating(report) when is_list(report) do
    oxygen_generator_rating(report) * co2_scrubber_rating(report)
  end

  @doc ~S"""
  Compute the oxygen generator rating.

  ## Examples

      iex> report = parse("00100\n11110\n10110\n10111\n10101\n01111\n00111\n11100\n10000\n11001\n00010\n01010")
      iex> oxygen_generator_rating(report)
      23
  """
  def oxygen_generator_rating(report) when is_list(report) do
    prune_report(report, fn numbers_with_zero, numbers_with_one ->
      if Enum.count(numbers_with_zero) > Enum.count(numbers_with_one) do
        numbers_with_zero
      else
        numbers_with_one
      end
    end)
  end

  @doc ~S"""
  Compute the CO2 scrubber rating.

  ## Examples

      iex> report = parse("00100\n11110\n10110\n10111\n10101\n01111\n00111\n11100\n10000\n11001\n00010\n01010")
      iex> co2_scrubber_rating(report)
      10
  """
  def co2_scrubber_rating(report) when is_list(report) do
    prune_report(report, fn numbers_with_zero, numbers_with_one ->
      if Enum.count(numbers_with_zero) > Enum.count(numbers_with_one) do
        numbers_with_one
      else
        numbers_with_zero
      end
    end)
  end

  defp prune_report([number | _] = report, fun) when is_function(fun, 2) do
    num_bits_per_number = Enum.count(number)

    0..num_bits_per_number
    |> Enum.reduce(report, fn
      _index, [number] ->
        [number]

      index, numbers ->
        {numbers_with_zero, numbers_with_one} =
          Enum.split_with(numbers, fn number -> Enum.at(number, index) === ?0 end)

        fun.(numbers_with_zero, numbers_with_one)
    end)
    |> Enum.at(0)
    |> to_string()
    |> String.to_integer(2)
  end
end
