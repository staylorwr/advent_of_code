defmodule Aoc.Year2025.Day01.SecretEntrance do
  @doc """
  Counts how many times the dial points at 0 when moving from a starting position.
  This includes both passing through 0 during rotation AND ending at 0.

  ## Parameters
  - start: Starting position (0-99)
  - delta: How far to move (positive = right/clockwise, negative = left/counter-clockwise)

  ## Examples
      iex> times_at_zero(50, 68)
      1

      iex> times_at_zero(52, 48)
      1

      iex> times_at_zero(0, 5)
      0

      iex> times_at_zero(50, 888)
      9

      iex> times_at_zero(10, -120)
      2

      iex> times_at_zero(50, 1000)
      10
  """
  def times_at_zero(start, delta) when delta >= 0 do
    # Moving right/clockwise
    # Count how many times we're at position 0 (multiples of 100)
    div(start + delta, 100) - div(start, 100)
  end

  def times_at_zero(start, delta) when delta < 0 do
    # Moving left/counter-clockwise
    val = abs(delta)

    cond do
      start == 0 ->
        # Starting at 0, count how many times we come back to 0
        div(val, 100)

      val >= start ->
        # We reach 0, then keep going around
        # First time at 0 after 'start' steps, then every 100 steps
        1 + div(val - start, 100)

      true ->
        # Never reach 0
        0
    end
  end

  def part_1(input) do
    input
    |> parse()
    |> Enum.reduce({50, []}, &apply_part1_instruction/2)
    |> elem(1)
    |> Enum.filter(&(&1 == 0))
    |> Enum.count()
  end

  def part_2(input) do
    input
    |> parse()
    |> Enum.reduce({50, 0}, &apply_part2_instruction/2)
    |> elem(1)
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn elem ->
      {String.at(elem, 0), elem |> String.slice(1..-1//1) |> String.to_integer()}
    end)
  end

  defp apply_part1_instruction({"R", val}, {acc, values}) do
    new_val = Integer.mod(acc + val, 100)
    {new_val, [new_val | values]}
  end

  defp apply_part1_instruction({"L", val}, {acc, values}) do
    new_val = Integer.mod(acc - val, 100)
    {new_val, [new_val | values]}
  end

  defp apply_part2_instruction({"R", val}, {acc, count}) do
    new_val = Integer.mod(acc + val, 100)
    zeros = times_at_zero(acc, val)
    {new_val, count + zeros}
  end

  defp apply_part2_instruction({"L", val}, {acc, count}) do
    new_val = Integer.mod(acc - val, 100)
    zeros = times_at_zero(acc, -val)
    {new_val, count + zeros}
  end
end
