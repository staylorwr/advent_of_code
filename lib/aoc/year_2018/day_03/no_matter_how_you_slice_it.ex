defmodule Aoc.Year2018.Day03.NoMatterHowYouSliceIt do
  @moduledoc """
  ## --- Day 3: No Matter How You Slice It ---

  The Elves managed to locate the chimney-squeeze prototype fabric for Santa's
  suit (thanks to someone who helpfully wrote its box IDs on the wall of the
  warehouse in the middle of the night). Unfortunately, anomalies are still
  affecting them - nobody can even agree on how to *cut* the fabric.

  The whole piece of fabric they're working on is a very large square - at least
  `1000` inches on each side.

  Each Elf has made a *claim* about which area of fabric would be ideal for
  Santa's suit. All claims have an ID and consist of a single rectangle with edges
  parallel to the edges of the fabric. Each claim's rectangle is defined as
  follows:

  - The number of inches between the left edge of the fabric and the left edge of the rectangle.
  - The number of inches between the top edge of the fabric and the top edge of the rectangle.
  - The width of the rectangle in inches.
  - The height of the rectangle in inches.
  A claim like `#123 @ 3,2: 5x4` means that claim ID `123` specifies a rectangle
  `3` inches from the left edge, `2` inches from the top edge, `5` inches wide,
  and `4` inches tall. Visually, it claims the square inches of fabric represented
  by `#` (and ignores the square inches of fabric represented by `.`) in the
  diagram below:

  ```
  ...........
  ...........
  ...#####...
  ...#####...
  ...#####...
  ...#####...
  ...........
  ...........
  ...........
  ```

  The problem is that many of the claims *overlap*, causing two or more claims to
  cover part of the same areas. For example, consider the following claims:

  ```
  #1 @ 1,3: 4x4
  #2 @ 3,1: 4x4
  #3 @ 5,5: 2x2
  ```
  Visually, these claim the following areas:

  ```
  ........
  ...2222.
  ...2222.
  .11XX22.
  .11XX22.
  .111133.
  .111133.
  ........
  ```

  The four square inches marked with `X` are claimed by *both `1` and `2`*. (Claim
  `3`, while adjacent to the others, does not overlap either of them.)

  If the Elves all proceed with their own plans, none of them will have enough
  fabric. *How many square inches of fabric are within two or more claims?*
  """

  @doc """
  Count the number of points of overlap
  """
  def part_1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(%{}, &overlaps/2)
    |> Enum.count(fn {_x, claims} -> MapSet.size(claims) >= 2 end)
  end

  @doc """
  Find the single claim that does not have any conflicts
  """
  def part_2(input) do
    claims = String.split(input, "\n", trim: true)

    sizes = claims |> Enum.map(&id_and_area_of_claim/1) |> Enum.into(%{})

    claims
    |> Enum.reduce(%{}, &overlaps/2)
    |> Enum.filter(fn {_cords, claims} -> MapSet.size(claims) == 1 end)
    |> Enum.group_by(fn {_cords, claims} ->
      [claim] = MapSet.to_list(claims)
      claim
    end)
    |> Enum.map(fn {claim, squares} ->
      {claim, Enum.count(squares)}
    end)
    |> Enum.find(fn {id, size} ->
      size == Map.get(sizes, id)
    end)
  end

  @re ~r/#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/
  defp overlaps(claim, claimed) do
    [id, x, y, w, h] =
      Regex.run(@re, claim, capture: :all_but_first) |> Enum.map(&String.to_integer/1)

    squares = for x_s <- x..(x + w - 1), y_s <- y..(y + h - 1), do: {x_s, y_s, id}

    Enum.reduce(squares, claimed, fn {x_c, y_c, id}, claims ->
      ids = Map.get(claims, {x_c, y_c}, MapSet.new())
      Map.put(claims, {x_c, y_c}, MapSet.put(ids, id))
    end)
  end

  defp id_and_area_of_claim(claim) do
    [id, _x, _y, w, h] =
      Regex.run(@re, claim, capture: :all_but_first) |> Enum.map(&String.to_integer/1)

    {id, w * h}
  end
end
