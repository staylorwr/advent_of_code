defmodule Aoc.Year2021.Day17.TrickShot do
  @doc """
  What is the highest possible y value that a probe
  can reach while still stopping in the target area?

  X and Y velocity are independent and affected by
  independent forces (gravity and drag) so we can
  safely ignore the X parameter and calculate the y
  value alone.

  Balls fall with the same velocity as going up
  Fastest falling speed => from 0 to y (bottom of target)
  in one step, otherwise we miss.

  Downward speed during drop from 0 to y -> -y
  Downward speed during previous step: -y - 1 => equal to upward velocity


          #
         ###
        #####

  This is a [triangular number](https://en.wikipedia.org/wiki/Triangular_number)
  """
  def part_1({_x, y1.._}) do
    div(y1 * (y1 + 1), 2)
  end

  @doc """
  How many distinct trajectories land the probe into the target area?
  """
  def part_2(target) do
    target
    |> candidates()
    |> Stream.map(&path(&1, target))
    |> Stream.filter(&in?(&1, target))
    |> Enum.count()
  end

  @doc """
  We overshoot the target if we shoot faster than it's furthest edge
  We undershoot the target if we don't have enough speed to reach it's
  closest edge.

  max y -> part 1 solution
  min x -> calculate minimum velocity we need to reach min x:

  #       v(v+1)/2 = x_min
  #         v(v+1) = 2 x_min
  #        v^2 + v = 2 x_min
  #  v^2 + v + 1/4 = 2 x_min + 1/4
  #    (v + 1/2)^2 = 2 x_min + 1/4
  #        v + 1/2 = sqrt(2 x_min + 1/4)
  #              v = sqrt(2 x_min + 1/4) - 1/2
  """
  def candidates({x1..x2, y1.._}) do
    min_x = trunc(:math.sqrt(2 * x1 - 1 / 4) - 1 / 2)
    for x <- min_x..x2, y <- y1..(-y1 - 1), do: {x, y}
  end

  @doc """
  Produce the path of a given initial velocity up until it passes
  through the max edge of the target area.
  """
  def path(v, target) do
    {v, {0, 0}}
    |> Stream.iterate(&step/1)
    |> Stream.map(&elem(&1, 1))
    |> Stream.take_while(&(not past?(&1, target)))
  end

  def in?({px, py}, {rx, ry}), do: px in rx and py in ry
  def in?(path, target), do: Enum.any?(path, &in?(&1, target))

  def past?({px, py}, {tx1..tx2, ty1..ty2}) do
    px > max(tx1, tx2) or py < min(ty1, ty2)
  end

  @doc """
  """
  def step({{vx, vy}, {x, y}}) when vx > 0 do
    {{vx - 1, vy - 1}, {x + vx, y + vy}}
  end

  def step({{vx, vy}, {x, y}}) when vx < 0 do
    {{vx + 1, vy - 1}, {x + vx, y + vy}}
  end

  def step({{0, vy}, {x, y}}) do
    {{0, vy - 1}, {x, y + vy}}
  end
end
