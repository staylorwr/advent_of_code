defmodule Aoc.Year2021.Day08.SevenSegmentSearch do
  @doc """
  In the output values, how many times do digits 1, 4, 7, or 8 appear?
  """
  def part_1(input) do
    input
    |> parse()
    |> Enum.map(fn {_input, output} ->
      Enum.count(output, fn x -> length(x) in [2, 3, 4, 7] end)
    end)
    |> Enum.sum()
  end

  @doc """
  Decrypt each seven segment cipher and sum up the outputs
  """
  def part_2(input) do
    input
    |> parse()
    |> Enum.map(&solve_parts/1)
    |> Enum.sum()
  end

  @doc """
  Parse the input into data that can be used.
  """
  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, " | ", trim: true))
    |> Enum.map(&parse_display/1)
  end

  @doc """
  Parse a cipher case into an input

  ## Examples

      iex> {input, output} = parse_display(["acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab", "cdfeb fcadb cdfeb cdbaf"])
      iex> input
      %{2 => [~c"ab"], 3 => [~c"dab"], 4 => [~c"eafb"], 5 => [~c"cdfbe", ~c"gcdfa", ~c"fbcad"], 6 => [~c"cefabd", ~c"cdfgeb", ~c"cagedb"], 7 => [~c"acedgfb"]}
      iex> output
      [~c"cdfeb", ~c"fcadb", ~c"cdfeb", ~c"cdbaf"]
  """

  def parse_display([input, output]) do
    {input |> String.split() |> Enum.group_by(&byte_size/1, &String.to_charlist/1),
     output |> String.split() |> Enum.map(&String.to_charlist/1)}
  end

  @doc """
  Solve the cipher for the input, then use it to find the number represented
  by the output

  ## Examples

      iex> data = parse_display(["acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab", "cdfeb fcadb cdfeb cdbaf"])
      iex> solve_parts(data)
      5353
  """
  def solve_parts({input, output}) do
    %{
      2 => [one],
      3 => [seven],
      4 => [four],
      5 => two_three_five,
      6 => zero_six_nine,
      7 => [eight]
    } = input

    [nine] = superset(zero_six_nine, four)
    [six] = almost_superset(zero_six_nine, seven)
    [zero] = zero_six_nine -- [six, nine]

    [three] = superset(two_three_five, seven)
    [five] = almost_superset(two_three_five, six)
    [two] = two_three_five -- [three, five]

    numbers = %{
      Enum.sort(zero) => 0,
      Enum.sort(one) => 1,
      Enum.sort(two) => 2,
      Enum.sort(three) => 3,
      Enum.sort(four) => 4,
      Enum.sort(five) => 5,
      Enum.sort(six) => 6,
      Enum.sort(seven) => 7,
      Enum.sort(eight) => 8,
      Enum.sort(nine) => 9
    }

    [d1, d2, d3, d4] = output

    Integer.undigits([
      numbers[Enum.sort(d1)],
      numbers[Enum.sort(d2)],
      numbers[Enum.sort(d3)],
      numbers[Enum.sort(d4)]
    ])
  end

  defp superset(numbers, pivot) do
    Enum.filter(numbers, &match?([], pivot -- &1))
  end

  defp almost_superset(numbers, pivot) do
    Enum.filter(numbers, &match?([_], pivot -- &1))
  end
end
