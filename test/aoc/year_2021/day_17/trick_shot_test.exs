defmodule Aoc.Year2021.Day17.TrickShotTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2021.Day17.TrickShot, import: true

  alias Aoc.Year2021.Day17.TrickShot, as: Day17

  @example {20..30, -10..5}

  @input {241..273, -97..-63}

  describe "part_1/1" do
    test "examples" do
      assert Day17.part_1(@example) == 45
    end

    @tag day: 17, year: 2021
    test "input", %{input: _input} do
      assert Day17.part_1(@input) == 4656
    end
  end
end
