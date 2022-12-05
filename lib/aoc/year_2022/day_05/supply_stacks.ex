defmodule Aoc.Year2022.Day05.SupplyStacks do
  @moduledoc """
  ## --- Day 5: Supply Stacks ---

  The expedition can depart as soon as the final supplies have been unloaded from
  the ships. Supplies are stored in stacks of marked *crates*, but because the
  needed supplies are buried under many other crates, the crates need to be
  rearranged.

  The ship has a *giant cargo crane* capable of moving crates between stacks. To
  ensure none of the crates get crushed or fall over, the crane operator will
  rearrange them in a series of carefully-planned steps. After the crates are
  rearranged, the desired crates will be at the top of each stack.

  The Elves don't want to interrupt the crane operator during this delicate
  procedure, but they forgot to ask her *which* crate will end up where, and they
  want to be ready to unload them as soon as possible so they can embark.

  *After the rearrangement procedure completes, what crate ends up on top of each
  stack?*
  """

  def part_1(input) do
    initial_state = parse(input)
    final_state = Enum.reduce(initial_state.instructions, initial_state.stacks, &move/2)

    Enum.map(final_state, &List.first/1) |> Enum.join()
  end

  def part_2(input) do
    input
  end

  defmodule State do
    defstruct stacks: [], instructions: []
  end

  def move({count, from, to}, stacks) do
    Enum.reduce(1..count, stacks, fn _, current ->
      [moved | from_stack] = Enum.at(current, from - 1)
      new_destination_stack = [moved | Enum.at(current, to - 1)]

      current
      |> List.update_at(from - 1, fn _ -> from_stack end)
      |> List.update_at(to - 1, fn _ -> new_destination_stack end)
    end)
  end

  def parse(input) do
    [state, moves] =
      input
      |> String.trim_trailing()
      |> String.split("\n\n")
      |> Enum.map(&String.split(&1, "\n"))

    %State{
      stacks: parse_stacks(state),
      instructions: parse_instructions(moves)
    }
  end

  def parse_stacks(input) do
    input
    |> Enum.drop(-1)
    |> Enum.map(&parse_stack_line/1)
    |> transpose()
    |> Enum.map(&Enum.reject(&1, fn x -> x == " " end))
  end

  defp parse_stack_line(line) do
    line
    |> String.codepoints()
    |> Enum.chunk_every(4, 4, [" "])
    |> Enum.map(&Enum.at(&1, 1))
  end

  def parse_instructions(input) do
    Enum.map(input, fn line ->
      [count, from, to] =
        ~r/\d+/
        |> Regex.scan(line)
        |> List.flatten()
        |> Enum.map(&String.to_integer/1)

      {count, from, to}
    end)
  end

  def transpose(rows) do
    max_length = Enum.max_by(rows, &length(&1)) |> length()

    rows
    |> Enum.map(fn row ->
      row ++ List.duplicate(" ", max_length - length(row))
    end)
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
  end
end
