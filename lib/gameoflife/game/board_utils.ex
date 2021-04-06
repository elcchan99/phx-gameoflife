defmodule Gameoflife.Game.BoardUtils do
  use Memoize

  defguard is_inbound(i, size) when i >= 0 and i < size

  defmemo neighbours_of(i, dimension) do
    t = neighbour_top(i, dimension)
    b = neighbour_bottom(i, dimension)
    l = neighbour_left(i, dimension)
    r = neighbour_right(i, dimension)

    [
      neighbour_left(t, dimension),
      t,
      neighbour_right(t, dimension),
      l,
      r,
      neighbour_left(b, dimension),
      b,
      neighbour_right(b, dimension)
    ]
    |> Enum.filter(&(&1 != nil))
  end

  def neighbour_top(i, {w, h}) when is_integer(i) and is_inbound(i - w, w * h), do: i - w
  def neighbour_top(_, _), do: nil
  def neighbour_bottom(i, {w, h}) when is_integer(i) and is_inbound(i + w, w * h), do: i + w
  def neighbour_bottom(_, _), do: nil

  def neighbour_left(i, {w, h})
      when is_integer(i) and rem(i, w) != 0 and is_inbound(i - 1, w * h),
      do: i - 1

  def neighbour_left(_, _), do: nil

  def neighbour_right(i, {w, h})
      when is_integer(i) and rem(i + 1, w) != 0 and is_inbound(i + 1, w * h),
      do: i + 1

  def neighbour_right(_, _), do: nil
end
