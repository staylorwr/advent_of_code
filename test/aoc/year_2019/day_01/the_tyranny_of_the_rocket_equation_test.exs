defmodule Aoc.Year2019.Day01.TheTyrannyoftheRocketEquationTest do
  use Aoc.DayCase
  doctest Aoc.Year2019.Day01.TheTyrannyoftheRocketEquation, import: true

  alias Aoc.Year2019.Day01.TheTyrannyoftheRocketEquation, as: Day1

  describe "fuel_for_dry_mass/1" do
    test "examples" do
      assert Day1.fuel_for_dry_mass(12) == 2
      assert Day1.fuel_for_dry_mass(14) == 2
      assert Day1.fuel_for_dry_mass(1969) == 654
      assert Day1.fuel_for_dry_mass(100_756) == 33583
    end

    @tag day: 01, year: 2019, as_int_list: true
    test "input", %{input: input} do
      val =
        input
        |> Enum.map(&Day1.fuel_for_dry_mass(&1))
        |> Enum.sum()

      assert val == 3_375_962
    end
  end

  describe "fuel_for_wet_mass/1" do
    test "examples" do
      assert Day1.fuel_for_wet_mass(12) == 2
      assert Day1.fuel_for_wet_mass(14) == 2
      assert Day1.fuel_for_wet_mass(1969) == 966
      assert Day1.fuel_for_wet_mass(100_756) == 50346
    end

    @tag day: 01, year: 2019, as_int_list: true
    test "input", %{input: input} do
      val =
        input
        |> Enum.map(&Day1.fuel_for_wet_mass(&1))
        |> Enum.sum()

      assert val == 5_061_072
    end
  end
end
