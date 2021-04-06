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

  defmemo(top(i, {w, h}) when is_integer(i) and is_inbound(i - w, w * h), do: i - w)
  defmemo(top(_, _), do: nil)
  defmemo(bottom(i, {w, h}) when is_integer(i) and is_inbound(i + w, w * h), do: i + w)
  defmemo(bottom(_, _), do: nil)

  defmemo(
    left(i, {w, h})
    when is_integer(i) and rem(i, w) != 0 and is_inbound(i - 1, w * h),
    do: i - 1
  )

  defmemo(left(_, _), do: nil)

  defmemo(
    right(i, {w, h})
    when is_integer(i) and rem(i + 1, w) != 0 and is_inbound(i + 1, w * h),
    do: i + 1
  )

  defmemo(right(_, _), do: nil)

  defmemo(top_left(i, d), do: i |> top(d) |> left(d))
  defmemo(top_right(i, d), do: i |> top(d) |> right(d))
  defmemo(bottom_left(i, d), do: i |> bottom(d) |> left(d))
  defmemo(bottom_right(i, d), do: i |> bottom(d) |> right(d))
end
