defmodule Aoc.Year2023.Day04.Scratchcards do
  alias __MODULE__.Parser

  def part_1(input) do
    input
    |> Parser.parse()
    |> Enum.map(& &1.score)
    |> Enum.sum()
  end

  def part_2(input) do
    cards = Parser.parse(input)
    amounts = Map.new(cards, fn card -> {card.id, 1} end)

    cards
    |> Enum.filter(&(&1.gives > 0))
    |> Enum.map(&{&1.id, (&1.id + 1)..(&1.id + &1.gives)})
    |> Enum.reduce(amounts, fn {card_id, range}, amounts ->
      copies = amounts[card_id]

      Enum.reduce(range, amounts, fn i, amounts ->
        Map.replace_lazy(amounts, i, &(&1 + copies))
      end)
    end)
    |> Map.values()
    |> Enum.sum()
  end

  defmodule Parser do
    alias Aoc.Year2023.Day04.Scratchcards.Card

    def parse(input) do
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&Card.new/1)
    end
  end

  defmodule Card do
    defstruct [:id, :numbers, :winners, :score, :gives]

    def new(line) do
      [_, card, winning, have] = Regex.run(~r/Card\s+(\d+):(.*)\|(.*)/, line)

      %__MODULE__{
        id: String.to_integer(card),
        numbers: to_int_mapset(have),
        winners: to_int_mapset(winning)
      }
      |> score()
    end

    def to_int_mapset(str) do
      str
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> MapSet.new()
    end

    def score(%__MODULE__{numbers: numbers, winners: winners} = card) do
      winning_numbers =
        numbers
        |> MapSet.intersection(winners)
        |> MapSet.size()

      score = if winning_numbers == 0, do: 0, else: Integer.pow(2, winning_numbers - 1)
      %{card | score: score, gives: winning_numbers}
    end
  end
end
