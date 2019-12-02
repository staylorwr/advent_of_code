defmodule Aoc.InputLoader do
  @moduledoc """
  Loads challenge inputs
  """

  @doc """
  Loads the given file as a string
  """
  def input(year, day, options \\ %{}) do
    day = day |> Integer.to_string() |> String.pad_leading(2, "0")

    input =
      "priv/inputs/year_#{year}/day_#{day}.txt"
      |> Path.expand()
      |> Path.absname()
      |> File.read!()
      |> String.trim()

    cond do
      Map.get(options, :as_int_list) ->
        input |> String.split("\n") |> Enum.map(&String.to_integer/1)

      true ->
        input
    end
  end
end
