defmodule Aoc.Year2018.Day03.NoMatterHowYouSliceItTest do
  use Aoc.DayCase
  doctest Aoc.Year2018.Day03.NoMatterHowYouSliceIt, import: true

  alias Aoc.Year2018.Day03.NoMatterHowYouSliceIt

  @claims """
    #1 @ 1,3: 4x4
    #2 @ 3,1: 4x4
    #3 @ 5,5: 2x2
  """

  describe "part_1/1" do
    test "examples" do
      assert NoMatterHowYouSliceIt.part_1(@claims) == 4
    end

    @tag day: 03, year: 2018
    test "input", %{input: input} do
      assert input |> NoMatterHowYouSliceIt.part_1() == 118_539
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert NoMatterHowYouSliceIt.part_2(@claims) == {3, 4}
    end

    @tag day: 03, year: 2018
    test "input", %{input: input} do
      assert input |> NoMatterHowYouSliceIt.part_2() == {1270, 384}
    end
  end
end
