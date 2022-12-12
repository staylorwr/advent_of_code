defmodule Aoc.Year2022.Day11.MonkeyintheMiddleTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2022.Day11.MonkeyintheMiddle, import: true

  alias Aoc.Year2022.Day11.MonkeyintheMiddle, as: Day11

  @example """
  Monkey 0:
    Starting items: 79, 98
    Operation: new = old * 19
    Test: divisible by 23
      If true: throw to monkey 2
      If false: throw to monkey 3

  Monkey 1:
    Starting items: 54, 65, 75, 74
    Operation: new = old + 6
    Test: divisible by 19
      If true: throw to monkey 2
      If false: throw to monkey 0

  Monkey 2:
    Starting items: 79, 60, 97
    Operation: new = old * old
    Test: divisible by 13
      If true: throw to monkey 1
      If false: throw to monkey 3

  Monkey 3:
    Starting items: 74
    Operation: new = old + 3
    Test: divisible by 17
      If true: throw to monkey 0
      If false: throw to monkey 1

  """

  describe "part_1/1" do
    test "examples" do
      assert Day11.part_1(@example) == 10605
    end

    @tag day: 11, year: 2022
    test "input", %{input: input} do
      assert input |> Day11.part_1() == 61005
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert Day11.part_2(@example) == 2_713_310_158
    end

    @tag day: 11, year: 2022
    test "input", %{input: input} do
      assert input |> Day11.part_2() == 20_567_144_694
    end
  end

  test "Parser.parse translates to monkeys" do
    result = Day11.Parser.parse(@example)

    assert result |> Map.keys() |> length() == 4
    [m0 | _rest] = Map.values(result)

    assert m0 == %Day11.Monkey{
             id: 0,
             items: [79, 98],
             divisor: 23,
             operator: :*,
             factor: 19,
             true_target: 2,
             false_target: 3
           }
  end
end
