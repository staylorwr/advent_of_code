defmodule Aoc.Year2021.Day08.SevenSegmentSearchTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2021.Day08.SevenSegmentSearch, import: true

  alias Aoc.Year2021.Day08.SevenSegmentSearch, as: Day08

  @example """
  be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
  edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
  fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
  fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
  aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
  fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
  dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
  bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
  egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
  gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
  """

  describe "part_1/1" do
    test "examples" do
      assert Day08.part_1(@example) == 26
    end

    @tag day: 08, year: 2021
    test "input", %{input: input} do
      assert input |> Day08.part_1() == 543
    end
  end

  describe "part_2/1" do
    @tag day: 08, year: 2021
    test "input", %{input: input} do
      assert input |> Day08.part_2() == input
    end
  end
end
