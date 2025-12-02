defmodule Aoc.Year2025.Day02.GiftShopTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2025.Day02.GiftShop, import: true

  alias Aoc.Year2025.Day02.GiftShop, as: Day02

  @example "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"

  describe "part_1/1" do
    test "examples" do
      assert Day02.part_1(@example) == 1_227_775_554
    end

    @tag day: 02, year: 2025
    test "input", %{input: input} do
      assert input |> Day02.part_1() == 12_850_231_731
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert Day02.part_2(@example) == 4_174_379_265
    end

    @tag day: 02, year: 2025
    test "input", %{input: input} do
      assert input |> Day02.part_2() == 24_774_350_322
    end
  end
end
