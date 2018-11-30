defmodule Aoc.Year2017.Day01.InverseCaptchaTest do
  use Aoc.DayCase
  doctest Aoc.Year2017.Day01.InverseCaptcha, import: true

  alias Aoc.Year2017.Day01.InverseCaptcha

  describe "part_1/1" do
    test "examples" do
      assert InverseCaptcha.part_1("1122") == 3
      assert InverseCaptcha.part_1("1111") == 4
      assert InverseCaptcha.part_1("1234") == 0
      assert InverseCaptcha.part_1("91212129") == 9
    end

    @tag day: 01, year: 2017
    test "input", %{input: input} do
      assert input |> InverseCaptcha.part_1() == 1390
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert InverseCaptcha.part_2("1212") == 6
      assert InverseCaptcha.part_2("1221") == 0
      assert InverseCaptcha.part_2("123425") == 4
      assert InverseCaptcha.part_2("123123") == 12
      assert InverseCaptcha.part_2("12131415") == 4
    end

    @tag day: 01, year: 2017
    test "input", %{input: input} do
      assert input |> InverseCaptcha.part_2() == 1232
    end
  end
end
