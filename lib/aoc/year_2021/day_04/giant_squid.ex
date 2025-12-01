defmodule Aoc.Year2021.Day04.GiantSquid do
  @moduledoc """
  ## --- Day 4: Giant Squid ---

  You're already almost 1.5km (almost a mile) below the surface of the ocean,
  already so deep that you can't see any sunlight. What you *can* see, however, is
  a giant squid that has attached itself to the outside of your submarine.

  Maybe it wants to play bingo?
  """

  @doc """
  Determine which board will win given the game of bingo and return it's score
  """
  def part_1(input) do
    {numbers, boards} = parse(input)

    boards
    |> winners(numbers)
    |> Enum.min_by(fn {winning_numbers, _board} ->
      Enum.count(winning_numbers)
    end)
    |> score()
  end

  @doc """
  Determine which board will lose given the game of bingo and return it's score

  """
  def part_2(input) do
    {numbers, boards} = parse(input)

    boards
    |> winners(numbers)
    |> Enum.max_by(fn {winning_numbers, _board} ->
      Enum.count(winning_numbers)
    end)
    |> score()
  end

  @doc """
  Parse a string into a list of boards and choosen numbers.

  ## Examples

      iex> parse("
      ...> 1,4,7,2,5,8,3,6,9
      ...>
      ...> 1 2 3
      ...> 4 5 6
      ...> 7 8 9
      ...>
      ...> 9 8 7
      ...> 6 5 4
      ...> 3 2 1
      ...> ")
      {[1,4,7,2,5,8,3,6,9], [[[1,2,3],[4,5,6],[7,8,9]],[[9,8,7],[6,5,4],[3,2,1]]]}
  """
  @spec parse(String.t()) :: {list(integer), list(list(list(integer)))}
  def parse(input) do
    [numbers | boards] =
      input
      |> String.trim()
      |> String.split("\n\n")

    {parse_numbers(numbers), Enum.map(boards, &parse_board/1)}
  end

  @doc """
  Parse a CSV of numbers into a list of integers

  ## Examples

      iex> parse_numbers("1,2,3")
      [1,2,3]

  """
  def parse_numbers(numbers, sep \\ ","),
    do: numbers |> String.split(sep, trim: true) |> Enum.map(&String.to_integer/1)

  @doc """
  Parse a string each representing a board into a board

  ## Examples

      iex> parse_board("
      ...> 1 2 3
      ...> 4 5 6
      ...> 7 8 9
      ...> ")
      [[1,2,3],[4,5,6],[7,8,9]]

  """
  def parse_board(input) do
    input
    |> String.trim()
    |> String.split("\n", trim: true)
    |> Enum.map(fn row ->
      row
      |> String.trim()
      |> parse_numbers(" ")
    end)
  end

  @doc """
  Computes the numbers to be drawn for each of the given boards to win.

  ## Examples

      iex> board_a = [[1,2,3],[4,5,6],[7,8,9]]
      iex> board_b = [[1,5,3],[2,6,4],[8,7,9]]
      iex> winners([board_a, board_b], [4,7,2,3,1,5,9,8])
      [{[4,7,2,3,1], board_a}, {[4,7,2,3,1,5], board_b}]
  """
  def winners(boards, numbers) do
    boards
    |> Enum.map(fn board ->
      numbers
      |> heads()
      |> Enum.find_value(fn marked_num ->
        if winner?(board, marked_num) do
          {marked_num, board}
        end
      end)
    end)
  end

  @doc """
  Determine if the given board is a winner for the provided list of numbers.

  ## Examples

      iex> board = [[1,2,3],[4,5,6],[7,8,9]]
      iex> winner?(board, [1,4,7])
      true
      iex> winner?(board, [1,2,3])
      true
      iex> winner?(board, [1,5,9])

  """
  def winner?(board, num) do
    winning_row?(board, num) or winning_row?(transpose(board), num)
  end

  @doc """
  Determine if the row (a list of integers) contains all of the winning numbers

  ## Examples

      iex> winning_row?([[1,2,3]], [1,2,3])
      true
      iex> winning_row?([[4,2,3]], [1,2,3])
      false
      iex> winning_row?([[1,2,3]], [1,2,3,4])
      true
  """
  def winning_row?(board, numbers) do
    Enum.any?(board, fn row -> row -- numbers === [] end)
  end

  @doc """
  Returns a list of all of the heads of a given list

  ## Examples

      iex> heads([1,2])
      [[1],[1,2]]
  """
  def heads(enum) do
    enum
    |> Enum.scan([], fn x, acc -> [x | acc] end)
    |> Enum.map(&Enum.reverse/1)
  end

  @doc """
  Score a board: sum of all of the unmarked numbers multiplied by
  the last number called

  ## Examples

      iex> score({[1,8,2,7,3,9], [[1,2,3],[4,5,6],[7,8,9]]})
      135
  """
  def score({numbers, board}) do
    unmarked_numbers =
      board
      |> List.flatten()
      |> Enum.reject(&(&1 in numbers))

    last_number = Enum.at(numbers, -1)
    Enum.sum(unmarked_numbers) * last_number
  end

  defp transpose(rows) do
    rows
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
  end
end
