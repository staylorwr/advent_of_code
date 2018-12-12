defmodule Aoc.Year2018.Day11.ChronalChargeTest do
  use Aoc.DayCase
  doctest Aoc.Year2018.Day11.ChronalCharge, import: true

  alias Aoc.Year2018.Day11.ChronalCharge

  @input 1308

  @tag day: 11, year: 2018
  test "part 1 input" do
    assert @input |> ChronalCharge.part_1() == {{21, 24, 3}, 31}
  end

  @tag day: 11, year: 2018
  test "part 2 input" do
    assert @input |> ChronalCharge.part_2() == {{227, 199, 19}, 103}
  end
end
