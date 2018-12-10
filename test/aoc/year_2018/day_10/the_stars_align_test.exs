defmodule Aoc.Year2018.Day10.TheStarsAlignTest do
  use Aoc.DayCase
  doctest Aoc.Year2018.Day10.TheStarsAlign, import: true

  alias Aoc.Year2018.Day10.TheStarsAlign

  @example """
  position=< 9,  1> velocity=< 0,  2>
  position=< 7,  0> velocity=<-1,  0>
  position=< 3, -2> velocity=<-1,  1>
  position=< 6, 10> velocity=<-2, -1>
  position=< 2, -4> velocity=< 2,  2>
  position=<-6, 10> velocity=< 2, -2>
  position=< 1,  8> velocity=< 1, -1>
  position=< 1,  7> velocity=< 1,  0>
  position=<-3, 11> velocity=< 1, -2>
  position=< 7,  6> velocity=<-1, -1>
  position=<-2,  3> velocity=< 1,  0>
  position=<-4,  3> velocity=< 2,  0>
  position=<10, -3> velocity=<-1,  1>
  position=< 5, 11> velocity=< 1, -2>
  position=< 4,  7> velocity=< 0, -1>
  position=< 8, -2> velocity=< 0,  1>
  position=<15,  0> velocity=<-2,  0>
  position=< 1,  6> velocity=< 1,  0>
  position=< 8,  9> velocity=< 0, -1>
  position=< 3,  3> velocity=<-1,  1>
  position=< 0,  5> velocity=< 0, -1>
  position=<-2,  2> velocity=< 2,  0>
  position=< 5, -2> velocity=< 1,  2>
  position=< 1,  4> velocity=< 2,  1>
  position=<-2,  7> velocity=< 2, -2>
  position=< 3,  6> velocity=<-1, -1>
  position=< 5,  0> velocity=< 1,  0>
  position=<-6,  0> velocity=< 2,  0>
  position=< 5,  9> velocity=< 1, -2>
  position=<14,  7> velocity=<-2,  0>
  position=<-3,  6> velocity=< 2, -1>
  """

  describe "part_1/1" do
    test "examples" do
      assert {graph, 3} = TheStarsAlign.part_1(@example)
    end

    @tag day: 10, year: 2018
    test "input", %{input: input} do
      {graph, 10710} = TheStarsAlign.part_1(input)
      IO.puts(visualize(graph))
    end
  end

  def visualize(points) do
    points =
      Enum.map(points, fn {point, _vel} ->
        point
      end)

    {min_x, max_x} = points |> Enum.map(&elem(&1, 0)) |> Enum.min_max()
    {min_y, max_y} = points |> Enum.map(&elem(&1, 1)) |> Enum.min_max()

    Enum.reduce(min_y..max_y, "", fn y, str ->
      Enum.reduce(min_x..max_x, str, fn x, str ->
        if Enum.member?(points, {x, y}) do
          str <> "X"
        else
          str <> "."
        end
      end) <> "\n"
    end)
  end
end
