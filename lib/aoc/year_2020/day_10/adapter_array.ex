defmodule Aoc.Year2020.Day10.AdapterArray do
  @moduledoc """
  ## --- Day 10: Adapter Array ---

  Patched into the aircraft's data port, you discover weather forecasts of a
  massive tropical storm. Before you can figure out whether it will impact your
  vacation plans, however, your device suddenly turns off!

  Its battery is dead.

  You'll need to plug it in. There's only one problem: the charging outlet near
  your seat produces the wrong number of *jolts*. Always prepared, you make a list
  of all of the joltage adapters in your bag.

  Each of your joltage adapters is rated for a specific *output joltage* (your
  puzzle input). Any given adapter can take an input `1`, `2`, or `3` jolts
  *lower* than its rating and still produce its rated output joltage.

  In addition, your device has a built-in joltage adapter rated for *`3` jolts
  higher* than the highest-rated adapter in your bag. (If your adapter list were
  `3`, `9`, and `6`, your device's built-in adapter would be rated for `12`
  jolts.)

  Treat the charging outlet near your seat as having an effective joltage rating
  of `0`.

  Since you have some time to kill, you might as well test all of your adapters.
  Wouldn't want to get to your resort and realize you can't even charge your
  device!

  If you *use every adapter in your bag* at once, what is the distribution of
  joltage differences between the charging outlet, the adapters, and your device?

  For example, suppose that in your bag, you have adapters with the following
  joltage ratings:

  ```
  16
  10
  15
  5
  1
  11
  7
  19
  6
  12
  4
  ```

  With these adapters, your device's built-in joltage adapter would be rated for
  `19 + 3 = *22*` jolts, 3 higher than the highest-rated adapter.

  Because adapters can only connect to a source 1-3 jolts lower than its rating,
  in order to use every adapter, you'd need to choose them like this:

  - The charging outlet has an effective rating of `0` jolts, so the only adapters that could connect to it directly would need to have a joltage rating of `1`, `2`, or `3` jolts. Of these, only one you have is an adapter rated `1` jolt (difference of *`1`*).
  - From your `1`-jolt rated adapter, the only choice is your `4`-jolt rated adapter (difference of *`3`*).
  - From the `4`-jolt rated adapter, the adapters rated `5`, `6`, or `7` are valid choices. However, in order to not skip any adapters, you have to pick the adapter rated `5` jolts (difference of *`1`*).
  - Similarly, the next choices would need to be the adapter rated `6` and then the adapter rated `7` (with difference of *`1`* and *`1`*).
  - The only adapter that works with the `7`-jolt rated adapter is the one rated `10` jolts (difference of *`3`*).
  - From `10`, the choices are `11` or `12`; choose `11` (difference of *`1`*) and then `12` (difference of *`1`*).
  - After `12`, only valid adapter has a rating of `15` (difference of *`3`*), then `16` (difference of *`1`*), then `19` (difference of *`3`*).
  - Finally, your device's built-in adapter is always 3 higher than the highest adapter, so its rating is `22` jolts (always a difference of *`3`*).
  In this example, when using every adapter, there are *`7`* differences of 1 jolt
  and *`5`* differences of 3 jolts.

  Here is a larger example:

  ```
  28
  33
  18
  42
  31
  14
  46
  20
  48
  47
  24
  23
  49
  45
  19
  38
  39
  11
  1
  32
  25
  35
  8
  17
  7
  9
  4
  2
  34
  10
  3
  ```
  In this larger example, in a chain that uses all of the adapters, there are
  *`22`* differences of 1 jolt and *`10`* differences of 3 jolts.

  Find a chain that uses all of your adapters to connect the charging outlet to
  your device's built-in adapter and count the joltage differences between the
  charging outlet, the adapters, and your device. *What is the number of 1-jolt
  differences multiplied by the number of 3-jolt differences?*


  """

  @doc """

  """
  def part_1(input) do
    %{jolts: {j1, _j2, j3}} =
      input
      |> Enum.sort()
      |> Enum.reduce(%{value: 0, jolts: {0, 0, 0}}, fn x, %{value: value, jolts: {j1, j2, j3}} ->
        case x - value do
          1 ->
            %{value: value + 1, jolts: {j1 + 1, j2, j3}}

          2 ->
            %{value: value + 2, jolts: {j1, j2 + 1, j3}}

          3 ->
            %{value: value + 3, jolts: {j1, j2, j3 + 1}}
        end
      end)

    j1 * (j3 + 1)
  end

  @doc """

  """
  def part_2(input) do
    [0 | Enum.sort(input)]
    |> jolt_differentials()
    |> Enum.chunk_by(fn v -> v == 1 end)
    |> Enum.reject(fn v -> v == [1] || Enum.all?(v, &(&1 == 3)) end)
    |> Enum.map(&length/1)
    |> Enum.map(&to_permutation_count/1)
    |> Enum.reduce(1, fn x, acc -> x * acc end)
  end

  defp jolt_differentials([_a]), do: [3]

  defp jolt_differentials([a, b | rest]) do
    [b - a | jolt_differentials([b | rest])]
  end

  # 3 sequential numbers - 2 different permutations
  # 4 7 8 9 12
  # 4 7   9 12
  defp to_permutation_count(2), do: 2

  # 4 sequential numbers - 4 permutations
  # 4 7 8 9 10 13
  # 4 7   9 10 13
  # 4 7 8   10 13
  # 4 7     10 13
  defp to_permutation_count(3), do: 4

  # 5 sequential numbers - 7 permutations
  # 4 7 8 9 10 11 14
  # 4 7   9 10 11 14
  # 4 7 8   10 11 14
  # 4 7 8 9    11 14
  # 4 7     10 11 14
  # 4 7 8      11 14
  # 4 7   9    11 14
  defp to_permutation_count(4), do: 7
end
