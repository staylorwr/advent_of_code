defmodule Aoc.Year2021.Day02.Dive do
  @moduledoc """
  ## --- Day 2: Dive! ---

  Now, you need to figure out how to pilot this thing.

  It seems like the submarine can take a series of commands like `forward 1`,
  `down 2`, or `up 3`:

  - `forward X` increases the horizontal position by `X` units.
  - `down X` *increases* the depth by `X` units.
  - `up X` *decreases* the depth by `X` units.

  Note that since you're on a submarine, `down` and `up` affect your *depth*, and
  so they have the opposite result of what you might expect.

  The submarine seems to already have a planned course (your puzzle input). You
  should probably figure out where it's going. For example:

  ```
  forward 5
  down 5
  forward 8
  up 3
  down 8
  forward 2
  ```

  Your horizontal position and depth both start at `0`. The steps above would then
  modify them as follows:

  - `forward 5` adds `5` to your horizontal position, a total of `5`.
  - `down 5` adds `5` to your depth, resulting in a value of `5`.
  - `forward 8` adds `8` to your horizontal position, a total of `13`.
  - `up 3` decreases your depth by `3`, resulting in a value of `2`.
  - `down 8` adds `8` to your depth, resulting in a value of `10`.
  - `forward 2` adds `2` to your horizontal position, a total of `15`.

  After following these instructions, you would have a horizontal position of `15`
  and a depth of `10`. (Multiplying these together produces `*150*`.)

  Calculate the horizontal position and depth you would have after following the
  planned course. *What do you get if you multiply your final horizontal position
  by your final depth?*
  """

  @doc """
  Track the distance and depth of the submarine as it works through a list of
  movement instructions
  """
  def part_1(input) do
    Enum.reduce(input, %{depth: 0, distance: 0}, fn
      "forward " <> dist, %{depth: d, distance: x} ->
        %{depth: d, distance: x + String.to_integer(dist)}

      "down " <> dist, %{depth: d, distance: x} ->
        %{depth: d + String.to_integer(dist), distance: x}

      "up " <> dist, %{depth: d, distance: x} ->
        %{depth: d - String.to_integer(dist), distance: x}
    end)
  end

  @doc """
  Track the distance, depth and aim of the submarine
  """
  def part_2(input) do
    Enum.reduce(input, %{depth: 0, distance: 0, aim: 0}, fn
      "forward " <> dist, %{depth: d, distance: x, aim: a} ->
        dist = String.to_integer(dist)
        %{depth: d + a * dist, distance: x + dist, aim: a}

      "down " <> dist, position ->
        %{position | aim: position.aim + String.to_integer(dist)}

      "up " <> dist, position ->
        %{position | aim: position.aim - String.to_integer(dist)}
    end)
  end
end
