defmodule Aoc.Year2018.Day09.MarbleManiaTest do
  use Aoc.DayCase
  doctest Aoc.Year2018.Day09.MarbleMania, import: true

  alias Aoc.Year2018.Day09.MarbleMania

  describe "winning_score/2" do
    test "examples" do
      assert MarbleMania.winning_score(9, 25) == 32
      assert MarbleMania.winning_score(9, 46) == 63
      assert MarbleMania.winning_score(10, 1618) == 8317
      assert MarbleMania.winning_score(13, 7999) == 146_373
      assert MarbleMania.winning_score(17, 1104) == 2764
      assert MarbleMania.winning_score(21, 6111) == 54718
      assert MarbleMania.winning_score(30, 5807) == 37305
    end

    @tag day: 08, year: 2018
    test "test" do
      assert MarbleMania.winning_score(465, 71940) == 384_475
      assert MarbleMania.winning_score(465, 7_194_000) == 3_187_566_597
    end
  end
end
