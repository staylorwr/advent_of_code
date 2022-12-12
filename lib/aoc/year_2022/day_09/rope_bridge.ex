defmodule Aoc.Year2022.Day09.RopeBridge do
  alias __MODULE__.{Parser, State}

  def part_1(input) do
    instructions = Parser.parse(input)

    2
    |> State.new()
    |> State.walk(instructions)
    |> Map.get(:visited)
    |> MapSet.size()
  end

  def part_2(input) do
    instructions = Parser.parse(input)

    10
    |> State.new()
    |> State.walk(instructions)
    |> Map.get(:visited)
    |> MapSet.size()
  end

  defmodule Parser do
    def parse(input) do
      input
      |> String.split("\n", trim: true)
      |> Enum.flat_map(&parse_line/1)
    end

    def parse_line(<<dir::binary-size(1), " ", count::binary>>) do
      List.duplicate(dir, String.to_integer(count))
    end
  end

  defmodule State do
    defstruct knots: [], visited: MapSet.new()

    def new(knot_count) do
      %__MODULE__{knots: List.duplicate({0, 0}, knot_count)}
    end

    def walk(state, instructions) do
      Enum.reduce(instructions, state, &walk_step/2)
    end

    def walk_step(direction, %{knots: [head | tail]} = state) do
      direction
      |> move_head(head)
      |> move_tail(tail)
      |> update_state(state)
    end

    def move_head("R", {x, y}), do: {x + 1, y}
    def move_head("L", {x, y}), do: {x - 1, y}
    def move_head("U", {x, y}), do: {x, y + 1}
    def move_head("D", {x, y}), do: {x, y - 1}

    def move_tail(head, tail) do
      {head, Enum.map_reduce(tail, head, &move_knot/2)}
    end

    def move_knot(knot, last) do
      last
      |> sub_pos(knot)
      |> follow
      |> add_pos(knot)
      |> then(&{&1, &1})
    end

    def add_pos({x1, y1}, {x2, y2}), do: {x1 + x2, y1 + y2}

    def sub_pos({x1, y1}, {x2, y2}), do: {x1 - x2, y1 - y2}

    def follow({xd, yd}) when abs(xd) <= 1 and abs(yd) <= 1, do: {0, 0}
    def follow({xd, yd}), do: {clamp(xd), clamp(yd)}

    defp update_state({head, {tail, last}}, state) do
      %{state | knots: [head | tail], visited: MapSet.put(state.visited, last)}
    end

    defp clamp(0), do: 0
    defp clamp(n), do: div(n, abs(n))
  end
end
