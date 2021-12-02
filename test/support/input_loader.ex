defmodule Aoc.InputLoader do
  @moduledoc """
  Loads challenge inputs
  """

  @doc """
  Loads the given file as a string
  """
  def input(year, day, options \\ %{}) do
    day = day |> Integer.to_string() |> String.pad_leading(2, "0")

    cond do
      Map.get(options, :as_int_list) ->
        year
        |> plain_input(day)
        |> String.split("\n")
        |> Enum.map(&String.to_integer/1)

      Map.get(options, :as_lines) ->
        year
        |> plain_input(day)
        |> String.split("\n")

      true ->
        plain_input(year, day)
    end
  end

  defp path_to_file(year, day) do
    "priv/inputs/year_#{year}/day_#{day}.txt"
    |> Path.expand()
    |> Path.absname()
  end

  defp plain_input(year, day) do
    year
    |> path_to_file(day)
    |> File.read!()
    |> String.trim()
  end
end
