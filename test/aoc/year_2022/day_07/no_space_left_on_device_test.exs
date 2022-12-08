defmodule Aoc.Year2022.Day07.NoSpaceLeftOnDeviceTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2022.Day07.NoSpaceLeftOnDevice, import: true

  alias Aoc.Year2022.Day07.NoSpaceLeftOnDevice, as: Day07

  @example """
  $ cd /
  $ ls
  dir a
  14848514 b.txt
  8504156 c.dat
  dir d
  $ cd a
  $ ls
  dir e
  29116 f
  2557 g
  62596 h.lst
  $ cd e
  $ ls
  584 i
  $ cd ..
  $ cd ..
  $ cd d
  $ ls
  4060174 j
  8033020 d.log
  5626152 d.ext
  7214296 k
  """

  describe "part_1/1" do
    test "examples" do
      assert Day07.part_1(@example) == 95437
    end

    @tag day: 07, year: 2022
    test "input", %{input: input} do
      assert input |> Day07.part_1() == 1_427_048
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert Day07.part_2(@example) == 24_933_642
    end

    @tag day: 07, year: 2022
    test "input", %{input: input} do
      assert input |> Day07.part_2() == 2_940_614
    end
  end
end
