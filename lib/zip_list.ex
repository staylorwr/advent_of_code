defmodule ZipList do
  @moduledoc """
  Circular zipper
  """

  def new() do
    {[], []}
  end

  def insert({pre, post}, value) do
    {pre, [value | post]}
  end

  def prev({[], post}) do
    [current | pre] = Enum.reverse(post)
    {pre, [current]}
  end

  def prev({[value | pre], post}) do
    {pre, [value | post]}
  end

  def next({[], []} = list), do: list
  def next({pre, [current]}), do: {[], Enum.reverse([current | pre])}

  def next({pre, [value | post]}) do
    {[value | pre], post}
  end

  def delete({pre, [_value | post]}) do
    {pre, post}
  end

  def current({_, [current | _post]}) do
    current
  end

  def to_list({pre, post}) do
    Enum.reverse(pre) ++ post
  end
end
