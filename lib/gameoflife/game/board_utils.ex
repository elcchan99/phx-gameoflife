defmodule Gameoflife.Game.BoardUtils do
  use Memoize

  defguard is_inbound(i, size) when i >= 0 and i < size

  defmemo neighbours_of(i, dimension) do
    t = top(i, dimension)
    b = bottom(i, dimension)
    l = left(i, dimension)
    r = right(i, dimension)

    [
      left(t, dimension),
      t,
      right(t, dimension),
      l,
      r,
      left(b, dimension),
      b,
      right(b, dimension)
    ]
    |> Enum.filter(&(&1 != nil))
  end

  def top(i, {w, h}) when is_integer(i) and is_inbound(i - w, w * h), do: i - w
  def top(_, _), do: nil
  def bottom(i, {w, h}) when is_integer(i) and is_inbound(i + w, w * h), do: i + w
  def bottom(_, _), do: nil

  def left(i, {w, h})
      when is_integer(i) and rem(i, w) != 0 and is_inbound(i - 1, w * h),
      do: i - 1

  def left(_, _), do: nil

  def right(i, {w, h})
      when is_integer(i) and rem(i + 1, w) != 0 and is_inbound(i + 1, w * h),
      do: i + 1

  def right(_, _), do: nil
end
