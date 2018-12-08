defmodule Aoc.Year2018.Day07.TheSumofItsPartsTest do
  use Aoc.DayCase
  doctest Aoc.Year2018.Day07.TheSumofItsParts, import: true

  import ExUnit.CaptureIO

  alias Aoc.Year2018.Day07.TheSumofItsParts

  @example """
  Step C must be finished before step A can begin.
  Step C must be finished before step F can begin.
  Step A must be finished before step B can begin.
  Step A must be finished before step D can begin.
  Step B must be finished before step E can begin.
  Step D must be finished before step E can begin.
  Step F must be finished before step E can begin.
  """

  describe "part_1/1" do
    test "examples" do
      assert TheSumofItsParts.part_1(@example) == "CABDFE"
    end

    @tag day: 07, year: 2018
    test "input", %{input: input} do
      assert input |> TheSumofItsParts.part_1() == "BFLNGIRUSJXEHKQPVTYOCZDWMA"
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert TheSumofItsParts.part_2(@example, workers: 2, delay: 0) == 15
    end

    @tag day: 07, year: 2018
    test "input", %{input: input} do
      assert input |> TheSumofItsParts.part_2(workers: 5, delay: 60) == 880
    end

    @table """
    Second   Worker 1   Worker 2   Done
       0        C          .
       1        C          .
       2        C          .
       3        A          F       C
       4        B          F       CA
       5        B          F       CA
       6        D          F       CAB
       7        D          F       CAB
       8        D          F       CAB
       9        D          .       CABF
      10        E          .       CABFD
      11        E          .       CABFD
      12        E          .       CABFD
      13        E          .       CABFD
      14        E          .       CABFD
      15        .          .       CABFDE
    """
    test "table matches" do
      options = [workers: 2, delay: 0, print: true]

      fun = fn ->
        assert 15 == @example |> TheSumofItsParts.part_2(options)
      end

      table = fun |> capture_io |> String.trim_leading("\n")

      assert @table == table
    end
  end

  describe "build_dependencies/1" do
    test "builds parent to children list" do
      input = [
        ["C", "A"],
        ["C", "F"],
        ["A", "B"],
        ["A", "D"],
        ["B", "E"],
        ["D", "E"],
        ["F", "E"]
      ]

      expected = %{
        "A" => ["C"],
        "B" => ["A"],
        "C" => [],
        "D" => ["A"],
        "E" => ["F", "D", "B"],
        "F" => ["C"]
      }

      assert expected == TheSumofItsParts.build_dependencies(input)
    end
  end

  describe "time_needed/1" do
    test "determines time needed for task based on name" do
      assert 1 = "A" |> TheSumofItsParts.time_needed()
      assert 2 = "B" |> TheSumofItsParts.time_needed()
      assert 3 = "C" |> TheSumofItsParts.time_needed()
      assert 4 = "D" |> TheSumofItsParts.time_needed()
      assert 5 = "E" |> TheSumofItsParts.time_needed()
      assert 6 = "F" |> TheSumofItsParts.time_needed()
    end
  end
end
