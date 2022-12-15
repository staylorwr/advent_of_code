defmodule Aoc.Year2022.Day13.DistressSignal do
  alias __MODULE__.{Parser, Part1, Part2}

  def part_1(input) do
    input
    |> Parser.parse()
    |> Part1.solve()
  end

  def part_2(input) do
    input
    |> Parser.parse()
    |> Part1.solve_2()
  end

  defmodule Part1 do
    def solve(pairs) do
      pairs
      |> Enum.with_index(1)
      |> Enum.filter(fn {pair, _index} -> ord?(pair) end)
      |> Enum.map(fn {_pair, index} -> index end)
      |> Enum.sum()
    end

    @dividers [[[2]], [[6]]]

    def solve_2(pairs) do
      pairs
      |> Enum.flat_map(fn {l, r} -> [l, r] end)
      |> Kernel.++(@dividers)
      |> Enum.sort(&ord?/2)
      |> Enum.with_index(1)
      |> Enum.filter(fn {x, _i} -> x in @dividers end)
      |> Enum.map(fn {_x, i} -> i end)
      |> Enum.product()
    end

    def ord?({left, right}), do: ord?(left, right)
    def ord?(l, r) when is_integer(l) and is_integer(r) and l < r, do: true
    def ord?(l, r) when is_integer(l) and is_integer(r) and l > r, do: false
    def ord?(x, x) when is_integer(x), do: :continue

    def ord?([lh | lt], [rh | rt]),
      do: if(is_boolean(r = ord?(lh, rh)), do: r, else: ord?(lt, rt))

    def ord?([], [_ | _]), do: true
    def ord?([_ | _], []), do: false
    def ord?([], []), do: :continue
    def ord?(l, r) when is_list(l) and is_integer(r), do: ord?(l, [r])
    def ord?(l, r) when is_integer(l) and is_list(r), do: ord?([l], r)
  end

  defmodule Part2 do
    def solve(input) do
      input
    end
  end

  defmodule Parser do
    def parse(input) do
      input
      |> String.split("\n\n", trim: true)
      |> Enum.map(&parse_pair/1)
    end

    def parse_pair(pair) do
      pair
      |> String.split("\n")
      |> Enum.map(fn part ->
        part
        |> Code.eval_string()
        |> elem(0)
      end)
      |> List.to_tuple()
    end
  end
end
