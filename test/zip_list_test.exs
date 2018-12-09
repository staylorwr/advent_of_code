defmodule ZipListTest do
  use ExUnit.Case

  describe "new/insert" do
    test "basic iteration" do
      zl = ZipList.new()

      assert zl == {[], []}

      zl = ZipList.insert(zl, 1)
      assert zl == {[], [1]}

      assert ZipList.current(zl) == 1
      assert ZipList.to_list(zl) == [1]

      zl = zl |> ZipList.insert(2) |> ZipList.next()
      assert ZipList.to_list(zl) == [2, 1]
    end
  end
end
