defmodule Aoc.DayCase do
  @moduledoc """
  An extremely simple test case used to load challenge inputs
  """
  use ExUnit.CaseTemplate

  setup tags do
    if tags[:day] do
      {:ok, input: Aoc.InputLoader.input(tags[:year], tags[:day], tags)}
    else
      :ok
    end
  end
end
