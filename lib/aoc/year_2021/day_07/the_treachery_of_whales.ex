defmodule Aoc.Year2021.Day07.TheTreacheryofWhales do
  @doc """
  Determine the horizontal position that the crabs can align to
  using the least fuel possible.

  How much fuel must they spend to align to that position?

  ## Examples

    iex> part_1("16,1,2,0,4,2,7,1,2,14")
    37

  """
  def part_1(input) do
    input
    |> parse()
    |> minimum_alignment_cost(&abs(&1 - &2))
  end

  @doc """
  As it turns out, crab submarine engines don't burn fuel at a constant rate.
  Instead, each change of 1 step in horizontal position costs 1 more unit of
  fuel than the last: the first step costs 1, the second step costs 2,
  the third step costs 3, and so on.

  How much fuel must they spend to align to that position?

  ## Examples

    iex> part_2("16,1,2,0,4,2,7,1,2,14")
    168

  """
  def part_2(input) do
    input
    |> parse()
    |> minimum_alignment_cost(&Enum.sum(Range.new(1, abs(&1 - &2), 1)))
  end

  @doc """
  Parse the input

  ## Examples

      iex> parse("16,1,2,0,4,2,7,1,2,14")
      [16,1,2,0,4,2,7,1,2,14]
  """
  def parse(string) do
    string
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  @doc """
  Computes the minimum alignment cost across all possible
  aligned positions in the range of the input

  ## Examples

      iex> minimum_alignment_cost([16,1,2,0,4,2,7,1,2,14], & abs(&1 - &2))
      37

  """
  def minimum_alignment_cost(positions, cost_func) do
    {min, max} = Enum.min_max(positions)

    min..max
    |> Enum.map(&alignment_cost(positions, &1, cost_func))
    |> Enum.min()
  end

  @doc """
  Calculate the cost of moving a set of positions to a given position
  using the specified cost function

  ## Examples

      iex> alignment_cost([16,1,2,0,4,2,7,1,2,14], 2, & abs(&1 - &2))
      37
  """
  def alignment_cost(positions, calculate_for, cost_func) do
    positions
    |> Enum.map(fn current_pos -> cost_func.(current_pos, calculate_for) end)
    |> Enum.sum()
  end
end
