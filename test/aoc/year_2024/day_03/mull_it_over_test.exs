defmodule Aoc.Year2024.Day03.MullItOverTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2024.Day03.MullItOver, import: true

  alias Aoc.Year2024.Day03.MullItOver, as: Day03

  @example "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"

  describe "part_1/1" do
    test "examples" do
      assert Day03.part_1(@example) == 161
    end

    @tag day: 03, year: 2024
    test "input", %{input: input} do
      assert input |> Day03.part_1() == input
    end
  end

  @part_2_example "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

  describe "part_2/1" do
    test "examples" do
      assert Day03.part_2(@part_2_example) == 48
    end

    @tag day: 03, year: 2024
    test "input", %{input: input} do
      assert input |> Day03.part_2() == input
    end
  end
end
