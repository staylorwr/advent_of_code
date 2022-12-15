defmodule Aoc.Year2022.Day12.HillClimbingAlgorithm do
  alias __MODULE__.{Parser, Part1, Part2}

  def part_1(input) do
    input
    |> Parser.parse()
    |> Part1.solve()
  end

  def part_2(input) do
    input
    |> Parser.parse()
    |> Part2.solve()
  end

  defmodule Part1 do
    def solve({_grid, graph, {start, finish}}) do
      path = Graph.get_shortest_path(graph, start, finish)
      if is_nil(path), do: nil, else: path |> length() |> Kernel.-(1)
    end
  end

  defmodule Part2 do
    def solve({grid, graph, {_start, finish}}) do
      grid
      |> Enum.filter(fn {_k, v} -> v == 0 end)
      |> Enum.into([], fn {k, _v} -> k end)
      |> Enum.map(fn start ->
        Part1.solve({grid, graph, {start, finish}})
      end)
      |> Enum.reject(&is_nil/1)
      |> Enum.min()
    end
  end

  defmodule Parser do
    def parse(input) do
      {grid, graph, start_finish} =
        for {line, y} <- input |> String.split("\n") |> Enum.with_index(),
            {char, x} <- line |> String.to_charlist() |> Enum.with_index(),
            reduce: {%{}, Graph.new(), {0, 0}} do
          {grid, graph, start_end} ->
            {graph, node_val, {s, e}} = add_point_to_graph(char, {x, y}, graph, start_end)

            {Map.put(grid, {x, y}, node_val), graph, {s, e}}
        end

      graph = Enum.reduce(grid, graph, &build_graph_edge(&1, &2, grid))

      {grid, graph, start_finish}
    end

    def add_point_to_graph(?S, point, graph, {_s, e}) do
      {Graph.add_vertex(graph, point, label: :start), 0, {point, e}}
    end

    def add_point_to_graph(?E, point, graph, {s, _e}) do
      {Graph.add_vertex(graph, point, label: :end), 25, {s, point}}
    end

    def add_point_to_graph(other, point, graph, start_and_end) do
      {Graph.add_vertex(graph, point), other - ?a, start_and_end}
    end

    def build_graph_edge({{x, y}, val}, graph, grid) do
      neighbors = for x <- -1..1, y <- -1..1, x != y and x + y != 0, do: {x, y}

      for {dx, dy} <- neighbors, grid[{x + dx, y + dy}] != nil, reduce: graph do
        g ->
          neighbor_val = grid[{x + dx, y + dy}]

          if neighbor_val - val <= 1 do
            Graph.add_edge(g, {x, y}, {x + dx, y + dy})
          else
            g
          end
      end
    end
  end
end
