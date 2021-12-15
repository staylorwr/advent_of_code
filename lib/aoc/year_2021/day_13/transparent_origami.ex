defmodule Aoc.Year2021.Day13.TransparentOrigami do
  @doc """
  Return the count of coordinates after the first fold.
  """
  def part_1(input) do
    {coords, [first_fold | _]} = parse(input)

    result = process_fold(coords, first_fold)
    MapSet.size(result)
  end

  @doc """
  Return the code that is present in the instructions
  after all of the folding is complete as an ASCII output
  """
  def part_2(input) do
    {coords, folds} = parse(input)

    completed =
      Enum.reduce(folds, coords, fn fold, folded ->
        process_fold(folded, fold)
      end)

    {width, _} = Enum.max_by(completed, &elem(&1, 0))
    {_, height} = Enum.max_by(completed, &elem(&1, 1))
    {:ok, pid} = StringIO.open("foo")

    for y <- 0..height do
      for x <- 0..width do
        if MapSet.member?(completed, {x, y}) do
          IO.write(pid, " # ")
        else
          IO.write(pid, "   ")
        end
      end

      IO.puts(pid, "")
    end

    {_, output} = StringIO.contents(pid)
    IO.puts(output)
    output
  end

  @doc """
  Parse a list of instructions

  ## Examples

      iex> parse("
      ...>6,10
      ...>0,14
      ...>
      ...>fold along y=7
      ...>fold along x=5")
      {MapSet.new([{6,10}, {0,14}]), [{:fold_y, 7}, {:fold_x, 5}]}
  """
  def parse(input) do
    [coords, folds] = String.split(input, "\n\n", trim: true)
    {parse_coords(coords), parse_folds(folds)}
  end

  def parse_coords(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [x_line, y_line] = String.split(line, ",")
      {String.to_integer(x_line), String.to_integer(y_line)}
    end)
    |> MapSet.new()
  end

  def parse_folds(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn
      <<"fold along x=", x::binary>> -> {:fold_x, String.to_integer(x)}
      <<"fold along y=", y::binary>> -> {:fold_y, String.to_integer(y)}
    end)
  end

  @doc """
  Process a fold by 'folding' or mirroring the coordinates over the given
  fold line, represented by the respective x or y coordinate of the line.

  ## Examples

  Fold along x=2:

  . # | . .
  . . | . .
  . . | . .
  . . | . .
  . . | . #

  Gives:

  . #
  . .
  . .
  . .
  # .

      iex> process_fold(MapSet.new([{1,0}, {4,4}]), {:fold_x, 2})
      MapSet.new([{1, 0}, {0, 4}])

  Fold along y=1:

  . # . . .
  . . . . .
  _ _ _ _ _
  . . . . .
  . . . . #

  Gives:

  . # . . #
  . . . . .

      iex> process_fold(MapSet.new([{1,0}, {4,4}]), {:fold_y, 2})
      MapSet.new([{4, 0}, {1, 0}])

  """
  def process_fold(set, {:fold_x, line}) do
    set
    |> Enum.filter(fn {x, _y} -> x > line end)
    |> Enum.reduce(set, fn {x, y} = dot, folded_set ->
      folded_set
      |> MapSet.delete(dot)
      |> MapSet.put({abs(x - line * 2), y})
    end)
  end

  def process_fold(set, {:fold_y, line}) do
    set
    |> Enum.filter(fn {_x, y} -> y > line end)
    |> Enum.reduce(set, fn {x, y} = dot, folded_set ->
      folded_set
      |> MapSet.delete(dot)
      |> MapSet.put({x, abs(y - line * 2)})
    end)
  end
end
