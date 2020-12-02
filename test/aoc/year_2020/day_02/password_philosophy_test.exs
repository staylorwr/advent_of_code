defmodule Aoc.Year2020.Day02.PasswordPhilosophyTest do
  use Aoc.DayCase
  doctest Aoc.Year2020.Day02.PasswordPhilosophy, import: true

  alias Aoc.Year2020.Day02.PasswordPhilosophy, as: Day02

  @example """
  1-3 a: abcde
  1-3 b: cdefg
  2-9 c: ccccccccc
  """

  describe "part_1/1" do
    test "examples" do
      assert Day02.part_1(@example) == 2
    end

    @tag day: 02, year: 2020
    test "input", %{input: input} do
      assert input |> Day02.part_1() == 10
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert Day02.part_2(@example) == 1
    end

    @tag day: 02, year: 2020
    test "input", %{input: input} do
      assert input |> Day02.part_2() == input
    end
  end

  test "in_range_rule?" do
    assert Day02.in_range_rule?("1-3 a: abcde")
    refute Day02.in_range_rule?("1-3 b: cdefg")
    assert Day02.in_range_rule?("2-9 c: ccccccccc")
  end

  test "exact_character?" do
    assert Day02.exact_character?("1-3 a: abcde")
    refute Day02.exact_character?("1-3 b: cdefg")
    refute Day02.exact_character?("2-9 c: ccccccccc")
  end
end
