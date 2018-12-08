defmodule Aoc.Year2018.Day08.MemoryManeuver do
  @moduledoc """
  ## --- Day 8: Memory Maneuver ---

  The sleigh is much easier to pull than you'd expect for something its weight.
  Unfortunately, neither you nor the Elves know which way the North Pole is from
  here.

  You check your wrist device for anything that might help. It seems to have some
  kind of navigation system! Activating the navigation system produces more bad
  news: "Failed to start navigation system. Could not read software license file."

  The navigation system's license file consists of a list of numbers (your puzzle
  input). The numbers define a data structure which, when processed, produces some
  kind of tree that can be used to calculate the license number.

  The *tree* is made up of *nodes*; a single, outermost node forms the tree's
  *root*, and it contains all other nodes in the tree (or contains nodes that
  contain nodes, and so on).

  Specifically, a node consists of:

  - A *header*, which is always exactly two numbers:
  - The quantity of child nodes.
  - The quantity of metadata entries.

  - Zero or more *child nodes* (as specified in the header).
  - One or more *metadata entries* (as specified in the header).
  Each child node is itself a node that has its own header, child nodes, and
  metadata. For example:

  ```
  2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2
  A----------------------------------
      B----------- C-----------
                       D-----
  ```
  In this example, each node of the tree is also marked with an underline starting
  with a letter for easier identification. In it, there are four nodes:

  - `A`, which has `2` child nodes (`B`, `C`) and `3` metadata entries (`1`, `1`, `2`).
  - `B`, which has `0` child nodes and `3` metadata entries (`10`, `11`, `12`).
  - `C`, which has `1` child node (`D`) and `1` metadata entry (`2`).
  - `D`, which has `0` child nodes and `1` metadata entry (`99`).
  The first check done on the license file is to simply add up all of the metadata
  entries. In this example, that sum is `1+1+2+10+11+12+2+99=*138*`.

  *What is the sum of all metadata entries?*
  """

  defstruct children_size: 0, metadata_size: 0, children: [], metadata: []

  @doc """

  """
  def part_1(input) do
    input
    |> parse()
    |> traverse()
    |> elem(0)
    |> do_metadata_sum()
    |> Enum.sum()
  end

  defp do_metadata_sum(vertex) do
    children_metadata = Enum.flat_map(vertex.children, &do_metadata_sum/1)
    metadata = Tuple.to_list(vertex.metadata)
    children_metadata ++ metadata
  end

  @doc """

  """
  def part_2(input) do
    input
  end

  defp parse(input) do
    input
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
  end

  defp traverse([]), do: nil

  defp traverse([children_size, metadata_size | tail]) do
    {%__MODULE__{children_size: children_size, metadata_size: metadata_size}, tail}
    |> traverse_children()
    |> traverse_metadata()
  end

  defp traverse_children({vertex, tail}) do
    if length(vertex.children) == vertex.children_size do
      {vertex, tail}
    else
      {child, rest} = traverse(tail)
      vertex = Map.update(vertex, :children, [], &(&1 ++ [child]))
      traverse_children({vertex, rest})
    end
  end

  defp traverse_metadata({vertex, tail}) do
    {metadata, rest} = Enum.split(tail, vertex.metadata_size)

    {%{vertex | metadata: List.to_tuple(metadata)}, rest}
  end
end
