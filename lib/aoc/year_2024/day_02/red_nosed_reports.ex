defmodule Aoc.Year2024.Day02.RedNosedReports do
  alias __MODULE__.Parser

  def count_safe(input) do
    input
    |> Parser.parse()
    |> Enum.count(&safe?/1)
  end

  def dampened_safe(input) do
    input
    |> Parser.parse()
    |> Enum.count(&dampened_safe?/1)
  end

  @doc """
  Is the report safe?

      iex> safe?([7,6,4,2,1])
      true
      iex> safe?([1,2,7,8,9])
      false
      iex> safe?([1,3,2,4,5])
      false
  """
  def safe?(report) do
    increasing = all_increasing?(report)
    decreasing = all_decreasing?(report)
    safe = safe_adjaceny?(report)
    (increasing or decreasing) and safe
  end

  @doc """
  Is the report either safe as it is originally or made safe
  by removing a single element?

      iex> dampened_safe?([7,6,4,2,1])
      true
      iex> dampened_safe?([1,2,7,8,9])
      false
      iex> dampened_safe?([1,3,2,4,5])
      true
  """
  def dampened_safe?(report) do
    full_report_safe = safe?(report)

    can_be_dampened_safe?(full_report_safe, report)
  end

  defp can_be_dampened_safe?(true, _), do: true

  defp can_be_dampened_safe?(_, report) do
    positions = 0..(length(report) - 1)//1

    Enum.find(positions, fn index ->
      {_, remaining} = List.pop_at(report, index)
      safe?(remaining)
    end)
  end

  @doc """
  Is the report always increasing?

      iex> all_increasing?([1,2,3])
      true
      iex> all_increasing?([1,1,2])
      false
      iex> all_increasing?([3,2,1])
      false
  """
  def all_increasing?(report) do
    all_moving?(report, &Kernel.>/2)
  end

  @doc """
  Is the report always decreasing?

      iex> all_decreasing?([1,2,3])
      false
      iex> all_decreasing?([1,1,2])
      false
      iex> all_decreasing?([3,2,1])
      true
  """
  def all_decreasing?(report) do
    all_moving?(report, &Kernel.</2)
  end

  @doc """
  Any two adjacent levels differ by at least one and at most three.

      iex> safe_adjaceny?([1,2,3])
      true
      iex> safe_adjaceny?([1,5,9])
      false
      iex> safe_adjaceny?([7,6,4,2,1])
      true
  """
  def safe_adjaceny?(report) do
    all_moving?(report, fn x, y ->
      diff = abs(x - y)
      diff >= 1 and diff <= 3
    end)
  end

  defp all_moving?(report, dir_fn) do
    [first | rest] = report

    result =
      Enum.reduce_while(rest, first, fn current, prev ->
        if dir_fn.(current, prev) do
          {:cont, current}
        else
          {:halt, false}
        end
      end)

    result != false
  end

  defmodule Parser do
    def parse(input) do
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn str ->
        str
        |> String.split(" ", trim: true)
        |> Enum.map(&String.to_integer/1)
      end)
    end
  end
end
