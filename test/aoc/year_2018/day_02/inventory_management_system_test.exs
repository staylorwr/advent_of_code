defmodule Aoc.Year2018.Day02.InventoryManagementSystemTest do
  use Aoc.DayCase
  doctest Aoc.Year2018.Day02.InventoryManagementSystem, import: true

  alias Aoc.Year2018.Day02.InventoryManagementSystem

  @test_input """
  abcdef
  bababc
  abbcde
  abcccd
  aabcdd
  abcdee
  ababab
  """

  describe "part_1/1" do
    test "examples" do
      assert @test_input |> InventoryManagementSystem.part_1() == 12
    end

    @tag day: 02, year: 2018
    test "input", %{input: input} do
      assert input |> InventoryManagementSystem.part_1() == 7533
    end
  end

  describe "part_2/1" do
    test "examples" do
      input = """
      abcde
      fghij
      klmno
      pqrst
      fguij
      axcye
      wvxyz
      """

      assert input |> InventoryManagementSystem.part_2() == ["fgij"]
    end

    @tag day: 02, year: 2018
    test "input", %{input: input} do
      assert input |> InventoryManagementSystem.part_2() == ["mphcuasvrnjzzkbgdtqeoylva"]
    end
  end
end
