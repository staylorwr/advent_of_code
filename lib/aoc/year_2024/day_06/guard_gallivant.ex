defmodule Aoc.Year2024.Day06.GuardGallivant do
  alias __MODULE__.{State, Parser}

  def part_1(input) do
    input
    |> Parser.parse()
    |> State.new()
    |> State.walk_until_return()
    |> Map.get(:moves)
    |> Enum.map(fn {_dir, pos} -> pos end)
    |> Enum.uniq()
    |> Enum.count()
    |> then(&(&1 - 1))
  end

  def part_2(input) do
    input
    |> Parser.parse()
  end

  defmodule Parser do
    def parse(input) do
      coords =
        input
        |> String.split("\n", trim: true)
        |> Enum.with_index()
        |> Enum.flat_map(fn {line, x} ->
          line
          |> String.codepoints()
          |> Enum.with_index()
          |> Enum.map(fn {char, y} ->
            {{x, y}, char}
          end)
        end)

      {
        Enum.map(coords, &to_space/1),
        find_starting_position(coords)
      }
    end

    defp to_space({coords, "#"}), do: {coords, :obstacle}
    defp to_space({coords, _}), do: {coords, :empty}

    defp find_starting_position(coords) do
      {start_coords, _start_str} =
        Enum.find(coords, fn {_coords, dir} -> dir == "^" end)

      {:up, start_coords}
    end
  end

  defmodule State do
    alias __MODULE__

    @type direction :: :up | :left | :down | :right

    @type space :: :obstacle | :empty

    @type coordinate :: {integer, integer}

    @type position :: {direction, {integer, integer}}

    @type level :: %{required(coordinate) => space}

    @type t :: %State{
            max_coordinate: coordinate,
            current_position: position,
            original_position: position,
            moves: list(position),
            level: level
          }

    defstruct [:current_position, :original_position, :moves, :level, :max_coordinate]

    def new({map, initial_position}) do
      {max_coordinate, _} = Enum.max_by(map, fn {{x, y}, _} -> x + y end)

      %State{
        max_coordinate: max_coordinate,
        current_position: initial_position,
        original_position: initial_position,
        moves: [initial_position],
        level: Enum.into(map, %{})
      }
    end

    def walk_until_return(state) do
      new_state = go_to_next_position(state)

      if !in_bounds?(new_state) do
        new_state
      else
        walk_until_return(new_state)
      end
    end

    defp in_bounds?(%{current_position: {_dir, {x, y}}}) when x < 0 or y < 0, do: false

    defp in_bounds?(%{current_position: {_dir, {x, y}}, max_coordinate: {x_m, y_m}})
         when x > x_m or y > y_m,
         do: false

    defp in_bounds?(_), do: true

    def go_to_next_position(state) do
      ahead = next_coord(state.current_position)

      {current_dir, _current_coord} = state.current_position

      blocked? = Map.get(state.level, ahead) == :obstacle

      new_pos =
        if blocked?, do: turn_and_move(state.current_position), else: {current_dir, ahead}

      %{
        state
        | current_position: new_pos,
          moves: state.moves ++ [new_pos]
      }
    end

    def turn_and_move({:up, coords}), do: {:right, next_coord(:right, coords)}
    def turn_and_move({:right, coords}), do: {:down, next_coord(:down, coords)}
    def turn_and_move({:down, coords}), do: {:left, next_coord(:left, coords)}
    def turn_and_move({:left, coords}), do: {:up, next_coord(:up, coords)}

    defp next_coord(dir, coord), do: next_coord({dir, coord})

    defp next_coord({:up, {x, y}}), do: {x - 1, y}
    defp next_coord({:down, {x, y}}), do: {x + 1, y}
    defp next_coord({:left, {x, y}}), do: {x, y - 1}
    defp next_coord({:right, {x, y}}), do: {x, y + 1}
  end
end
