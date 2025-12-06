defmodule Aoc.Year2025.Day06.TrashCompactor do
  @moduledoc """
  Solution for Advent of Code 2025, Day 6: Trash Compactor Math.

  Part 1: Standard left-to-right math evaluation.
  Part 2: "Cephalopod math" - numbers are read as vertical columns, right-to-left.
  """

  alias __MODULE__.Parser

  def part_1(input) do
    input
    |> Parser.parse()
    |> evaluate_all()
    |> Enum.sum()
  end

  def part_2(input) do
    input
    |> Parser.parse_with_alignment()
    |> Enum.sum_by(fn {op, string_column} ->
      string_column |> transpose_cephalopod_math() |> then(&evaluate({op, &1}))
    end)
  end

  defp transpose_cephalopod_math(string_column) do
    max_length = Enum.max_by(string_column, &String.length/1) |> String.length()

    string_column
    |> Enum.map(&String.pad_trailing(&1, max_length))
    |> Enum.map(&String.graphemes/1)
    |> Enum.zip()
    |> Enum.map(&(&1 |> Tuple.to_list() |> Enum.join() |> String.trim()))
    |> Enum.reject(&(&1 == ""))
    |> Enum.reverse()
    |> Enum.map(&String.to_integer/1)
  end

  defp evaluate_all(problems) do
    for {op, numbers} <- problems, do: evaluate({op, numbers})
  end

  defp evaluate({:*, numbers}), do: Enum.product(numbers)
  defp evaluate({:+, numbers}), do: Enum.sum(numbers)

  defmodule Parser do
    @moduledoc """
    Parsers for the trash compactor math problems.
    """

    @doc """
    Parse input for part 1 (standard left-to-right reading).
    Loses whitespace alignment information.
    """
    def parse(input) do
      lines = String.split(input, "\n", trim: true)
      [operations_line | number_lines] = Enum.reverse(lines)

      operations = parse_operations(operations_line)

      numbers =
        number_lines
        |> Enum.reverse()
        |> Enum.map(&parse_number_row/1)
        |> transpose_rows()

      Enum.zip(operations, numbers)
    end

    @doc """
    Parse input for part 2 (cephalopod math with alignment preserved).
    Preserves whitespace to maintain column alignment information.
    """
    def parse_with_alignment(input) do
      lines = String.split(input, "\n", trim: true)
      [operations_line | number_lines] = Enum.reverse(lines)
      number_lines = Enum.reverse(number_lines)

      operations = parse_operations(operations_line)
      columns = extract_aligned_columns(number_lines)

      Enum.zip(operations, columns)
    end

    defp parse_operations(line) do
      line
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_atom/1)
    end

    defp parse_number_row(row) do
      row
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)
    end

    defp transpose_rows(rows) do
      rows
      |> Enum.zip()
      |> Enum.map(&Tuple.to_list/1)
    end

    # Extract columns while preserving alignment (whitespace)
    defp extract_aligned_columns(rows) do
      max_length = Enum.max_by(rows, &String.length/1) |> String.length()
      padded_rows = Enum.map(rows, &String.pad_trailing(&1, max_length))

      column_widths = find_column_widths(padded_rows)
      extract_columns(padded_rows, column_widths)
    end

    # Find where columns start/end by detecting space separators
    defp find_column_widths(rows) do
      rows
      |> Enum.map(&String.graphemes/1)
      |> scan_for_columns(0, [])
    end

    defp scan_for_columns(rows, current_width, widths) when rows == [] or hd(rows) == [] do
      finalize_widths(current_width, widths)
    end

    defp scan_for_columns(rows, current_width, widths) do
      {heads, tails} = split_heads_tails(rows)

      if all_spaces?(heads) do
        scan_for_columns_at_boundary(tails, current_width, widths)
      else
        scan_for_columns(tails, current_width + 1, widths)
      end
    end

    defp scan_for_columns_at_boundary(tails, 0, widths) do
      scan_for_columns(tails, 0, widths)
    end

    defp scan_for_columns_at_boundary(tails, current_width, widths) do
      scan_for_columns(tails, 0, [current_width | widths])
    end

    defp finalize_widths(0, widths), do: Enum.reverse(widths)
    defp finalize_widths(current_width, widths), do: Enum.reverse([current_width | widths])

    defp split_heads_tails(rows) do
      Enum.map(rows, fn
        [] -> {nil, []}
        [h | t] -> {h, t}
      end)
      |> Enum.unzip()
    end

    defp all_spaces?(chars) do
      Enum.all?(chars, fn
        nil -> true
        " " -> true
        _ -> false
      end)
    end

    defp extract_columns(rows, widths) do
      {_remaining, columns} =
        Enum.reduce(widths, {rows, []}, fn width, {remaining_rows, acc} ->
          {column_strings, rest_rows} = slice_column(remaining_rows, width)
          # Skip space separator after each column
          rest_rows = Enum.map(rest_rows, &String.slice(&1, 1..-1//1))
          {rest_rows, [column_strings | acc]}
        end)

      Enum.reverse(columns)
    end

    defp slice_column(rows, width) do
      Enum.map(rows, fn row ->
        {String.slice(row, 0, width), String.slice(row, width..-1//1)}
      end)
      |> Enum.unzip()
    end
  end
end
