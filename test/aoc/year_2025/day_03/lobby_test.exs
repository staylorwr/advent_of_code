defmodule Aoc.Year2025.Day03.LobbyTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2025.Day03.Lobby, import: true

  alias Aoc.Year2025.Day03.Lobby, as: Day03

  @example """
  987654321111111
  811111111111119
  234234234234278
  818181911112111
  """

  describe "part_1/1" do
    test "examples" do
      assert Day03.part_1(@example) == 357
    end

    @tag day: 03, year: 2025
    test "input", %{input: input} do
      assert input |> Day03.part_1() == 17376
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert Day03.part_2(@example) == 3_121_910_778_619
    end

    @tag day: 03, year: 2025
    test "input", %{input: input} do
      assert input |> Day03.part_2() == 172_119_830_406_258
    end
  end
end
