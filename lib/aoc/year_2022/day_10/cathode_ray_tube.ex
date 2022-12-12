defmodule Aoc.Year2022.Day10.CathodeRayTube do
  alias __MODULE__.{Parser, Part1, State}

  def part_1(input) do
    input
    |> Parser.parse()
    |> State.new()
    |> Part1.solve()
    |> Stream.take_while(&Enum.any?(&1.program))
    |> Stream.take_every(40)
    |> Enum.map(&(&1.cycles * &1.x))
    |> Enum.sum()
  end

  def part_2(input) do
    input
    |> Parser.parse()
    |> State.new()
    |> Part1.solve()
    |> Enum.take(222)
    |> then(&Enum.at(&1, -1).output)
  end

  defmodule Part1 do
    def solve(state) do
      state
      |> Stream.iterate(&iterate/1)
      |> Stream.drop(19)
    end

    defp iterate(state) do
      sprite = (state.x - 1)..(state.x + 1)
      index = rem(state.cycles - 1, 40)
      text = if index in sprite, do: "#", else: "."
      text = text <> if index == 39, do: "\n", else: ""
      run(%{state | output: state.output <> text})
    end

    defp run(state = %{program: []}), do: state

    defp run(state = %{program: [:noop | tail]}) do
      %{state | cycles: state.cycles + 1, program: tail}
    end

    defp run(state = %{program: [{:addx, n} | tail]}) do
      %{state | cycles: state.cycles + 1, program: tail, x: state.x + n}
    end
  end

  defmodule Parser do
    def parse(input) do
      input
      |> String.split("\n", trim: true)
      |> Enum.flat_map(&parse_line/1)
    end

    def parse_line("noop"), do: [:noop]
    def parse_line("addx " <> value), do: [:noop, {:addx, String.to_integer(value)}]
  end

  defmodule State do
    defstruct cycles: 1, x: 1, program: [], output: ""

    def new(program) do
      %__MODULE__{program: program}
    end
  end
end
