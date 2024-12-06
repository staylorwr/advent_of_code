defmodule Aoc.Year2024.Day05.PrintQueue do
  alias __MODULE__.Parser

  def part_1(input) do
    {rules, updates} = Parser.parse(input)

    updates
    |> Enum.filter(&valid_update?(&1, rules))
    |> Enum.map(&middle_element/1)
    |> Enum.sum()
  end

  def part_2(input) do
    {rules, updates} = Parser.parse(input)

    updates
    |> Enum.reject(&valid_update?(&1, rules))
    |> Enum.map(&correctly_sort(&1, rules))
    |> Enum.map(&middle_element/1)
    |> Enum.sum()
  end

  def valid_update?(update, rules) do
    rules
    |> Enum.filter(fn {a, b} ->
      a in update and b in update
    end)
    |> Enum.all?(fn {a, b} ->
      Enum.find_index(update, &(&1 == a)) < Enum.find_index(update, &(&1 == b))
    end)
  end

  def middle_element(update) do
    Enum.at(update, round((length(update) - 1) / 2))
  end

  def correctly_sort(update, rules) do
    Enum.sort(update, fn a, b ->
      Enum.any?(rules, &(&1 == {a, b}))
    end)
  end

  defmodule Parser do
    def parse(input) do
      [rules, updates] = String.split(input, "\n\n", trim: true)

      parsed_rules =
        rules
        |> String.split("\n")
        |> Enum.map(fn str ->
          [p1, p2] = String.split(str, "|")
          {String.to_integer(p1), String.to_integer(p2)}
        end)

      {parsed_rules, csv_of_integers(updates)}
    end

    defp csv_of_integers(lines) do
      lines
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        line
        |> String.split(",")
        |> Enum.map(&String.to_integer/1)
      end)
    end
  end
end
