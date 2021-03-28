defmodule Gameoflife.Game.Board do
  alias Gameoflife.Game.Board

  defstruct width: 10, height: 20

  defguard is_inbound(i, size) when i >= 0 and i < size

  def neighbours_of(%Board{width: w, height: h}, i) do
    t = neighbour_top(w, h, i)
    b = neighbour_bottom(w, h, i)
    l = neighbour_left(w, h, i)
    r = neighbour_right(w, h, i)

    [
      neighbour_left(w, h, t),
      t,
      neighbour_right(w, h, t),
      l,
      r,
      neighbour_left(w, h, b),
      b,
      neighbour_right(w, h, b)
    ]
    |> Enum.filter(&(&1 != nil))
  end

  def neighbour_top(w, h, i) when is_integer(i) and is_inbound(i - w, w * h), do: i - w
  def neighbour_top(_, _, _), do: nil
  def neighbour_bottom(w, h, i) when is_integer(i) and is_inbound(i + w, w * h), do: i + w
  def neighbour_bottom(_, _, _), do: nil

  def neighbour_left(w, h, i)
      when is_integer(i) and rem(i, w) != 0 and is_inbound(i - 1, w * h),
      do: i - 1

  def neighbour_left(_, _, _), do: nil

  def neighbour_right(w, h, i)
      when is_integer(i) and rem(i + 1, w) != 0 and is_inbound(i + 1, w * h),
      do: i + 1

  def neighbour_right(_, _, _), do: nil
end
