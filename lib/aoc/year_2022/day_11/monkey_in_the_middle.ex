defmodule Aoc.Year2022.Day11.MonkeyintheMiddle do
  alias __MODULE__.{Monkey, Parser, Part1, State}

  def part_1(input) do
    input
    |> Parser.parse()
    |> State.new(:part_1)
    |> Part1.solve(20)
  end

  def part_2(input) do
    input
    |> Parser.parse()
    |> State.new(:part_2)
    |> Part1.solve(10_000)
  end

  defmodule Part1 do
    def solve(state, rounds) do
      state
      |> Stream.iterate(&run_round/1)
      |> Enum.at(rounds)
      |> then(&Map.values(&1.monkeys))
      |> Enum.sort_by(& &1.inspections, :desc)
      |> Enum.take(2)
      |> Enum.map(& &1.inspections)
      |> Enum.reduce(&Kernel.*/2)
    end

    def run_round(state) do
      state.monkeys
      |> Map.keys()
      |> Enum.reduce(state, &run_turn/2)
      |> then(&%{&1 | round: &1.round + 1})
    end

    def run_turn(index, state) do
      monkey = state.monkeys[index]
      state = Enum.reduce(monkey.items, state, &run_item(index, &2, &1))
      inspections = monkey.inspections + length(monkey.items)
      monkey = %{monkey | items: [], inspections: inspections}
      %{state | monkeys: Map.put(state.monkeys, index, monkey)}
    end

    defp run_item(index, state, old) do
      m = state.monkeys[index]
      factor = if m.factor == :old, do: old, else: m.factor
      new = apply(Kernel, m.operator, [old, factor])
      level = state.relief.(new)
      id = if rem(level, m.divisor) == 0, do: m.true_target, else: m.false_target
      m2 = state.monkeys[id]
      m2 = %{m2 | items: m2.items ++ [level]}
      %{state | monkeys: Map.put(state.monkeys, id, m2)}
    end
  end

  defmodule State do
    @enforce_keys [:monkeys, :relief]
    defstruct round: 0, monkeys: %{}, relief: nil

    def new(monkeys, :part_1) do
      %__MODULE__{monkeys: monkeys, relief: &div(&1, 3)}
    end

    def new(monkeys, :part_2) do
      lcm = monkeys |> Map.values() |> Enum.map(& &1.divisor) |> Enum.product()
      %__MODULE__{monkeys: monkeys, relief: &rem(&1, lcm)}
    end
  end

  defmodule Monkey do
    @enforce_keys [:id, :items, :operator, :factor, :divisor, :true_target, :false_target]
    defstruct id: 0,
              items: [],
              operator: :+,
              factor: :old,
              divisor: 1,
              true_target: 0,
              false_target: 0,
              inspections: 0

    def new(id, items, operator, factor, divisor, true_target, false_target) do
      %__MODULE__{
        id: id,
        items: items,
        operator: operator,
        factor: factor,
        divisor: divisor,
        true_target: true_target,
        false_target: false_target
      }
    end
  end

  defmodule Parser do
    def parse(input) do
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.chunk_every(7, 7, [""])
      |> Enum.map(&parse_monkey/1)
      |> Enum.map(&{&1.id, &1})
      |> Map.new()
    end

    def parse_monkey([a, b, c, d, e, f, _g]) do
      [id] = scan_ints(a)
      items = scan_ints(b)
      [divisor] = scan_ints(d)
      [true_target, false_target] = scan_ints(e <> f)
      {operator, factor} = scan_operator(c)
      Monkey.new(id, items, operator, factor, divisor, true_target, false_target)
    end

    defp scan_ints(text) do
      ~r/\d+/
      |> Regex.scan(text)
      |> List.flatten()
      |> Enum.map(&String.to_integer/1)
    end

    def scan_operator(text) do
      [op, factor] = text |> String.split(" ") |> Enum.drop(6)
      {String.to_atom(op), parse_factor(factor)}
    end

    def parse_factor("old"), do: :old
    def parse_factor(val), do: String.to_integer(val)
  end
end
