defmodule Aoc.Year2021.Day14.ExtendedPolymerization do
  @doc """
  Parse a polymerization reaction initial state and rules.

  Then apply the rules to the chain `n` times.

  Returns the quantity of the most common element and
  subtract the quantity of the least common element?
  """
  def react(input, n) do
    {initial_state, rules} = parse(input)

    end_state = react(initial_state, rules, n)

    end_state
    |> Enum.map(fn {[l | _], count} -> {l, count} end)
    |> Enum.reduce(%{}, fn {x, count}, acc -> Map.update(acc, x, count, &(&1 + count)) end)
    |> Enum.map(&elem(&1, 1))
    |> Enum.min_max()
    |> then(fn {min, max} -> max - min end)
  end

  def parse(input) do
    [state, rules] = String.split(input, "\n\n", trim: true)
    {parse_state(state), parse_rules(rules)}
  end

  def parse_state(string) do
    string
    |> String.to_charlist()
    |> Enum.chunk_every(2, 1)
    |> Enum.frequencies()
  end

  def parse_rules(string) do
    string
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&parse_rule/1)
    |> Map.new()
  end

  def parse_rule(string) do
    [cl, [c]] =
      string
      |> String.split(" -> ")
      |> Enum.map(&String.to_charlist/1)

    {cl, c}
  end

  def react(state, _rules, 0), do: state
  def react(state, rules, n), do: state |> step(rules) |> react(rules, n - 1)

  def step(pairs, rules) do
    pairs
    |> Enum.flat_map(fn
      {pair = [l, r], count} ->
        c = rules[pair]
        [{[l, c], count}, {[c, r], count}]

      {pair, count} ->
        [{pair, count}]
    end)
    |> Enum.reduce(%{}, fn {pair, count}, map -> Map.update(map, pair, count, &(&1 + count)) end)
  end
end
